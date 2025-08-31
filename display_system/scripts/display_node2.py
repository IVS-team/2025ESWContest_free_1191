#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
import cv2
import numpy as np
import time
import math
import os

# [수정] data_synchronizer 패키지에서 ProcessedObjectArray 메시지를 임포트
from data_processing.msg import ProcessedObjectArray

# --- 설정 클래스 ---
class Config:
    # [수정] 위험도 키를 'R', 'O', 'Y'로 변경
    RISK_LEVEL_COLORS = {
        'R': (0, 0, 255),       # Red
        'O': (0, 128, 255),   # Orange
        'Y': (0, 255, 255),   # Yellow
        'None': (0, 255, 0)     # Green (안전)
    }
    BACKGROUND_FILL_COLOR = (220, 220, 220) # 심볼 배경 (Light Gray)
    PERSON_SYMBOL_COLOR = (0, 0, 0)
    WARNING_ICON_COLOR = (0, 0, 255)
    
    # 디스플레이 설정
    BACKGROUND_BORDER_THICKNESS = 8
    BASE_BACKGROUND_SIZE = 150
    FIXED_DISPLAY_Y = 200
    BLINK_INTERVAL = 0.5

# --- 전역 변수 ---
FRAME_WIDTH, FRAME_HEIGHT = 1280, 720
last_blink_time = 0
blink_on = True

# [수정] data_sync 노드로부터 받은 최종 객체 정보를 저장할 변수
processed_objects_data = []

# 경고음 재생 관련
sound_intervals = {'R': 0.2, 'O': 0.5} # Red: 0.2초, Orange: 0.5초
last_sound_time = 0

def play_warning_sound(level):
    """위험도에 따라 경고음을 재생합니다."""
    if os.name != 'nt': return
    try:
        import winsound
        if level == 'R':
            winsound.Beep(1500, 150)
        elif level == 'O':
            winsound.Beep(1000, 200)
    except ImportError:
        rospy.logwarn("winsound module not found, cannot play sound.")

def draw_scaled_ui(frame, x, y, scale, border_color, distance):
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
    
    # 거리 텍스트 추가
    text = "{:.1f}m".format(distance)
    font_scale = max(0.5, 1.0 * scale)
    (text_w, text_h), _ = cv2.getTextSize(text, cv2.FONT_HERSHEY_SIMPLEX, font_scale, 2)
    cv2.putText(frame, text, (x - text_w // 2, y + int(bg_size * 0.6)), cv2.FONT_HERSHEY_SIMPLEX, font_scale, (0,0,0), 2)


# --- [수정] ROS 콜백 함수 ---
def processed_objects_callback(msg):
    """/processed_objects 토픽을 구독하여 받은 데이터를 전역 변수에 저장합니다."""
    global processed_objects_data
    processed_objects_data = msg.objects

def main():
    global last_blink_time, blink_on, last_sound_time, processed_objects_data

    rospy.init_node('display_node', anonymous=True)
    
    # [수정] /processed_objects 토픽 구독자 설정
    rospy.Subscriber('/processed_objects', ProcessedObjectArray, processed_objects_callback)

    # 카메라 직접 캡처 설정
    cap = cv2.VideoCapture(0, cv2.CAP_V4L2)
    if not cap.isOpened():
        rospy.logerr("Cannot open camera with V4L2.")
        return
    else:
        cap.set(cv2.CAP_PROP_FOURCC, cv2.VideoWriter_fourcc(*'MJPG'))
        cap.set(cv2.CAP_PROP_FRAME_WIDTH, FRAME_WIDTH)
        cap.set(cv2.CAP_PROP_FRAME_HEIGHT, FRAME_HEIGHT)
        rospy.loginfo("Camera opened successfully.")

    while not rospy.is_shutdown():
        ret, frame = cap.read()
        if not ret:
            rospy.logwarn("Failed to grab frame from camera.")
            continue
        
        current_time = time.time()
        if current_time - last_blink_time > Config.BLINK_INTERVAL:
            blink_on = not blink_on
            last_blink_time = current_time

        # [수정] 수신된 모든 객체 정보에 대해 반복하여 UI를 그림
        if processed_objects_data:
            # TODO: 현재는 여러 객체를 화면 중앙 근처에 일렬로 배치합니다.
            # 향후 data_sync 노드에서 각 객체의 '화면상 x좌표'를 함께 보내주면
            # 더 정확한 위치에 UI를 표시할 수 있습니다.
            num_objects = len(processed_objects_data)
            start_x = FRAME_WIDTH // 2 - 150 * (num_objects - 1) // 2

            for i, obj in enumerate(processed_objects_data):
                distance = obj.distance_m
                risk_level = obj.risk_level # 'R', 'O', 'Y', 'None'

                border_color = Config.RISK_LEVEL_COLORS.get(risk_level, (255, 255, 255))
                scale = max(0.3, min(1.5, 30.0 / distance if distance > 0 else 1.5))
                
                # 객체를 순서대로 화면에 배치
                display_x = start_x + 150 * i
                
                draw_scaled_ui(frame, display_x, Config.FIXED_DISPLAY_Y, scale, border_color, distance)

                # 가장 위험한 객체 기준으로 경고음 재생
                if risk_level in sound_intervals:
                    if current_time - last_sound_time > sound_intervals[risk_level]:
                        play_warning_sound(risk_level)
                        last_sound_time = current_time # 한번만 울리도록
        
        # 디버그 정보 표시
        info_text = "{} objects detected".format(len(processed_objects_data))
        cv2.putText(frame, info_text, (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2)

        cv2.imshow('Display System', frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
            
    cap.release()
    cv2.destroyAllWindows()

if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass
