![header](https://capsule-render.vercel.app/api?type=waving&height=300&color=gradient&text=Invisible%20Vehicle%20System%20(IVS)&desc=20대쉬었음청년들&descAlign=87&descAlignY=57&fontAlignY=38&fontSize=59)


<p align="center">
  <img src="https://img.shields.io/badge/JetPack-5.1.2%20%7C%204.6.4-yellow"/> 
   <img src="https://img.shields.io/badge/OS-Ubuntu%2020.04%20%7C%2018.04-orange"/>
  <img src="https://img.shields.io/badge/ROS-Noetic%20%7C%20Melodic-blueviolet"/>
  <img src="https://img.shields.io/badge/build-catkin_make-blue"/>
  <img src="https://img.shields.io/badge/language-Python%20%7C%20C++-brightgreen"/> <br>
  <img src="https://img.shields.io/badge/status-prototype-red"/>
  <img src="https://img.shields.io/badge/license-MIT-green"/>
</p>




![ivs](https://github.com/user-attachments/assets/0b072fcd-7fb2-4f89-8236-fccdbafaf0ad)
![디스플레이_시연_영상](https://github.com/user-attachments/assets/b662a6a5-d24c-463b-9d00-ca13e4e08930)

## 개요
***Invisible Vehicle System***은 골목길 및 교차로에서 발생하는 시야의 공백을 V2I 기반으로 극복하여 사고를 예방하는 솔루션입니다.

단순히 인프라나 타 차량에서 촬영한 영상을 그대로 공유·송출하는 것이 아니라, 운전자 시점에 맞춰 재구성된 AR 기반 정보를 제공합니다.

이를 통해 운전자는 장애물을 직관적으로 인식할 수 있으며, 위험 상황에 대응할 수 있는 인지 시간을 크게 단축시킬 수 있습니다.

## 주요 기능
- 전방 카메라 영상에 장애물의 위치를 표시해 운전자에게 직관적인 위험 인식을 제공
- Top View를 통해 운전자가 장애물의 상대적 위치를 한눈에 파악
- 장애물의 위험도를 기반으로 경고음을 출력해 즉각적인 위험 알림 전달  

## 구성
### Infra System
- Camera : Logitech C270 HD
- Board : Jetsion xavier

### Vehicle System
- Camera : Royche RPC-20F
- Board : Jetson nano
- GPS : Ublox ZED-F9P
- IMU : MPU-9250 9축 자이로 센서 모듈 GY-9250
- Display : 제우스 포터블 모니터 

## 개발 환경
### Infra System
- **OS** : Ubuntu 20.04.6 LTS
- **ROS** : ROS Noetic Ninjemys
- **Python** : 3.8.10
- **Ultralytics YOLO** : 8.3.0
- **Jetpack** : 5.1.2

### Vehicle System
- **OS** : Ubuntu 18.04 LTS
- **ROS** : ROS Melodic Morenia
- **Python** : 2.7
- **Jsetpack** : 4.6.4

## 실행 방법
### 시스템 설치 및 빌드
```bash

# ubuntu 20.04

# 1. Create Workspace
$ mkdir -p ~/ivs_ws/src
$ cd ~/ivs_ws/src

# 2. Clone Packages
#   1) clone our packages
$ git clone https://github.com/username/our_ros_package.git
#   2) clone gps packages
$ git clone  https://github.com/ros-drivers/nmea_navsat_driver/tree/melodic-devel

# 3. Build and Source (catkin_make)
$ cd ~/ivs_ws
$ catkin_make
$ source ~/ivs_ws/devel/setup.bash
```

### 1. Infra System 실행
```bash
# 1. Execute roscore
$ roscore

# 2. (Open a new terminal) Move to infra package
$ cd ~/ivs_ws/src/infra

# 3. Execute infra system
$ python3 infra.py
```

### 2. Vehicle System 실행
```bash

# 1. Execute GPS node
$ roslaunch nmea_navsat_driver nmea_serial_driver.launch

# 2. Excute vehicle system
#   1) data processing node
$ rosrun data_processing data_processing node
#   2) user interface node
$ rosrun interface_node interface.py

```

## Related Works

**IMU**

1. [i2c_imu](https://github.com/jeskesen/i2c_imu#)
2. [RTIMULib](https://github.com/RPi-Distro/RTIMULib#)
   
**GPS**

1. [navsat_driver](https://github.com/ros-drivers/nmea_navsat_driver): melodic



