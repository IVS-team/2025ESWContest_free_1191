#pragma once

/**
 * @brief TopView 맵/좌표 설정을 서비스에서 받아 로컬(config/)에 저장
 *
 * - 호출: /infra_node/get_map_png (demo_pkg/GetMapCompressed)
 * - 출력:
 *   - config/topview_map.(png|jpg|bin)
 *   - config/topview_config.json
 */

#include <ros/ros.h>
#include <msg_pkg/GetMapCompressed.h>
#include <sensor_msgs/CompressedImage.h>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Vector3.h>
#include <fstream>
#include <iomanip>
#include <algorithm>
#include <cctype>
#include <cstdlib>
#include <ros/package.h>
#include <sys/stat.h> 

bool call_and_save_topview_map(ros::NodeHandle& nh);
