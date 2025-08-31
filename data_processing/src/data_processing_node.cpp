/*
==================================================================
1. gps, 객체 data, (imu) 동기화
2. 각 객체의 거리 및 위험도 계산
3. 차량 카메라 기준 상대 좌표로 변환
4. display_node에 객체 id, risk_level, relative&global 좌표 publish
==================================================================
*/
#include <ros/ros.h>
#include <sensor_msgs/NavSatFix.h>
#include <geometry_msgs/Point.h>
#include <cmath>

// 동기화를 위한 헤더
#include <message_filters/subscriber.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>

// TM 변환을 위한 헤더
#include <proj_api.h>

// 데이터 통신을 위한 custom message
#include "data_processing/DetectedObjectArray.h"
#include "data_processing/ProcessedObjectArray.h"

ros::Time last_gps_time;
bool first_message_received = false;
// 임의로 했음
double vehicle_yaw = 30.0;

// GPS(WGS84) 좌표를 TM 좌표로 변환하는 함수
void convertGpsToTm(double lon, double lat, double& tm_x, double& tm_y)
{
    projPJ wgs84, tm;
    wgs84 = pj_init_plus("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs");
    tm = pj_init_plus("+proj=tmerc +lat_0=38 +lon_0=127.002890 +k=1 +x_0=200000 +y_0=600000 +ellps=bessel +units=m +no_defs");
    if (!wgs84 || !tm) { ROS_ERROR("PROJ init failed."); tm_x=0; tm_y=0; return; }
    lon *= DEG_TO_RAD;
    lat *= DEG_TO_RAD;
    pj_transform(wgs84, tm, 1, 1, &lon, &lat, NULL);
    tm_x = lon;
    tm_y = lat;
    pj_free(wgs84);
    pj_free(tm);
}

// 거리에 따른 위험도 판단 함수
/*
HIGH: 3
...
NONE: 0
*/
int getRiskLevel(double distance)
{
    if (distance <= 50.0) return 3;
    if (distance > 50.0 && distance <= 75.0) return 2;
    if (distance > 75.0 && distance <= 100.0) return 1;
    return 0;
}

void syncCallback(const sensor_msgs::NavSatFixConstPtr& gps_msg,
                  const data_processing::DetectedObjectArrayConstPtr& objects_msg,
                  const ros::Publisher& pub)
{   
    last_gps_time = gps_msg->header.stamp;
    if (!first_message_received) {
        first_message_received = true;
        ROS_INFO("Initial messages received.");
    }

    double time_diff = std::abs(gps_msg->header.stamp.toSec() - objects_msg->header.stamp.toSec());
    if (time_diff > 0.03) {
        return;
    }

    double my_tm_x, my_tm_y;
    convertGpsToTm(gps_msg->longitude, gps_msg->latitude, my_tm_x, my_tm_y);
    
    data_processing::ProcessedObjectArray processed_array_msg;
    processed_array_msg.header.stamp = ros::Time::now();
    processed_array_msg.header.frame_id = "map";
    
    for (const auto& detected_obj : objects_msg->objects)
    {
        // 1. 병진 변환 (Translation)
        double delta_x = detected_obj.x - my_tm_x;
        double delta_y = detected_obj.y - my_tm_y;

        // 2. yaw 값 설정
        double yaw = vehicle_yaw * M_PI / 180.0;

        // 3. 회전 변환 (Rotation)
        // relative_x: 차량 전방(+) / 후방(-) 거리
        // relative_y: 차량 좌측(+) / 우측(-) 거리
        double relative_x = delta_x * cos(yaw) + delta_y * sin(yaw);
        double relative_y = -delta_x * sin(yaw) + delta_y * cos(yaw);


        // ------------------------------------

        // 4. 절대 거리 및 위험도 계산
        double distance = std::sqrt(delta_x*delta_x + delta_y*delta_y);
        int risk = getRiskLevel(distance);  

        // 5. 최종 메시지 채우기
        data_processing::ProcessedObject processed_obj;
        processed_obj.object_id = detected_obj.object_id;
        processed_obj.distance_m = distance;
        processed_obj.risk_level = risk;
        processed_obj.relative_position.x = relative_x;
        processed_obj.relative_position.y = relative_y;
        processed_obj.relative_position.z = 0;

        // 절대 좌표도 보내기로 함
        processed_obj.global_position.x = detected_obj.x;
        processed_obj.global_position.y = detected_obj.y;
        processed_obj.global_position.z = 0;       
        processed_array_msg.objects.push_back(processed_obj);
    }
    
    if (!processed_array_msg.objects.empty()) {
        pub.publish(processed_array_msg);
    }
}
int main(int argc, char** argv)
{
    ros::init(argc, argv, "data_processing_node");
    ros::NodeHandle nh;

    ros::Publisher sync_pub = nh.advertise<data_processing::ProcessedObjectArray>("/processed_objects", 10);

    // GPS와 객체 배열 2개만 구독
    // imu는 나중에
    message_filters::Subscriber<sensor_msgs::NavSatFix> gps_sub(nh, "/fix", 10);
    message_filters::Subscriber<data_processing::DetectedObjectArray> object_sub(nh, "/Infra/Obstacle_coordinate", 10);

    typedef message_filters::sync_policies::ApproximateTime<
        sensor_msgs::NavSatFix, 
        data_processing::DetectedObjectArray> MySyncPolicy;
    
    message_filters::Synchronizer<MySyncPolicy> sync(MySyncPolicy(10), gps_sub, object_sub);
    sync.registerCallback(boost::bind(&syncCallback, _1, _2, sync_pub));

    ROS_INFO("Data processing node started.");

    ros::Timer check_timer = nh.createTimer(ros::Duration(1.0), 
        [&](const ros::TimerEvent& event) {
            if (!first_message_received) {
                ROS_WARN("Waiting for initial sensor data...");
                return;
            }
            ros::Time current_time = ros::Time::now();
            if ((current_time - last_gps_time).toSec() > 1.0) {
                ROS_ERROR("Missing GPS data!");
            }
        });

    ros::spin();
    return 0;
}