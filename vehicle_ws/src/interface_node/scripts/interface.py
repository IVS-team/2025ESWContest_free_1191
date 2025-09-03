#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
@file display_node.py
@brief 차량 UI 디스플레이 노드

- ROS 토픽(/car_10876/processed_objects) 구독
- 프론트뷰(실시간 카메라) + 탑뷰(맵 이미지) 합성 디스플레이
- 객체 위험도에 따른 아이콘 표시 및 경고음 재생
- 차량 아이콘을 탑뷰 맵 위에 회전/위치 표시
"""

import rospy
import cv2
import numpy as np
import time
import math
import os
import rospkg
import json

import subprocess
from msg_pkg.msg import ProcessedObjectArray
from homography_mapper import HomographyMapper
from cv_bridge import CvBridge

class InterfaceNode(object):
    def __init__(self):
        #person image
        self.BASE_IMAGE_WIDTH_PX = 120
        self.FIXED_DISPLAY_Y = 200
        self.BLINK_INTERVAL = 0.5

        self.last_blink_time = time.time()
        
        #camera
        self.FRAME_WIDTH, self.FRAME_HEIGHT = 1280, 720
        self.last_msg_time = 0.0
        self.blink_on = True
        self.last_sound_time = 0.0
        self.sound_intervals = {'red': 0.2, 'yellow': 0.5}

        #object, vehicle
        self.latest_objects_list = []
        self.latest_car_position = None
        self.latest_vehicle_yaw = 0.0  # 필요 시 확장
        # top view image yaw0
        self.yaw0_unit = (1.0, 0.0)
        self.yaw0_rad  = 0.0

        rospack = rospkg.RosPack()
        self.pkg_path = rospack.get_path('interface_node')
        self.ALSA_DEVICE = rospy.get_param("~alsa_device", None)
        
        # 리소스 로드
        self.risk_images = self.init_person_image(self.pkg_path)
        self.car_img_topview = self.load_and_resize_image(self.pkg_path, 'car_topview.png', (80, 80))
        self.human_img_topview = self.load_and_resize_image(self.pkg_path, 'human.png', (80, 80))

        # 카메라 초기화
        self.use_camera, self.cap = self.init_cam()

        # 맵/호모그래피 구성
        self.latest_map_image = None
        self.mapper_topview = None
        self._load_topview_config()

        # 프론트뷰용 고정 호모그래피(상대좌표 → 픽셀)
        self.mapper = self._load_frontview_config()

        # 구독
        rospy.Subscriber('/car_10876/processed_objects', ProcessedObjectArray, self.objects_callback)

        

    # --- 설정/리소스 로드 ---
    # topview
    def _load_topview_config(self):
        cfg_param = rospy.get_param("~topview_config_path", "config/topview_config.json")
        cfg_path = self._resolve_path(cfg_param, self.pkg_path)

        try:
            with open(cfg_path, "r") as f:
                cfg = json.load(f)
        except Exception as e:
            rospy.logerr("Failed to open/read topview config: %s (%s)", cfg_path, e)
            # 폴백: 빈 맵
            self.latest_map_image = np.zeros((720, 540, 3), dtype=np.uint8)
            self.mapper_topview = None
            return

        # 1) 맵 이미지 로드
        map_image_raw = cfg.get("map_image_path", "")
        img_path = self._resolve_path(map_image_raw, os.path.dirname(cfg_path))

        img = cv2.imread(img_path, cv2.IMREAD_UNCHANGED)
        rospy.loginfo("map_image_path(resolved): %s, imread ok? %s",
                    img_path, "yes" if img is not None else "no")
        
        if img is None:
            # 맵 이미지가 없으면 검은 배경으로 대체
            self.latest_map_image = np.zeros((720, 540, 3), dtype=np.uint8)
            self.mapper_topview = None
        else:
            # 원본 해상도 유지
            self.latest_map_image = img

            # 2) 호모그래피 구성(픽셀 4점 ↔ 차량 TM 좌표 4점)
            image_points = cfg["image_points_px"]        # [[u,v] x4]
            vehicle_points_tm = cfg["vehicle_points_tm"] # [[x,y] x4]
            self.mapper_topview = HomographyMapper(image_points, vehicle_points_tm)

        # 3) yaw0 기준벡터([ux, uy]) 로드
        yaw0 = cfg.get("yaw0_unit", [1.0, 0.0])         # [ux, uy]
        self.yaw0_unit = (float(yaw0[0]), float(yaw0[1]))
        self.yaw0_rad  = math.atan2(self.yaw0_unit[1], self.yaw0_unit[0])
        
    #vehicle, person image
    def load_and_resize_image(self, pkg_path, filename, size=(80, 80)):
        img_path = os.path.join(pkg_path, 'images', filename)
        img = cv2.imread(img_path, cv2.IMREAD_UNCHANGED)
        if img is None:
            rospy.logerr("Failed to load image: {}".format(img_path))
            return None
        return cv2.resize(img, size)
    
    def init_person_image(self, pkg_path):
        risk_images = {}
        image_names = {
            'red': 'person_red.png',
            'yellow': 'person_yellow.png',
            'green': 'person_green.png'
        }
        for key, filename in image_names.items():
            img_path = os.path.join(pkg_path, 'images', filename)
            img = cv2.imread(img_path, cv2.IMREAD_UNCHANGED)
            if img is None:
                rospy.logerr("Failed to load image: {}".format(img_path))
            else:
                risk_images[key] = img
        return risk_images

    #frontview
    def _load_frontview_config(self):
        cfg_param = rospy.get_param("~frontview_config_path", "config/frontview_config.json")
        cfg_path = self._resolve_path(cfg_param, self.pkg_path)

        if os.path.exists(cfg_path):
            try:
                with open(cfg_path, "r") as f:
                    cfg = json.load(f)
                image_points = cfg.get("image_points", None)
                vehicle_points = cfg.get("vehicle_points", None)
                if image_points and vehicle_points:
                    return HomographyMapper(image_points, vehicle_points)
                else:
                    rospy.logwarn("frontview config missing keys. Falling back to defaults.")
            except Exception as e:
                rospy.logwarn("Failed to read frontview config: %s (fallback to defaults)", e)

        else:
            front_dic = {
                "image_points": [[306, 361], [86, 705], [1243, 697], [1229, 382]],
                "vehicle_points": [[-0.125, 0.475], [-0.08, 0.155], [0.095, 0.15], [0.255, 0.43]]
            }
        return HomographyMapper(front_dic['image_points'], front_dic['vehicle_points'])

    

    # --- 카메라 장치 초기화 ---
    
    def init_cam(self):
        use_camera = rospy.get_param("~use_camera", True)
        cap = None
        if use_camera:
            camera_source = rospy.get_param("~camera_source", 1)
            cap = cv2.VideoCapture(camera_source)
            if not cap.isOpened():
                rospy.logerr("Cannot open camera. Falling back to black screen.")
                use_camera = False
            else:
                cap.set(cv2.CAP_PROP_FRAME_WIDTH,  self.FRAME_WIDTH)
                cap.set(cv2.CAP_PROP_FRAME_HEIGHT, self.FRAME_HEIGHT)
                rospy.loginfo("Camera opened.")
        else:
            rospy.loginfo("Running without camera.")
        return use_camera, cap


    # --- display ---
    
    #person image를 front view에 합성
    def overlay_image(self, background, foreground, x_pos, y_pos, transparency=0.7):
        if foreground is None:
            return
        h, w = foreground.shape[:2]
        y1, y2 = max(0, y_pos), min(background.shape[0], y_pos + h)
        x1, x2 = max(0, x_pos), min(background.shape[1], x_pos + w)

        if y1 >= y2 or x1 >= x2: return

        fg_y1 = max(0, -y_pos)
        fg_y2 = fg_y1 + (y2 - y1)
        fg_x1 = max(0, -x_pos)
        fg_x2 = fg_x1 + (x2 - x1)
        
        fg_img_part = foreground[fg_y1:fg_y2, fg_x1:fg_x2]
        roi = background[y1:y2, x1:x2]
        
        #알파 채널 없으면 종료
        if fg_img_part.shape[2] < 4: return            

        #알파 정규화 및 외부 투명도 적용
        alpha_original = fg_img_part[:, :, 3] / 255.0
        alpha_final = alpha_original * transparency
        alpha_mask = np.stack([alpha_final] * 3, axis=2)
        composite = roi * (1.0 - alpha_mask) + fg_img_part[:, :, :3] * alpha_mask
        
        background[y1:y2, x1:x2] = composite.astype(np.uint8)

    #위험도 아이콘을 스케일링하여 지정 위치에 합성
    def draw_scaled_ui(self, frame, x, y, scale, symbol_img):
        if symbol_img is None: return

        h, w = symbol_img.shape[:2]
        aspect_ratio = float(h) / w
        new_w = int(self.BASE_IMAGE_WIDTH_PX * scale)
        new_h = int(new_w * aspect_ratio)

        if new_w > 0 and new_h > 0:
            resized_symbol = cv2.resize(symbol_img, (new_w, new_h), interpolation=cv2.INTER_AREA)
            pos_x = x - new_w // 2
            pos_y = y - new_h // 2
            # 약간의 시각 보정(아이콘 기준점 보정)
            self.overlay_image(frame, resized_symbol, pos_x + 50, pos_y - 150)

    # 토픽 구독 Callback
    def objects_callback(self,msg):
        self.last_msg_time = time.time()
        processed_list = []
        risk_map = {3: 'red', 2: 'yellow', 1: 'green', 0: 'n'}

        self.latest_car_position = (msg.vehicle_position.x, msg.vehicle_position.y)
        self.latest_vehicle_yaw = msg.vehicle_yaw
        for obj in msg.objects:
            risk_key = risk_map.get(obj.risk_level, 'n')
            processed_list.append({
                'x': obj.relative_position.x,
                'y': obj.relative_position.y,
                'distance': obj.relative_distance,
                'risk_key': risk_key,
                # 디스플레이 탑뷰용 절대좌표(TM)
                'global_pos': (obj.global_position.x, obj.global_position.y) # <<<<< 이거 받아야돼
            })
        self.latest_objects_list = processed_list


    # --- Sound ---
    
    #위험도(red/yellow/green)에 따른 경고음 재생
    def play_warning_sound(self, level_key):
        try:
            snd_dir = os.path.join(self.pkg_path, 'sounds')
            if level_key == 'red':
                p = os.path.join(snd_dir, 'tone_red_1500Hz_150ms.wav')
            elif level_key == 'yellow':
                p = os.path.join(snd_dir, 'tone_yellow_1200Hz_200ms.wav')
            elif level_key == 'green':
                p = os.path.join(snd_dir, 'tone_green_1000Hz_200ms.wav')
            else:
                return

            fnull = open(os.devnull, 'w')
            cmd = ['/usr/bin/aplay', '-q']
            if self.ALSA_DEVICE:
                cmd += ['-D', self.ALSA_DEVICE]
            cmd.append(p)
            subprocess.Popen(cmd, stdout=fnull, stderr=fnull)
        except Exception as e:
            rospy.logwarn("play_warning_sound error: {}".format(e))



    # --- 각도/회전 유틸 ---
    
    def _pixel_angle_from_tm_direction(self, pos_tm, dir_tm, step_m=2.0):
        u1, v1 = self.mapper_topview.ground_to_px_abs((pos_tm[0], pos_tm[1]))
        u2, v2 = self.mapper_topview.ground_to_px_abs(
            (pos_tm[0] + step_m * dir_tm[0], pos_tm[1] + step_m * dir_tm[1])
        )

        du, dv = (u2 - u1), (v2 - v1)
        # 픽셀 좌표계(+u 오른쪽, +v 아래). atan2(dv,du)는 +x 기준 반시계(도)
        phi_deg = math.degrees(math.atan2(dv, du))

        # 아이콘 원본이 "위쪽(+y)"을 보는 이미지이므로, 위쪽은 +x 기준 -90도 방향
        # 따라서 필요한 회전량 = phi - (-90) = phi + 90
        return phi_deg + 90.0

    def _rotate_rgba(self, img_rgba, angle_deg):
        if img_rgba is None:
            return None
        h, w = img_rgba.shape[:2]
        M = cv2.getRotationMatrix2D((w/2.0, h/2.0), angle_deg, 1.0)
        return cv2.warpAffine(img_rgba, M, (w, h), flags=cv2.INTER_LINEAR, borderMode=cv2.BORDER_TRANSPARENT)


    # --- 경로 유틸 ---
    
    #상대경로면 base_dir를 기준으로 절대경로로 변환, 절대경로면 그대로 반환
    def _resolve_path(self, path_like, base_dir):
        return path_like if os.path.isabs(path_like) else os.path.normpath(os.path.join(base_dir, path_like))

    # --- 메인 루프 ---
    
    def run(self):
        rate_hz = rospy.get_param("~ui_fps", 30.0)
        rate = rospy.Rate(rate_hz)

        while not rospy.is_shutdown():
            # 메시지 타임아웃(1s) 시 화면 클린업
            if (time.time() - self.last_msg_time > 1.0):
                self.latest_objects_list = []

            # 프론트 뷰 프레임
            if self.use_camera and self.cap is not None:
                ret, frame_frontview = self.cap.read()
                if not ret:
                    frame_frontview = np.zeros((self.FRAME_HEIGHT, self.FRAME_WIDTH, 3), dtype=np.uint8)
            else:
                frame_frontview = np.zeros((self.FRAME_HEIGHT, self.FRAME_WIDTH, 3), dtype=np.uint8)

            # 점멸 토글
            current_time = time.time()
            if current_time - self.last_blink_time > self.BLINK_INTERVAL:
                self.blink_on = not self.blink_on
                self.last_blink_time = current_time

            # 탑뷰 프레임
            if self.latest_map_image is not None:
                frame_topview = self.latest_map_image.copy()
            else:
                frame_topview = np.zeros((720, 540, 3), dtype=np.uint8)

            # 오브젝트 렌더링
            info_text = "Waiting for data..."
            if self.latest_objects_list:
                info_text = "Objects Detected: {}".format(len(self.latest_objects_list))
                for data in self.latest_objects_list:
                    risk_level_key = data['risk_key']
                    if risk_level_key != 'n':
                        rel_x, rel_y = data['x'], data['y']
                        px_x, px_y = map(int, self.mapper.ground_to_px_abs((rel_x, rel_y)))

                        distance = data['distance']
                        scale = max(0.3, min(1.5, 30.0 / distance if distance > 0 else 1.5))

                        symbol_to_draw = self.risk_images.get(risk_level_key)
                        self.draw_scaled_ui(frame_frontview, px_x, px_y, scale, symbol_to_draw)

                        # 경고음(red/yellow)
                        if risk_level_key in ['red', 'yellow']:
                            gap = 0.2 if risk_level_key == 'red' else 0.5
                            if current_time - self.last_sound_time > gap:
                                self.play_warning_sound(risk_level_key)
                                self.last_sound_time = current_time

                    # 탑뷰 객체
                    if 'global_pos' in data and self.mapper_topview:
                        px_x_top, px_y_top = map(int, self.mapper_topview.ground_to_px_abs(data['global_pos']))
                        px_y_top -= 74
                        self.overlay_image(frame_topview, self.human_img_topview, px_x_top, px_y_top)

            # 탑뷰 차량 표시(자세 반영 회전)
            if self.latest_car_position and self.mapper_topview and self.car_img_topview is not None:
                # 1) TM 기준 진행방향 = yaw0_unit을 vehicle_yaw만큼 회전
                ux0, uy0 = self.yaw0_unit
                theta = self.latest_vehicle_yaw
                dir_tm = (
                    ux0 * math.cos(theta) - uy0 * math.sin(theta),
                    ux0 * math.sin(theta) + uy0 * math.cos(theta)
                )

                # 2) 픽셀 회전각 계산
                angle_deg = self._pixel_angle_from_tm_direction(
                    self.latest_car_position, dir_tm, step_m=2.0
                )

                # 3) 차량 픽셀 위치 및 회전 합성
                px_car_x, px_car_y = map(int, self.mapper_topview.ground_to_px_abs(self.latest_car_position))
                car_img_to_draw = self._rotate_rgba(self.car_img_topview, angle_deg)
                self.overlay_image(
                    frame_topview,
                    car_img_to_draw,
                    px_car_x - car_img_to_draw.shape[1] // 2,
                    px_car_y - car_img_to_draw.shape[0] // 2
                )

            if frame_topview.ndim == 3 and frame_topview.shape[2] == 4:
                frame_topview = cv2.cvtColor(frame_topview, cv2.COLOR_BGRA2BGR)

            if frame_frontview.ndim == 2:
                frame_frontview = cv2.cvtColor(frame_frontview, cv2.COLOR_GRAY2BGR)

            # 높이 맞추기
            h_f = frame_frontview.shape[0]
            h_t = frame_topview.shape[0]
            if h_t != h_f:
                scale = float(h_f) / float(h_t)
                new_w = int(round(frame_topview.shape[1] * scale))
                frame_topview = cv2.resize(frame_topview, (new_w, h_f))


            # 합성/표시
            combined_frame = np.hstack((frame_frontview, frame_topview))
            cv2.putText(combined_frame, info_text, (50, 50),
                        cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2)
            cv2.imshow('Combined Display', combined_frame)
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break

            rate.sleep()

        # 종료 처리
        if self.use_camera and self.cap is not None:
            self.cap.release()
        cv2.destroyAllWindows()

    
def main():
    rospy.init_node('interface_node', anonymous=True)
    node = InterfaceNode()
    node.run()

if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass
