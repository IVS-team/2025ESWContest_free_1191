cmake_minimum_required(VERSION 3.0.2)
project(v2v_com)

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  roscpp
  std_msgs
  message_generation
)

add_message_files(
  FILES
  ObstacleData.msg
  V2V.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs geometry_msgs
)

catkin_package(
 CATKIN_DEPENDS geometry_msgs roscpp std_msgs message_runtime
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)

# Subscriber 노드 빌드 설정
add_executable(subscriber_node src/subscriber_node.cpp)
add_dependencies(subscriber_node ${PROJECT_NAME}_generate_messages_cpp)
target_link_libraries(subscriber_node
  ${catkin_LIBRARIES}
)
