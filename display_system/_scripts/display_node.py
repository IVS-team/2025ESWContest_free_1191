#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
from geometry_msgs.msg import Point
import cv2
import numpy as np
import time
import math
import os

# --- Config 클래스 및 그리기 함수들 (이전 코드와 동일) ---
class Config:
    BACKGROUND_FILL_COLOR = (0, 255, 255); BACKGROUND_BORDER_COLOR = (0, 0, 255)
    BACKGROUND_BORDER_THICKNESS = 8; BASE_BACKGROUND_SIZE = 150
    PERSON_SYMBOL_COLOR = (0, 0, 0); WARNING_ICON_COLOR = (0, 0, 255)
    FIXED_DISPLAY_Y = 200; BLINK_INTERVAL = 0.5

FRAME_WIDTH, FRAME_HEIGHT = 1280, 720
last_blink_time = 0; blink_on = True
target_data = None # 수신된 좌표 데이터를 저장할 변수

def play_warning_sound():
    if os.name == 'nt':
        try: import winsound; winsound.Beep(1000, 200)
        except ImportError: pass

def draw_scaled_ui(frame, x, y, scale):
    bg_size = int(Config.BASE_BACKGROUND_SIZE * scale)
    border_thickness = max(1, int(Config.BACKGROUND_BORDER_THICKNESS * scale))
    p1=(x,y-int(bg_size*0.58)); p2=(x-bg_size//2,y+int(bg_size*0.29)); p3=(x+bg_size//2,y+int(bg_size*0.29))
    cv2.fillPoly(frame,[np.array([p1,p2,p3],np.int32)],Config.BACKGROUND_FILL_COLOR)
    cv2.polylines(frame,[np.array([p1,p2,p3],np.int32)],True,Config.BACKGROUND_BORDER_COLOR,border_thickness)
    color = Config.PERSON_SYMBOL_COLOR
    head_r = max(1, int(15 * scale)); cv2.circle(frame,(x,y-int(10*scale)),head_r,color,-1)
    body_p1=(x-int(15*scale),y+int(5*scale)); body_p2=(x+int(15*scale),y+int(40*scale))
    cv2.rectangle(frame,body_p1,body_p2,color,-1,cv2.LINE_AA)
    cv2.circle(frame,(x-int(15*scale),y+int(15*scale)),int(10*scale),color,-1)
    cv2.circle(frame,(x+int(15*scale),y+int(15*scale)),int(10*scale),color,-1)
    if not blink_on: return
    icon_x=x+int(60*scale); icon_y=y-int(60*scale)
    icon_size=max(5,int(15*scale))
    icon_pts=np.array([(icon_x,icon_y-icon_size),(icon_x-icon_size,icon_y+icon_size),(icon_x+icon_size,icon_y+icon_size)],np.int32)
    cv2.drawContours(frame,[icon_pts],0,Config.WARNING_ICON_COLOR,-1)
    cv2.line(frame,(icon_x,icon_y-int(icon_size*0.5)),(icon_x,icon_y+int(icon_size*0.2)),(255,255,255),max(1,int(4*scale)))
    cv2.circle(frame,(icon_x,icon_y+int(icon_size*0.5)),max(1,int(3*scale)),(255,255,255),-1)

def coords_callback(msg):
    """/object_coords 토픽 메시지를 수신했을 때 호출될 콜백 함수"""
    global target_data
    # 메시지에서 x, y, z(사용 안 함) 값을 읽어와 저장
    target_data = {'x': msg.x, 'y': msg.y}
    # rospy.loginfo("Received coordinates: x=%s, y=%s", msg.x, msg.y)

def main():
    global last_blink_time, blink_on, target_data
    
    # ROS 노드 초기화
    rospy.init_node('warning_display_node', anonymous=True)
    # /object_coords 토픽을 구독하고, 메시지가 오면 coords_callback 함수 호출
    rospy.Subscriber('/object_coords', Point, coords_callback)
    
    background = np.zeros((FRAME_HEIGHT, FRAME_WIDTH, 3), dtype=np.uint8)
    sound_played = False

    while not rospy.is_shutdown():
        current_frame = background.copy()
        
        # 깜빡임 상태 업데이트
        current_time = time.time()
        if current_time - last_blink_time > Config.BLINK_INTERVAL:
            blink_on = not blink_on; last_blink_time = current_time; sound_played = False
        
        # 수신된 데이터가 있을 경우에만 UI 계산 및 그리기
        if target_data:
            theta_rad = math.atan2(target_data['y'], target_data['x'])
            theta_deg = math.degrees(theta_rad)
            
            if abs(theta_deg) <= 45:
                distance = math.sqrt(target_data['x']**2 + target_data['y']**2)
                scale = max(0.3, min(1.5, 1.5 - (distance / 500)))
                
                center_x = FRAME_WIDTH // 2
                max_shift = FRAME_WIDTH * 0.3
                display_x = center_x - int(max_shift * (theta_deg / 45))
                display_y = Config.FIXED_DISPLAY_Y
                
                draw_scaled_ui(current_frame, display_x, display_y, scale)
                
                if blink_on and not sound_played:
                    play_warning_sound(); sound_played = True
        
        cv2.imshow('ROS Warning System Display', current_frame)
        if cv2.waitKey(30) & 0xFF == ord('q'):
            break

    cv2.destroyAllWindows()

if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass
