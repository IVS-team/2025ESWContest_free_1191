/**
 * 임베디드 소프트웨어 경진대회 출품작
 * URL: https://github.com/IVS-team/Embedded_Software_Contest
 * @brief     C-ITS 기반 사각지대 보행자 경고 시스템 — 차량측 데이터 처리 노드(entry point)
 * @version   1.0.0
 * @date      2025-09-04
 *
 * @copyright
 *   Copyright (c) 2025 20대쉬었음청년들.
 *   SPDX-License-Identifier: MIT
 *
* @author
 *   20대쉬었음청년들
 *   - 유진 <jin4god@inu.ac.kr>
 *   - 송승우 <susong22@snu.ac.kr>
 *   - 김용원 <yong98@koreatech.ac.kr>
 *   - 최헌규 <heongyu05@gmail.com>
 *   - 김현겸 <brigade98@konkuk.ac.kr>
 *
 * @par 프로젝트 개요
 *   인프라(CCTV)의 단안 카메라가 차량 사각지대 내 장애물(보행자 등)을 감지하여,
 *   C-ITS 통신을 통해 보행자의 절대좌표와 정보 등을 차량에 전달합니다. 
 *   차량은 수신한 객체를 GPS/IMU와 동기화하여 자차 좌표계로 변환하고, 
 *   Camera View 및 Top View로 시각화합니다.
 */

#include "processing.h"
#include "topview_srv.h"

int main(int argc, char** argv)
{
    ros::init(argc, argv, "data_processing_node");
    ros::NodeHandle nh;

    // 1) Infra와 통신하여 TopView Map Config 확보
    call_and_save_topview_map(nh);

    Processing processing;

    // 2) Publish: DataProcessing 처리 결과 
    ros::Publisher sync_pub =
        nh.advertise<msg_pkg::ProcessedObjectArray>("/car_10876/processed_objects", 10);

    // 3) Subscribe : GPS / Obstacle(Infra) - 동기화
    message_filters::Subscriber<sensor_msgs::NavSatFix> gps_sub(nh, "/fix", 10);
    message_filters::Subscriber<msg_pkg::DetectedObjectArray> obj_sub(nh, "/infra/object_coordinate", 10);

    // 4) ApproximateTime 동기화 설정: 서로 다른 주기(10/15 Hz)에 대응
    typedef message_filters::sync_policies::ApproximateTime<
        sensor_msgs::NavSatFix,
        msg_pkg::DetectedObjectArray
    > Sync2;

    message_filters::Synchronizer<Sync2> sync(Sync2(30), gps_sub, obj_sub);
    sync.setMaxIntervalDuration(ros::Duration(SYNC_TOL));  // 허용 간격: 0.05s
    sync.registerCallback(boost::bind(&Processing::syncCallback, &processing, _1, _2, sync_pub));

    // 5) Subscribe : IMU - 주파수가 높아 별도 콜백으로 최신 데이터 유지
    ros::Subscriber imu_sub = nh.subscribe<sensor_msgs::Imu>("/imu/data", 100,
                                &Processing::imuCallback, &processing);

    ROS_INFO("Data processing node started.");

    ros::spin();
    return 0;
}