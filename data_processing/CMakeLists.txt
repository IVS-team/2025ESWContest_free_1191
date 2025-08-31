cmake_minimum_required(VERSION 3.0.2)
project(data_processing)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  sensor_msgs
  message_filters
  message_generation
  geometry_msgs
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
  std_msgs
 geometry_msgs
)

catkin_package(
  # LIBRARIES ${PROJECT_NAME}
  CATKIN_DEPENDS
    roscpp
    std_msgs
    sensor_msgs
    message_filters
    message_runtime
    demo_pkg
    geometry_msgs
)

include_directories(
  ${catkin_INCLUDE_DIRS}
  /usr/include
)

add_executable(data_processing_node src/data_processing_node.cpp)
add_dependencies(data_processing_node ${PROJECT_NAME}_generate_messages_cpp)

target_link_libraries(data_processing_node
  ${catkin_LIBRARIES}
  proj
)
