#define ACCEPT_USE_OF_DEPRECATED_PROJ_API_H
#include "processing.h"

// 동기화 허용 시간 간격
const double SYNC_TOL = 0.05;

void Processing::convertGpsToTm(double lon, double lat, double& tm_x, double& tm_y)
{
    projPJ wgs84 = pj_init_plus("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs");
    projPJ tm    = pj_init_plus("+proj=tmerc +lat_0=38 +lon_0=127.002890 +k=1 +x_0=200000 +y_0=600000 +ellps=bessel +units=m +no_defs");
    if (!wgs84 || !tm) { ROS_ERROR("PROJ init failed."); tm_x=0; tm_y=0; if(wgs84) pj_free(wgs84); if(tm) pj_free(tm); return; }
    double lon_r = lon * DEG_TO_RAD;
    double lat_r = lat * DEG_TO_RAD;
    if (pj_transform(wgs84, tm, 1, 1, &lon_r, &lat_r, nullptr) != 0) {
        ROS_ERROR("PROJ transform failed."); pj_free(wgs84); pj_free(tm); tm_x=0; tm_y=0; return;
    }
    tm_x = lon_r; tm_y = lat_r;
    pj_free(wgs84); pj_free(tm);
}

// 거리 기반 위험도 판단 (미니어쳐 환경)
int Processing::getRiskLevel(double distance)
{
    if (distance <= 50.0)  return 3;
    if (distance <= 75.0)  return 2;
    if (distance <= 100.0) return 1;
    return 0;
}

bool Processing::pickClosestImu(const ros::Time& t_ref, ImuData& out)
{
    std::lock_guard<std::mutex> lk(imu_mtx);
    if (imu_buffer.empty()) return false;

    // 기준 시각과 가장 가까운 샘플 탐색
    double best_dt = 1e9;
    size_t best_idx = imu_buffer.size();
    for (size_t i = 0; i < imu_buffer.size(); ++i) {
        double dt = std::fabs((imu_buffer[i].stamp - t_ref).toSec());
        if (dt < best_dt) { best_dt = dt; best_idx = i; }
    }
    if (best_idx == imu_buffer.size()) return false;
    if (best_dt > SYNC_TOL) return false;

    out = imu_buffer[best_idx];
    return true;
}

// Vehicle Yaw값 계산
void Processing::imuCallback(const sensor_msgs::Imu::ConstPtr& msg)
{
    tf::Quaternion q; tf::quaternionMsgToTF(msg->orientation, q);
    double r,p,y; tf::Matrix3x3(q).getRPY(r,p,y);  // y: yaw(rad)

    std::lock_guard<std::mutex> lk(imu_mtx);
    imu_buffer.push_back(ImuData{msg->header.stamp, y});
    if (imu_buffer.size() > IMU_BUF_MAX) imu_buffer.pop_front();
}

// GPS + Object + Imu 동기화 콜백: 상대좌표 계산, 위험도 부여, 결과 Publish
void Processing::syncCallback(const sensor_msgs::NavSatFixConstPtr& gps_msg,
                  const msg_pkg::DetectedObjectArrayConstPtr& objects_msg,
                  const ros::Publisher& pub)
{
    last_gps_time = gps_msg->header.stamp;

    if (!first_message_received) {
        first_message_received = true;
        ROS_INFO("Initial messages received.");
    }

    const double dt_go = std::fabs((gps_msg->header.stamp - objects_msg->header.stamp).toSec());
    if (dt_go > SYNC_TOL) return;

    ImuData imu_sel;
    if (!pickClosestImu(gps_msg->header.stamp, imu_sel)) {
        ROS_WARN_THROTTLE(2.0, "No IMU sample within %.3fs of GPS time.", SYNC_TOL);
        return;
    }
    const double yaw_rad = imu_sel.yaw_rad;
    vehicle_yaw = yaw_rad;

    // 차량 위치 TM
    double my_tm_x=0, my_tm_y=0;
    convertGpsToTm(gps_msg->longitude, gps_msg->latitude, my_tm_x, my_tm_y);

    // 회전(월드→차량): R(-yaw)
    const double cy = std::cos(vehicle_yaw);
    const double sy = std::sin(vehicle_yaw);

    // 출력 메시지 생성
    msg_pkg::ProcessedObjectArray processed_array_msg;
    processed_array_msg.header.stamp = last_gps_time;
    processed_array_msg.header.frame_id = "map";
    processed_array_msg.vehicle_yaw = vehicle_yaw;
    processed_array_msg.vehicle_position.x = my_tm_x;
    processed_array_msg.vehicle_position.y = my_tm_y;

    for (const auto& detected_obj : objects_msg->objects)
    {
        // 상대좌표 계산
        const double delta_x = detected_obj.global_position.x - my_tm_x;
        const double delta_y = detected_obj.global_position.y - my_tm_y;

        const double relative_x =  delta_x * cy + delta_y * sy;   // 전방(+)
        const double relative_y = -delta_x * sy + delta_y * cy;   // 좌측(+)

        const double distance = std::hypot(delta_x, delta_y);
        const int risk = getRiskLevel(distance);

        msg_pkg::ProcessedObject processed_obj;
        processed_obj.object_id = detected_obj.object_id;
        processed_obj.relative_distance = distance;
        processed_obj.risk_level = risk;
        processed_obj.relative_position.x = relative_x;
        processed_obj.relative_position.y = relative_y;
        processed_obj.relative_position.z = 0.0;
        processed_obj.global_position.x = detected_obj.global_position.x;
        processed_obj.global_position.y = detected_obj.global_position.y;
        processed_obj.global_position.z = 0.0;

        processed_array_msg.objects.push_back(processed_obj);
    }

    if (!processed_array_msg.objects.empty()) {
        pub.publish(processed_array_msg);
    }
}
