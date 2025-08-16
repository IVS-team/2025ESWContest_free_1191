#include <ros/ros.h>
#include <cmath>
#include "v2v_com/V2V.h"
#include "v2v_com/ObstacleData.h"
#include <geometry_msgs/Point.h>
#include <std_msgs/Header.h>

int main(int argc, char **argv)
{
    ros::init(argc, argv, "vehicle_a_publisher");
    ros::NodeHandle nh;

    ros::Publisher pub = nh.advertise<v2v_com::V2V>("v2v_data", 1);
    ros::Rate loop_rate(20);

    int count = 0;

    while (ros::ok())
    {
        v2v_com::V2V msg;
        double time = count * 0.1;

        msg.header.seq = count;
        msg.header.stamp = ros::Time::now();
        msg.header.frame_id = "vehicle_a";

        msg.a_global.x = 1.0 + time;
        msg.a_global.y = 2.0 + sin(time);
        msg.a_yaw = 0.5 + 0.2 * cos(time);

        msg.obstacles.clear();

        v2v_com::ObstacleData obs1;
        obs1.obstacle_global.x = 10.0 + sin(time * 0.5);
        obs1.obstacle_global.y = 5.0 + cos(time * 0.5);
        obs1.ob_height = 1.8 + 0.1 * sin(time);
        obs1.ob_width = 0.7 + 0.1 * cos(time);
        obs1.a_ob_distance = 8.5 + cos(time * 2.0);
        msg.obstacles.push_back(obs1);

        v2v_com::ObstacleData obs2;
        obs2.obstacle_global.x = 15.0 + cos(time * 0.3);
        obs2.obstacle_global.y = 3.0 + sin(time * 0.3);
        obs2.ob_height = 0.5 + 0.05 * sin(time);
        obs2.ob_width = 1.2 + 0.1 * cos(time);
        obs2.a_ob_distance = 12.0 + sin(time);
        msg.obstacles.push_back(obs2);
        
        pub.publish(msg);
        
        ROS_INFO("Seq: [%d]", msg.header.seq);
        ROS_INFO("Vehicle A Pos: [%.2f, %.2f]", msg.a_global.x, msg.a_global.y);
        ROS_INFO("Num of Obstacles: %zu", msg.obstacles.size());

        ros::spinOnce();
        loop_rate.sleep();
        ++count;
    }

    return 0;
}