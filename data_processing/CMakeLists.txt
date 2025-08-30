cmake_minimum_required(VERSION 3.0.2)
project(data_processing)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs              # <-- 추가: Header 메시지 사용을 위해
  sensor_msgs
  message_filters
  message_generation
  demo_pkg
)

add_message_files(
  FILES
  ProcessedObject.msg
  ProcessedObjectArray.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs              # <-- 수정: sensor_msgs는 메시지 생성에 직접 필요하지 않으므로 제거
)

catkin_package(
  # LIBRARIES ${PROJECT_NAME}
  CATKIN_DEPENDS          # <-- 수정: 다른 패키지가 이 패키지를 사용할 때 필요한 모든 의존성을 명시
    roscpp
    std_msgs
    sensor_msgs
    message_filters
    message_runtime
    demo_pkg
)

# 컴파일러에게 proj.h 파일이 있는 /usr/include 폴더를 보도록 명시
include_directories(
  ${catkin_INCLUDE_DIRS}
  /usr/include
)

add_executable(data_sync_node src/data_sync_node.cpp)
add_dependencies(data_sync_node ${PROJECT_NAME}_generate_messages_cpp)

# PROJ 라이브러리를 직접 링크
target_link_libraries(data_sync_node
  ${catkin_LIBRARIES}
  proj
)
