!/bin/bash
# 실행 시 오류 발생 시 바로 중단
set -e

# 1. ROS 환경 세팅
source /home/nano/gps-test/devel/setup.bash

# 2. NTRIP 클라이언트 실행 (백그라운드로 실행)
python3 /home/nano/gps-test/src/nmea_navsat_driver-melodic-devel/scripts/ntrip.py &

# 3. ROS 드라이버 실행
roslaunch nmea_navsat_driver nmea_serial_driver.launch

