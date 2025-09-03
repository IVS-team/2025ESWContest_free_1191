#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import cv2
import json
import random
import math
import rospy
import numpy as np

# ROS 메시지 관련 import
from geometry_msgs.msg import Point, Vector3
from sensor_msgs.msg import CompressedImage
from ultralytics import YOLO

# 사용자 정의 메시지 & 서비스 import
from msg_pkg.msg import DetectedObject, DetectedObjectArray
from msg_pkg.srv import GetMapCompressed

# Homography 매퍼 (선택적)
try:
    from module.homography_mapper import HomographyMapper
except ImportError:
    HomographyMapper = None


# 차량 좌표계 기준 상대 좌표(dx, dy)를 UTM 전역 좌표로 변환
def relative_to_utm(vehicle_x: float, vehicle_y: float, heading_rad: float, dx: float, dy: float):
    dx_rot = dx * math.cos(heading_rad) - dy * math.sin(heading_rad)
    dy_rot = dx * math.sin(heading_rad) + dy * math.cos(heading_rad)
    ob_x = vehicle_x + dx_rot
    ob_y = vehicle_y + dy_rot
    return ob_x, ob_y


# JSON 파일 로드 함수
def load_json(path: str):
    with open(path, "r", encoding="utf-8") as f:
        print("haha")  # 디버깅 출력
        return json.load(f)


# ------------------- 메인 노드 클래스 -------------------
class InfraNode(object):
    def __init__(self):
        rospy.init_node("infra_node", anonymous=False)

        # 카메라 관련 파라미터
        self.cam_index = int(rospy.get_param("~cam_index", 0))
        self.width     = int(rospy.get_param("~width", 1280))
        self.height    = int(rospy.get_param("~height", 720))
        self.fps       = int(rospy.get_param("~fps", 30))
        self.show_win  = bool(rospy.get_param("~show_window", True))

        # JSON 파일 경로
        self.homography_config  = "config/homography_config.json"
        self.cctv_pose_json     = "config/cctv_pose.json"
        self.map_config_json    = "config/map_config.json"

        # 차량 위치 및 방향 초기값
        self.gps_x = 0.0
        self.gps_y = 0.0
        self.car_heading = 0.0  # 라디안

        # 맵 이미지 경로
        self.map_png_path = "map/map_image.png"

        # JSON 적용
        self._cctv_pose_config_json(self.cctv_pose_json)
        self._apply_map_config_json(self.map_config_json)

        # ROS 퍼블리셔 & 서비스 서버
        self.pt_pub = rospy.Publisher("/infra/object_coordinate", DetectedObjectArray, queue_size=50)
        self.srv_get_map = rospy.Service("~get_map_png", GetMapCompressed, self.on_get_map_png)

        # Homography 매퍼 초기화
        self.mapper = None
        if HomographyMapper is not None and os.path.exists(self.homography_config):
            try:
                hdata = load_json(self.homography_config)
                cctv_data = hdata["cctv"]
                topview_data = hdata["topview"]
                self.mapper = HomographyMapper(cctv_data["image_points"], cctv_data["vehicle_points"])
                self.topview_image_points = topview_data["image_points"]
                self.topview_vehicle_points = topview_data["vehicle_points"]
                rospy.loginfo("HomographyMapper loaded: %s", self.homography_config)
            except Exception as e:
                rospy.logwarn("HomographyMapper init failed: %s", str(e))
        else:
            rospy.logwarn("Homography disabled (module missing or config file not found).")

        # YOLO 모델 로드
        self.model = YOLO("model/yolo11n.pt")
        self.class_colors = {i: [random.randint(0, 255) for _ in range(3)]
                            for i in range(len(self.model.names))}
        self.W, self.H = self.width, self.height

        # 카메라 장치 열기
        self.cap = cv2.VideoCapture(self.cam_index, cv2.CAP_V4L2)
        self.cap.set(cv2.CAP_PROP_FRAME_WIDTH,  self.width)
        self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT, self.height)
        self.cap.set(cv2.CAP_PROP_FPS,          self.fps)
        self.cap.set(cv2.CAP_PROP_FOURCC,       cv2.VideoWriter_fourcc(*"MJPG"))
        self.cap.set(cv2.CAP_PROP_BUFFERSIZE,   1)
        if not self.cap.isOpened():
            rospy.logerr("카메라 열기 실패 (index=%d)", self.cam_index)
            raise RuntimeError("카메라 열기 실패")

        if self.show_win:
            cv2.namedWindow("YOLO Rel", cv2.WINDOW_NORMAL)

        # 맵 PNG 미리 로딩
        self.map_png_msg = self._load_png_as_compressed_image(self.map_png_path)
        if self.map_png_msg is None:
            rospy.logwarn("맵 PNG 선로딩 실패: %s", self.map_png_path)
        else:
            rospy.loginfo("맵 PNG 선로딩 완료: %s", self.map_png_path)

        self.rate = rospy.Rate(self.fps if self.fps > 0 else 30)
        rospy.loginfo("infra_node started (cam=%d, %dx%d@%dfps)", self.cam_index, self.width, self.height, self.fps)

    # CCTV 위치 JSON 적용
    def _cctv_pose_config_json(self, path: str):
        if not os.path.exists(path):
            rospy.logwarn("cctv_pose_json not found: %s", path)
            return
        try:
            v = load_json(path)
        except Exception as e:
            rospy.logwarn("cctv_pose_json parse failed: %s", str(e))
            return

        # 차량 GPS 위치, heading 값 적용
        if "tm_x" in v:  self.gps_x = float(v["tm_x"])
        if "tm_y" in v:  self.gps_y = float(v["tm_y"])
        if "heading_rad" in v:
            self.car_heading = float(v["heading_rad"])
        elif "heading_deg" in v:
            self.car_heading = float(v["heading_deg"]) * math.pi / 180.0

        rospy.loginfo("cctv pose loaded: gps_x=%.6f gps_y=%.6f heading(rad)=%.6f",
                    self.gps_x, self.gps_y, self.car_heading)
        
    # 맵 설정 JSON 적용
    def _apply_map_config_json(self, path: str):
        if not os.path.exists(path):
            rospy.logwarn("map_config_json not found: %s", path)
            return
        try:
            m = load_json(path)
        except Exception as e:
            rospy.logwarn("map_config_json parse failed: %s", str(e))
            return

        if "map_png_path" in m:
            self.map_png_path = str(m["map_png_path"])
            rospy.loginfo("Map PNG path set from JSON: %s", self.map_png_path)

    # 맵 PNG 서비스 콜백
    def on_get_map_png(self, _req):
        resp = GetMapCompressed()
        if self.map_png_msg is None:
            # 맵 로드 실패 시
            resp.success = False
            resp.message = "Map PNG is not loaded."
            resp.image   = CompressedImage()
            resp.image_points_px = [Point() for i in range(4)]
            resp.map_tm_points   = [Point() for i in range(4)]
            resp.yaw0_unit       = Vector3()
            return resp

        # 최신 타임스탬프 적용한 CompressedImage 생성
        out = CompressedImage()
        out.header.stamp = rospy.Time.now()
        out.format = self.map_png_msg.format
        out.data   = self.map_png_msg.data

        # 이미지 좌표 & 맵 좌표 리스트 생성
        img_list, vhc_list = [], []
        for i in range(4):
            p = Point(x=self.topview_image_points[i][0], y=self.topview_image_points[i][1], z=0.0)
            img_list.append(p)
            p = Point(x=self.topview_vehicle_points[i][0], y=self.topview_vehicle_points[i][1], z=0.0)
            vhc_list.append(p)

        # yaw 방향 단위 벡터 계산
        x0, y0 = self.mapper.ground_to_px_abs((0, 0))
        x1, y1 = self.mapper.ground_to_px_abs((0, 1))
        v = np.array((x0,y0)) - np.array((x1, y1))
        norm = np.linalg.norm(v)
        if norm == 0:
            raise ValueError("두 좌표가 같습니다. 단위 벡터를 만들 수 없습니다.")
        norm = v/norm
        vect = Vector3(x=norm[0], y=norm[1], z=0.0)

        return (True, "OK", out, img_list, vhc_list, vect)

    # PNG 로드 함수
    def _load_png_as_compressed_image(self, path: str):
        if not os.path.exists(path):
            rospy.logwarn("PNG not found: %s", path)
            return None

        img = cv2.imread(path, cv2.IMREAD_UNCHANGED)
        if img is None:
            rospy.logwarn("PNG read failed: %s", path)
            return None

        ok, buf = cv2.imencode(".png", img)
        if not ok:
            rospy.logwarn("PNG encode failed: %s", path)
            return None

        msg = CompressedImage()
        msg.header.stamp = rospy.Time.now()
        msg.format = "png"
        msg.data = bytearray(buf.tobytes())
        return msg

    # ---------------- 메인 루프 ----------------
    def spin(self):
        while not rospy.is_shutdown():
            ok, frame = self.cap.read()
            if not ok:
                rospy.logwarn_throttle(2.0, "프레임 읽기 실패")
                self.rate.sleep()
                continue

            # YOLO 추론
            result = self.model(frame, verbose=False)[0]
            boxes  = result.boxes
            names  = result.names

            # 결과 메시지 컨테이너 생성
            t = rospy.Time.now()
            obb = DetectedObjectArray()
            obb.header.stamp = t
            obb.header.frame_id = "infraObjectDection"  # frame_id 지정

            # 인식된 객체 처리
            if boxes is not None and len(boxes) > 0:
                for box in boxes:
                    cls_id = int(box.cls[0].item())
                    cls_name = names.get(cls_id, str(cls_id))
                    if cls_name not in ("person", "toothbrush"):  # 특정 객체만 추출
                        continue

                    # 바운딩박스 중심 좌표 (cx, cy)
                    x1, y1, x2, y2 = box.xyxy[0].tolist()
                    cx = (x1 + x2) * 0.5
                    cy = y2
                    conf = float(box.conf[0].item())

                    if self.mapper is not None:
                        # 픽셀 좌표 → 지상 상대좌표
                        r_x, r_y = self.mapper.px_to_ground_abs((cx, cy))
                        # 차량 heading 반영해서 전역 UTM 좌표 변환
                        g_x, g_y = relative_to_utm(self.gps_x, self.gps_y, self.car_heading, r_x, r_y)

                        # DetectedObject 메시지 생성
                        dt = DetectedObject()
                        dt.object_id = cls_id
                        dt.global_position = Point(x=g_x, y=g_y, z=0.0)
                        obb.objects.append(dt)

                        rospy.logdebug("obj=%s rel=(%.2f,%.2f) abs=(%.2f,%.2f) conf=%.2f",
                                       cls_name, r_x, r_y, g_x, g_y, conf)

                    # 시각화 표시
                    if self.show_win:
                        color = self.class_colors.get(cls_id, (255, 0, 0))
                        cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), color, 2)
                        cv2.circle(frame, (int(cx), int(cy)), 5, color, -1)
                        cv2.putText(frame, f"{cls_name} {conf:.2f} ({r_x:.2f},{r_y:.2f})",
                                    (int(x1), max(0, int(y1) - 8)),
                                    cv2.FONT_HERSHEY_SIMPLEX, 0.6, color, 2)

            # 결과 퍼블리시
            self.pt_pub.publish(obb)

            # 디스플레이
            if self.show_win:
                cv2.imshow("YOLO Rel", frame)
                key = cv2.waitKey(1) & 0xFF
                if key in (ord('q'), 27):  # 'q' 또는 ESC
                    break

            self.rate.sleep()

        # 종료 시 처리
        self.cap.release()
        if self.show_win:
            cv2.destroyAllWindows()


# ------------------- 실행부 -------------------
if __name__ == "__main__":
    try:
        node = InfraNode()
        node.spin()
    except rospy.ROSInterruptException:
        pass
