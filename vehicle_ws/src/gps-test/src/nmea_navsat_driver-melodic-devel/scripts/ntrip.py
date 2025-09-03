#!/usr/bin/env python3
import socket
import base64
import rospy
from std_msgs.msg import String
import time
import serial  # 시리얼 포트 사용을 위한 모듈

def create_ntrip_request(ntrip_server):
    user_and_password = f"{ntrip_server['user']}:{ntrip_server['password']}"
    encoded_credentials = base64.b64encode(user_and_password.encode('utf-8')).decode('utf-8')
    
    request = (
        f"GET /{ntrip_server['mountpoint']} HTTP/1.1\r\n"
        f"Host: {ntrip_server['ip']}\r\n"
        f"Ntrip-Version: Ntrip/2.0\r\n"
        f"User-Agent: NTRIP nmea_navsat_driver\r\n"
        f"Authorization: Basic {encoded_credentials}\r\n"
        f"\r\n"
    )
    return request

def connect_ntrip(ntrip_server):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect((ntrip_server['ip'], ntrip_server['port']))
        request = create_ntrip_request(ntrip_server)
        sock.send(request.encode('utf-8'))
        response = sock.recv(1024)
        rospy.loginfo(response)
        if b'200 OK' not in response:
            rospy.logerr("NTRIP 서버에 연결할 수 없습니다.")
            sock.close()
            return None
        return sock
    except Exception as e:
        rospy.logerr(f"NTRIP 서버에 연결 중 오류 발생: {e}")
        return None

def receive_rtcm_data(sock, ntrip_server, gps_serial):
    while not rospy.is_shutdown():
        try:
            data = sock.recv(1024)
            if not data:
                rospy.logwarn("No data received, attempting to reconnect...")
                sock = connect_ntrip(ntrip_server)  # 재연결 시도
                if not sock:
                    rospy.logerr("Reconnection failed, shutting down.")
                    break
                continue
            rospy.loginfo(f"Received RTCM data: {data.hex()}")
            gps_serial.write(data)  # RTCM 데이터를 GPS 수신기로 전송
        except socket.error as e:
            rospy.logerr(f"소켓 오류 발생: {e}")
            sock = connect_ntrip(ntrip_server)  # 소켓 오류 시 재연결 시도
            if not sock:
                rospy.logerr("Reconnection failed, shutting down.")
                break

def main():
    rospy.init_node('ntrip_client_node')
    
    ntrip_server = {
        'ip': 'www.gnssdata.or.kr',
        'port': 2101,
        'mountpoint': 'SUWN-RTCM31',
        'user': 'susong22@snu.ac.kr',
        'password': 'gnss',
    }

    # GPS 수신기에 연결할 시리얼 포트 설정
    gps_serial_port = '/dev/ttyACM0'  # 사용 중인 포트로 변경 필요
    gps_serial = serial.Serial(gps_serial_port, baudrate=115200, timeout=1)

    sock = None
    while not rospy.is_shutdown():
        if not sock:
            rospy.loginfo("NTRIP 서버에 연결을 시도합니다...")
            sock = connect_ntrip(ntrip_server)
            if sock:
                rospy.loginfo("NTRIP 서버에 연결되었습니다.")
            else:
                rospy.logwarn("NTRIP 서버 연결 실패, 10초 후 다시 시도합니다.")
                time.sleep(10)  # 연결 실패 시 10초 후 다시 시도
                continue
        
        receive_rtcm_data(sock, ntrip_server, gps_serial)

if __name__ == '__main__':
    main()
