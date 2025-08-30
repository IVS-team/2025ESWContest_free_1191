#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
import math
import numpy as np
import cv2
from cv_bridge import CvBridge

# ROS 메시지 타입 임포트
from sensor_msgs.msg import Image, NavSatFix
from std_msgs.msg import Float32

def calculate_haversine_distance(lat1, lon1, lat2, lon2):
    """두 GPS 좌표 간의 거리를 미터 단위로 계산합니다."""
    R = 6371000  # 지구 반지름 (미터)
    phi1, phi2 = math.radians(lat1), math.radians(lat2)
    delta_phi = math.radians(lat2 - lat1)
    delta_lambda = math.radians(lon2 - lon1)
    a = math.sin(delta_phi / 2.0)**2 + math.cos(phi1) * math.cos(phi2) * math.sin(delta_lambda / 2.0)**2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    return R * c

def dynamic_publisher():
    """전방 시야각 내에서 거리와 위치를 바꾸는 센서 메시지를 발행하는 노드."""
    
    rospy.init_node('dynamic_sensor_publisher_node', anonymous=True)
    image_pub = rospy.Publisher('/camera/image_raw', Image, queue_size=10)
    my_gps_pub = rospy.Publisher('/my_vehicle/gps', NavSatFix, queue_size=10)
    obs_gps_pub = rospy.Publisher('/obstacle/gps', NavSatFix, queue_size=10)
    dist_pub = rospy.Publisher('/object_distance', Float32, queue_size=10)
    
    rate = rospy.Rate(10) # 10Hz
    bridge = CvBridge()
    
    # --- 시뮬레이션 파라미터 ---
    # 내 차량 GPS (서울 시청 근처로 설정)
    my_lat, my_lon = 37.5665, 126.9780
    
    # === 장애물 움직임 설정 (수정된 부분) ===
    # 1. 거리(반경)가 동적으로 변할 범위 설정
    MIN_DISTANCE = 10.0 # 최소 거리 (미터)
    MAX_DISTANCE = 90.0 # 최대 거리 (미터)
    
    # 2. 좌우 각도가 변할 범위 설정 (전방 90도 시야각)
    MAX_ANGLE_SWING = math.pi / 4 # 45도 (라디안)
    
    # 3. 움직임을 만들기 위한 변수
    master_clock = 0.0
    speed = 0.04
    # ====================================
    
    rospy.loginfo("Starting dynamic sensor publisher (Forward View Simulation).")
    
    while not rospy.is_shutdown():
        current_time = rospy.Time.now()
        
        # --- 동적 위치 및 거리 계산 ---
        # master_clock을 이용해 사인/코사인 함수로 거리와 각도를 주기적으로 변경
        
        # 1. 좌우 위치 (Angle) 계산: -45도 ~ +45도 사이를 왕복
        angle = MAX_ANGLE_SWING * math.sin(master_clock)
        
        # 2. 거리 (Distance) 계산: MIN_DISTANCE ~ MAX_DISTANCE 사이를 왕복
        # (1 + cos) / 2 를 이용해 값 범위를 0~1로 만들고, 이를 거리 범위에 매핑
        distance_ratio = (1 + math.cos(master_clock * 0.7)) / 2.0 # *0.7로 각도와 다른 주기로 움직이게 함
        distance = MIN_DISTANCE + (MAX_DISTANCE - MIN_DISTANCE) * distance_ratio

        # --------------------------------

        # 내 차량 GPS 메시지 생성
        my_gps_msg = NavSatFix()
        my_gps_msg.header.stamp = current_time
        my_gps_msg.header.frame_id = 'gps'
        my_gps_msg.latitude = my_lat
        my_gps_msg.longitude = my_lon
        
        # 계산된 거리(distance)와 각도(angle)로 장애물 GPS 위치 계산
        dx = distance * math.sin(angle) # 좌우(y) offset
        dy = distance * math.cos(angle) # 전방(x) offset
        
        lat_offset = dy / 111132.0
        lon_offset = dx / (111320.0 * math.cos(math.radians(my_lat)))
        
        obs_lat = my_lat + lat_offset
        obs_lon = my_lon + lon_offset
        
        obs_gps_msg = NavSatFix()
        obs_gps_msg.header.stamp = current_time
        obs_gps_msg.header.frame_id = 'gps'
        obs_gps_msg.latitude = obs_lat
        obs_gps_msg.longitude = obs_lon
        
        # 거리 메시지 생성 (실제 GPS간 계산된 거리)
        actual_distance = calculate_haversine_distance(my_lat, my_lon, obs_lat, obs_lon)
        dist_msg = Float32()
        dist_msg.data = actual_distance
        
        # 카메라 이미지 메시지 생성
        frame = np.full((720, 1280, 3), (50, 40, 30), dtype=np.uint8)
        sim_text = "Dist: {:.1f}m | Angle: {:.1f}deg".format(actual_distance, math.degrees(angle))
        cv2.putText(frame, sim_text, (50, 100), cv2.FONT_HERSHEY_SIMPLEX, 1.5, (255, 255, 255), 3)
        cv2.putText(frame, "VIRTUAL CAMERA (FORWARD SIM)", (50, 650), cv2.FONT_HERSHEY_SIMPLEX, 2, (100, 100, 100), 4)
        
        try:
            image_msg = bridge.cv2_to_imgmsg(frame, "bgr8")
            image_msg.header.stamp = current_time
        except Exception as e:
            rospy.logerr(e)
            continue
            
        # 모든 메시지 발행
        image_pub.publish(image_msg)
        my_gps_pub.publish(my_gps_msg)
        obs_gps_pub.publish(obs_gps_msg)
        dist_pub.publish(dist_msg)
        
        # 다음 주기를 위해 마스터 클럭 업데이트
        master_clock += speed
            
        rate.sleep()

if __name__ == '__main__':
    try:
        dynamic_publisher()
    except rospy.ROSInterruptException:
        pass