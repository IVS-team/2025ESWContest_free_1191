# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "v2v_com: 2 messages, 0 services")

set(MSG_I_FLAGS "-Iv2v_com:/root/catkin_ws/src/v2v_com/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(v2v_com_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg" NAME_WE)
add_custom_target(_v2v_com_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "v2v_com" "/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg" "geometry_msgs/Point"
)

get_filename_component(_filename "/root/catkin_ws/src/v2v_com/msg/V2V.msg" NAME_WE)
add_custom_target(_v2v_com_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "v2v_com" "/root/catkin_ws/src/v2v_com/msg/V2V.msg" "std_msgs/Header:geometry_msgs/Point:v2v_com/ObstacleData"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(v2v_com
  "/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/v2v_com
)
_generate_msg_cpp(v2v_com
  "/root/catkin_ws/src/v2v_com/msg/V2V.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/v2v_com
)

### Generating Services

### Generating Module File
_generate_module_cpp(v2v_com
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/v2v_com
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(v2v_com_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(v2v_com_generate_messages v2v_com_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg" NAME_WE)
add_dependencies(v2v_com_generate_messages_cpp _v2v_com_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/root/catkin_ws/src/v2v_com/msg/V2V.msg" NAME_WE)
add_dependencies(v2v_com_generate_messages_cpp _v2v_com_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(v2v_com_gencpp)
add_dependencies(v2v_com_gencpp v2v_com_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS v2v_com_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(v2v_com
  "/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/v2v_com
)
_generate_msg_eus(v2v_com
  "/root/catkin_ws/src/v2v_com/msg/V2V.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/v2v_com
)

### Generating Services

### Generating Module File
_generate_module_eus(v2v_com
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/v2v_com
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(v2v_com_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(v2v_com_generate_messages v2v_com_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg" NAME_WE)
add_dependencies(v2v_com_generate_messages_eus _v2v_com_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/root/catkin_ws/src/v2v_com/msg/V2V.msg" NAME_WE)
add_dependencies(v2v_com_generate_messages_eus _v2v_com_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(v2v_com_geneus)
add_dependencies(v2v_com_geneus v2v_com_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS v2v_com_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(v2v_com
  "/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/v2v_com
)
_generate_msg_lisp(v2v_com
  "/root/catkin_ws/src/v2v_com/msg/V2V.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/v2v_com
)

### Generating Services

### Generating Module File
_generate_module_lisp(v2v_com
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/v2v_com
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(v2v_com_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(v2v_com_generate_messages v2v_com_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg" NAME_WE)
add_dependencies(v2v_com_generate_messages_lisp _v2v_com_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/root/catkin_ws/src/v2v_com/msg/V2V.msg" NAME_WE)
add_dependencies(v2v_com_generate_messages_lisp _v2v_com_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(v2v_com_genlisp)
add_dependencies(v2v_com_genlisp v2v_com_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS v2v_com_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(v2v_com
  "/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/v2v_com
)
_generate_msg_nodejs(v2v_com
  "/root/catkin_ws/src/v2v_com/msg/V2V.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/v2v_com
)

### Generating Services

### Generating Module File
_generate_module_nodejs(v2v_com
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/v2v_com
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(v2v_com_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(v2v_com_generate_messages v2v_com_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg" NAME_WE)
add_dependencies(v2v_com_generate_messages_nodejs _v2v_com_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/root/catkin_ws/src/v2v_com/msg/V2V.msg" NAME_WE)
add_dependencies(v2v_com_generate_messages_nodejs _v2v_com_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(v2v_com_gennodejs)
add_dependencies(v2v_com_gennodejs v2v_com_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS v2v_com_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(v2v_com
  "/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/v2v_com
)
_generate_msg_py(v2v_com
  "/root/catkin_ws/src/v2v_com/msg/V2V.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/v2v_com
)

### Generating Services

### Generating Module File
_generate_module_py(v2v_com
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/v2v_com
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(v2v_com_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(v2v_com_generate_messages v2v_com_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/root/catkin_ws/src/v2v_com/msg/ObstacleData.msg" NAME_WE)
add_dependencies(v2v_com_generate_messages_py _v2v_com_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/root/catkin_ws/src/v2v_com/msg/V2V.msg" NAME_WE)
add_dependencies(v2v_com_generate_messages_py _v2v_com_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(v2v_com_genpy)
add_dependencies(v2v_com_genpy v2v_com_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS v2v_com_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/v2v_com)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/v2v_com
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(v2v_com_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(v2v_com_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/v2v_com)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/v2v_com
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(v2v_com_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(v2v_com_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/v2v_com)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/v2v_com
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(v2v_com_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(v2v_com_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/v2v_com)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/v2v_com
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(v2v_com_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(v2v_com_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/v2v_com)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/v2v_com\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/v2v_com
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(v2v_com_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(v2v_com_generate_messages_py geometry_msgs_generate_messages_py)
endif()
