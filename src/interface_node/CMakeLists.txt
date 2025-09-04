cmake_minimum_required(VERSION 3.0.2)
project(interface_node)
find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  rospy
  std_msgs
  message_generation
)

generate_messages(
  DEPENDENCIES
  std_msgs geometry_msgs   
)

catkin_package(
  CATKIN_DEPENDS geometry_msgs rospy std_msgs message_runtime
)

include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)