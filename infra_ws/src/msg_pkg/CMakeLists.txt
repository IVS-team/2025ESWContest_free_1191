cmake_minimum_required(VERSION 3.0.2)
project(msg_pkg)

find_package(catkin REQUIRED COMPONENTS
  message_generation
  std_msgs
  sensor_msgs
  geometry_msgs
)

add_service_files(
  FILES
  GetMapCompressed.srv
)

add_message_files(
  FILES
  DetectedObject.msg
  DetectedObjectArray.msg
  ProcessedObject.msg
  ProcessedObjectArray.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs sensor_msgs geometry_msgs
)

catkin_package(
  CATKIN_DEPENDS message_runtime std_msgs geometry_msgs
)
