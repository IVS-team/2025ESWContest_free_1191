/**
 * @brief 데이터 처리 클래스
 *
 * - GPS 좌표 변환(WGS84 → TM)
 * - IMU yaw 보간/선택
 * - 객체 상대좌표 계산 및 위험도 판정
 * - 결과 메시지 Publish
 */

#pragma once

#include <ros/ros.h>
#include <sensor_msgs/NavSatFix.h>
#include <sensor_msgs/Imu.h>
#include <geometry_msgs/Point.h>
#include <tf/transform_datatypes.h>
#include <deque>
#include <mutex>
#include <cmath>
#include <proj_api.h>
#include <boost/bind.hpp>
#include <fstream>
#include <iomanip>
#include <algorithm>
#include <cctype>

#include <message_filters/subscriber.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>

#include "msg_pkg/DetectedObjectArray.h"
#include "msg_pkg/ProcessedObjectArray.h"
#include <msg_pkg/GetMapCompressed.h>

extern const double SYNC_TOL;

struct ImuData {
    ros::Time stamp;
    double yaw_rad;
};

class Processing{
public:
    void convertGpsToTm(double lon, double lat, double& tm_x, double& tm_y);
    int  getRiskLevel(double distance);
    bool pickClosestImu(const ros::Time& t_ref, ImuData& out);
    void imuCallback(const sensor_msgs::Imu::ConstPtr& msg);
    void syncCallback(const sensor_msgs::NavSatFixConstPtr& gps_msg,
                    const msg_pkg::DetectedObjectArrayConstPtr& objects_msg,
                    const ros::Publisher& pub);

private:
    std::mutex imu_mtx;
    std::deque<ImuData> imu_buffer;
    const size_t IMU_BUF_MAX = 500;
    double vehicle_yaw = 0.0;
    ros::Time last_gps_time;
    bool first_message_received = false;
};





