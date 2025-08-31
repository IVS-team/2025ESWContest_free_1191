#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
import cv2
import numpy as np
import time
import math
import os

# ROS 메시지 타입 임포트
from sensor_msgs.msg import NavSatFix
from std_msgs.msg import Float32 # '미정'인 custom msg를 Float32로 가정

# --- 설정 클래스 ---
class Config:
    # 색상 정의 (B, G, R)
    RISK_LEVEL_COLORS = {
        'red': (0, 0, 255),    # 가장 위험 (빨강)
        'yellow': (0, 128, 255), # 경고 (orange)
        'green': (0, 255, 0)     # 안전 (초록)
    }
    BACKGROUND_FILL_COLOR = (0, 255, 255) # 심볼 배경 (yellow)
    PERSON_SYMBOL_COLOR = (0, 0, 0)
    WARNING_ICON_COLOR = (0, 0, 255)

    # 위험도 거리 임계값 (미터 단위)
    RISK_THRESHOLDS = {
        'red': 15,    # 15미터 미만
        'yellow': 40  # 40미터 미만
    }
    
    # 디스플레이 설정
    BACKGROUND_BORDER_THICKNESS = 8
    BASE_BACKGROUND_SIZE = 150
    FIXED_DISPLAY_Y = 200
    BLINK_INTERVAL = 0.5

# --- 전역 변수 ---
FRAME_WIDTH, FRAME_HEIGHT = 1280, 720
last_blink_time = 0
blink_on = True

# 메시지 수신 데이터 저장용
my_vehicle_gps = None
obstacle_gps = None
object_distance = None # custom msg로 받은 거리 (선택적 사용)

# 경고음 재생 관련
sound_intervals = {'red': 0.2, 'yellow': 0.5} # 빨강: 0.2초마다, 노랑: 0.5초마다
last_sound_time = 0

def play_warning_sound(level):
    """위험도에 따라 경고음을 재생합니다."""
    if os.name != 'nt': return # Windows가 아니면 실행 안 함
    
    try:
        import winsound
        if level == 'red':
            winsound.Beep(1500, 150) # 높은 톤, 짧게
        elif level == 'yellow':
            winsound.Beep(1000, 200) # 중간 톤, 보통 길이
    except ImportError:
        rospy.logwarn("winsound module not found, cannot play sound.")

def calculate_haversine_distance(lat1, lon1, lat2, lon2):
    """두 GPS 좌표 간의 거리를 미터 단위로 계산합니다 (Haversine 공식)."""
    R = 6371000  # 지구 반지름 (미터)
    phi1 = math.radians(lat1)
    phi2 = math.radians(lat2)
    delta_phi = math.radians(lat2 - lat1)
    delta_lambda = math.radians(lon2 - lon1)

    a = math.sin(delta_phi / 2.0)**2 + \
        math.cos(phi1) * math.cos(phi2) * \
        math.sin(delta_lambda / 2.0)**2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    
    return R * c

def calculate_bearing(lat1, lon1, lat2, lon2):
    """두 GPS 좌표 간의 방위각을 계산합니다."""
    lat1_rad, lon1_rad = math.radians(lat1), math.radians(lon1)
    lat2_rad, lon2_rad = math.radians(lat2), math.radians(lon2)
    
    dLon = lon2_rad - lon1_rad
    
    y = math.sin(dLon) * math.cos(lat2_rad)
    x = math.cos(lat1_rad) * math.sin(lat2_rad) - \
        math.sin(lat1_rad) * math.cos(lat2_rad) * math.cos(dLon)
        
    bearing_rad = math.atan2(y, x)
    return bearing_rad # 라디안 값 반환

def draw_scaled_ui(frame, x, y, scale, border_color):
    """UI 요소를 프레임에 그립니다."""
    bg_size = int(Config.BASE_BACKGROUND_SIZE * scale)
    border_thickness = max(1, int(Config.BACKGROUND_BORDER_THICKNESS * scale))
    
    # 삼각형 배경
    p1 = (x, y - int(bg_size * 0.58))
    p2 = (x - bg_size // 2, y + int(bg_size * 0.29))
    p3 = (x + bg_size // 2, y + int(bg_size * 0.29))
    points = np.array([p1, p2, p3], np.int32)
    cv2.fillPoly(frame, [points], Config.BACKGROUND_FILL_COLOR)
    cv2.polylines(frame, [points], True, border_color, border_thickness)

    # 사람 아이콘
    color = Config.PERSON_SYMBOL_COLOR
    head_r = max(1, int(15 * scale))
    cv2.circle(frame, (x, y - int(10 * scale)), head_r, color, -1)
    body_p1 = (x - int(15 * scale), y + int(5 * scale))
    body_p2 = (x + int(15 * scale), y + int(40 * scale))
    cv2.rectangle(frame, body_p1, body_p2, color, -1, cv2.LINE_AA)
    cv2.circle(frame, (x - int(15 * scale), y + int(15 * scale)), int(10 * scale), color, -1)
    cv2.circle(frame, (x + int(15 * scale), y + int(15 * scale)), int(10 * scale), color, -1)

    # 깜빡이는 경고 아이콘 (빨강 또는 노랑일 때만 표시)
    if border_color != Config.RISK_LEVEL_COLORS['green'] and blink_on:
        icon_x, icon_y = x + int(60 * scale), y - int(60 * scale)
        icon_size = max(5, int(15 * scale))
        icon_pts = np.array([(icon_x, icon_y - icon_size), (icon_x - icon_size, icon_y + icon_size), (icon_x + icon_size, icon_y + icon_size)], np.int32)
        cv2.drawContours(frame, [icon_pts], 0, Config.WARNING_ICON_COLOR, -1)
        cv2.line(frame, (icon_x, icon_y - int(icon_size * 0.5)), (icon_x, icon_y + int(icon_size * 0.2)), (255, 255, 255), max(1, int(4 * scale)))
        cv2.circle(frame, (icon_x, icon_y + int(icon_size * 0.5)), max(1, int(3 * scale)), (255, 255, 255), -1)

# --- ROS 콜백 함수들 ---
def my_gps_callback(msg):
    global my_vehicle_gps
    my_vehicle_gps = msg

def obstacle_gps_callback(msg):
    global obstacle_gps
    obstacle_gps = msg

def distance_callback(msg):
    global object_distance
    object_distance = msg.data

def main():
    global last_blink_time, blink_on, last_sound_time

    rospy.init_node('warning_display_node', anonymous=True)
    
    # 파라미터로 카메라 사용 여부 결정
    use_camera = True
    rospy.loginfo("Camera display {}.".format('enabled' if use_camera else 'disabled'))

    # 구독자 설정 (카메라 구독은 제거됨)
    rospy.Subscriber('/my_vehicle/gps', NavSatFix, my_gps_callback)
    rospy.Subscriber('/obstacle/gps', NavSatFix, obstacle_gps_callback)
    rospy.Subscriber('/object_distance', Float32, distance_callback)

    # [수정됨] 카메라 직접 캡처 설정
    cap = None
    if use_camera:
        camera_index = 0  # 시스템에 연결된 카메라 인덱스 (보통 0)
        cap = cv2.VideoCapture(camera_index)
        if not cap.isOpened():
            rospy.logerr("Cannot open camera at index {}".format(camera_index))
            use_camera = False # 카메라를 열 수 없으면 비활성화
        else:
            cap.set(cv2.CAP_PROP_FRAME_WIDTH, FRAME_WIDTH)
            cap.set(cv2.CAP_PROP_FRAME_HEIGHT, FRAME_HEIGHT)
            rospy.loginfo("Camera opened successfully.")

    while not rospy.is_shutdown():
        # 1. [수정됨] 카메라 또는 검은 배경 프레임 준비
        if use_camera and cap.isOpened():
            ret, current_frame = cap.read()
            if not ret:
                rospy.logwarn("Failed to grab frame from camera. Using black background.")
                current_frame = np.zeros((FRAME_HEIGHT, FRAME_WIDTH, 3), dtype=np.uint8)
        else:
            # 카메라를 사용하지 않거나 열리지 않은 경우
            current_frame = np.zeros((FRAME_HEIGHT, FRAME_WIDTH, 3), dtype=np.uint8)
        
        # 2. 깜빡임 상태 업데이트
        current_time = time.time()
        if current_time - last_blink_time > Config.BLINK_INTERVAL:
            blink_on = not blink_on
            last_blink_time = current_time

        # 3. 데이터 유효성 검사 및 계산
        if my_vehicle_gps and obstacle_gps:
            distance = calculate_haversine_distance(
                my_vehicle_gps.latitude, my_vehicle_gps.longitude,
                obstacle_gps.latitude, obstacle_gps.longitude
            )
            
            # TODO: 정확한 상대좌표를 위해서는 차량의 Heading(방향) 정보가 필요합니다.
            vehicle_heading_rad = 0.0 
            
            bearing_rad = calculate_bearing(
                my_vehicle_gps.latitude, my_vehicle_gps.longitude,
                obstacle_gps.latitude, obstacle_gps.longitude
            )
            
            relative_angle_rad = bearing_rad - vehicle_heading_rad
            target_x = distance * math.cos(relative_angle_rad)
            target_y = -distance * math.sin(relative_angle_rad)
            
            # 4. 위험도 판단 및 시각/청각 요소 결정
            risk_level = 'green'
            if distance < Config.RISK_THRESHOLDS['red']:
                risk_level = 'red'
            elif distance < Config.RISK_THRESHOLDS['yellow']:
                risk_level = 'yellow'

            border_color = Config.RISK_LEVEL_COLORS[risk_level]

            # 5. UI 그리기
            if abs(target_y) < target_x:
                scale = max(0.3, min(1.5, 30.0 / distance))
                center_x = FRAME_WIDTH // 2
                max_shift = FRAME_WIDTH * 0.4 
                angle_deg = math.degrees(math.atan2(target_y, target_x))
                display_x = center_x - int(max_shift * (angle_deg / 45.0))
                
                draw_scaled_ui(current_frame, display_x, Config.FIXED_DISPLAY_Y, scale, border_color)

                # 6. 경고음 재생
                if risk_level in sound_intervals:
                    if current_time - last_sound_time > sound_intervals[risk_level]:
                        if (risk_level == 'yellow' and blink_on) or risk_level == 'red':
                            play_warning_sound(risk_level)
                            last_sound_time = current_time
        
        # 디버그 정보 표시
        if 'distance' in locals():
            info_text = "Dist: {:.1f}m | Risk: {}".format(distance, risk_level)
        else:
            info_text = "Waiting for GPS data..."
        cv2.putText(current_frame, info_text, (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2)

        cv2.imshow('ROS Warning System Display', current_frame)
        if cv2.waitKey(30) & 0xFF == ord('q'):
            break
            
    # [수정됨] 프로그램 종료 시 자원 해제
    if cap is not None:
        cap.release()
    cv2.destroyAllWindows()

if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass