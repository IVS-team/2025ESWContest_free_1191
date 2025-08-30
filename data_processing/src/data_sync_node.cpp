/*
==================================================================
gps, image, object_array 3개 데이터 동기화
각 객체의 거리 및 위험도 계산 후 publish
==================================================================
*/
#include <ros/ros.h>
#include <sensor_msgs/NavSatFix.h>
#include <sensor_msgs/CompressedImage.h>
#include <geometry_msgs/Point.h>
#include <message_filters/subscriber.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include <cmath>
#include <proj_api.h>

// [수정] 실제 패키지 이름으로 변경
#include "demo_pkg/DetectedObjectArray.h"
#include "data_processing/ProcessedObjectArray.h"

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

// 거리에 따른 위험도를 결정하는 함수
std::string getRiskLevel(double distance)
{
    if (distance < 15.0) return "R";
    if (distance < 40.0) return "O";
    if (distance < 70.0) return "Y";
    return "None";
}

// 3개 메시지를 동기화하여 처리하는 콜백 함수
// [수정] 콜백 함수의 파라미터 타입을 실제 패키지 이름으로 변경
void syncCallback(const sensor_msgs::NavSatFixConstPtr& gps_msg,
                  const sensor_msgs::CompressedImageConstPtr& image_msg,
                  const demo_pkg::DetectedObjectArrayConstPtr& objects_msg,
                  const ros::Publisher& pub)
{
    double my_tm_x, my_tm_y;
    convertGpsToTm(gps_msg->longitude, gps_msg->latitude, my_tm_x, my_tm_y);
    
    // [수정] 발행할 메시지 타입을 실제 패키지 이름으로 변경
    data_processing::ProcessedObjectArray processed_array_msg;
    processed_array_msg.header.stamp = ros::Time::now();
    processed_array_msg.header.frame_id = "map";
    
    for (const auto& detected_obj : objects_msg->objects)
    {
        double dx = my_tm_x - detected_obj.x;
        double dy = my_tm_y - detected_obj.y;
        double distance = std::sqrt(dx*dx + dy*dy);
        std::string risk = getRiskLevel(distance);
        
        // [수정] 개별 객체 정보 타입을 실제 패키지 이름으로 변경
        data_processing::ProcessedObject processed_obj;
        processed_obj.object_class = detected_obj.object_class;
        processed_obj.distance_m = distance;
        processed_obj.risk_level = risk;
        
        processed_array_msg.objects.push_back(processed_obj);
    }
    
    if (!processed_array_msg.objects.empty()) {
        pub.publish(processed_array_msg);
    }
}

int main(int argc, char** argv)
{
    ros::init(argc, argv, "data_sync_node");
    ros::NodeHandle nh;

    // [수정] 발행자 타입을 실제 패키지 이름으로 변경
    ros::Publisher sync_pub = nh.advertise<data_processing::ProcessedObjectArray>("/processed_objects", 10);

    message_filters::Subscriber<sensor_msgs::NavSatFix> gps_sub(nh, "/fix", 10);
    message_filters::Subscriber<sensor_msgs::CompressedImage> image_sub(nh, "/webcam/image_raw/compressed", 10);
    // [수정] 구독자 타입을 실제 패키지 이름으로 변경
    message_filters::Subscriber<demo_pkg::DetectedObjectArray> object_sub(nh, "/detected_objects", 10);

    // [수정] 동기화 정책 타입을 실제 패키지 이름으로 변경
    typedef message_filters::sync_policies::ApproximateTime<
        sensor_msgs::NavSatFix, 
        sensor_msgs::CompressedImage, 
        demo_pkg::DetectedObjectArray> MySyncPolicy;
    
    message_filters::Synchronizer<MySyncPolicy> sync(MySyncPolicy(10), gps_sub, image_sub, object_sub);
    sync.registerCallback(boost::bind(&syncCallback, _1, _2, _3, sync_pub));

    ROS_INFO("Data synchronizer node started.");
    ros::spin();
    return 0;
}
