#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
from geometry_msgs.msg import Point

def publish_coords():
    # ROS 노드 초기화
    rospy.init_node('coords_publisher_node', anonymous=True)
    # /object_coords 토픽에 Point 메시지를 발행하는 Publisher 생성
    pub = rospy.Publisher('/object_coords', Point, queue_size=10)
    # 1초에 1번씩 메시지를 발행하도록 속도 설정
    rate = rospy.Rate(1) 

    # --- 여기서 발행할 좌표를 수정하세요 ---
    target_x = 100
    target_y = 50
    # -----------------------------------

    rospy.loginfo("Publishing coordinates: x=%s, y=%s", target_x, target_y)

    while not rospy.is_shutdown():
        # Point 메시지 생성
        point_msg = Point()
        point_msg.x = target_x
        point_msg.y = target_y
        point_msg.z = 0  # 2D이므로 z는 0으로 설정

        # 메시지 발행
        pub.publish(point_msg)
        
        # 설정된 속도에 맞춰 대기
        rate.sleep()

if __name__ == '__main__':
    try:
        publish_coords()
    except rospy.ROSInterruptException:
        pass
