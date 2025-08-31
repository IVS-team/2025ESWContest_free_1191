#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
from geometry_msgs.msg import Point
import math

def dynamic_coords_publisher():
    """
    시간에 따라 좌표를 동적으로 변경하며 발행하는 노드.
    원형 궤도를 따라 움직이는 객체를 시뮬레이션합니다.
    """
    # ROS 노드 초기화
    rospy.init_node('dynamic_coords_publisher_node', anonymous=True)
    # Publisher 생성
    pub = rospy.Publisher('/object_coords', Point, queue_size=10)
    # 발행 주기 설정 (1초에 10번)
    rate = rospy.Rate(10) 

    # --- 시뮬레이션 파라미터 ---
    radius = 300.0   # 원의 반지름 (객체와의 거리)
    angle = 0.0      # 시작 각도 (라디안)
    speed = 0.05     # 각속도 (라디안/발행 주기)
    # ---------------------------

    rospy.loginfo("Starting dynamic publisher. Object will move in a circular path.")

    while not rospy.is_shutdown():
        # 원형 궤도에 따라 x, y 좌표 계산
        # math.cos()와 math.sin()을 사용하여 원 위의 점을 구함
        current_x = radius * math.cos(angle)
        current_y = radius * math.sin(angle)

        # Point 메시지 생성 및 값 할당
        point_msg = Point()
        point_msg.x = current_x
        point_msg.y = current_y
        point_msg.z = 0

        # rospy.loginfo("Publishing: x=%.2f, y=%.2f", current_x, current_y)
        
        # 메시지 발행
        pub.publish(point_msg)
        
        # 다음 좌표를 위해 각도 업데이트
        angle += speed
        # 한 바퀴를 돌면 각도를 리셋하여 무한히 회전하도록 함
        if angle > 2 * math.pi:
            angle -= 2 * math.pi

        # 설정된 주기에 맞춰 대기
        rate.sleep()

if __name__ == '__main__':
    try:
        dynamic_coords_publisher()
    except rospy.ROSInterruptException:
        pass
