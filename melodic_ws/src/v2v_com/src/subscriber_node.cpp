#include <ros/ros.h>
#include "v2v_com/V2V.h"

void v2vCallback(const v2v_com::V2V::ConstPtr& msg)
{
    double latency = (ros::Time::now() - msg->header.stamp).toSec();

    ROS_INFO("====== V2V Data Received ======");
    ROS_INFO("Sequence: %d", msg->header.seq);
    ROS_INFO("Latency: %.4f seconds", latency);
    ROS_INFO("Vehicle A Pos: [%.2f, %.2f], Yaw: %.2f", msg->a_global.x, msg->a_global.y, msg->a_yaw);
    ROS_INFO("Number of Obstacles: %zu", msg->obstacles.size());

    for (size_t i = 0; i < msg->obstacles.size(); ++i)
    {
        ROS_INFO("  Obstacle %zu Pos: [%.2f, %.2f], Dist: %.2f", i + 1,
                 msg->obstacles[i].obstacle_global.x,
                 msg->obstacles[i].obstacle_global.y,
                 msg->obstacles[i].a_ob_distance);
    }
    ROS_INFO("==============================\n");
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "vehicle_b_subscriber");
    ros::NodeHandle nh;

    ros::Subscriber sub = nh.subscribe("v2v_data", 1, v2vCallback);

    ros::spin();

    return 0;
}