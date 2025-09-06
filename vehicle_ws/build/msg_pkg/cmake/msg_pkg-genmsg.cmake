# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "msg_pkg: 4 messages, 1 services")

set(MSG_I_FLAGS "-Imsg_pkg:/home/nano/vehicle_ws/src/msg_pkg/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/melodic/share/sensor_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/melodic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(msg_pkg_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/srv/GetMapCompressed.srv" NAME_WE)
add_custom_target(_msg_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "msg_pkg" "/home/nano/vehicle_ws/src/msg_pkg/srv/GetMapCompressed.srv" "geometry_msgs/Vector3:sensor_msgs/CompressedImage:geometry_msgs/Point:std_msgs/Header"
)

get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg" NAME_WE)
add_custom_target(_msg_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "msg_pkg" "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg" "geometry_msgs/Point"
)

get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg" NAME_WE)
add_custom_target(_msg_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "msg_pkg" "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg" "geometry_msgs/Point"
)

get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObjectArray.msg" NAME_WE)
add_custom_target(_msg_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "msg_pkg" "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObjectArray.msg" "msg_pkg/DetectedObject:geometry_msgs/Point:std_msgs/Header"
)

get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObjectArray.msg" NAME_WE)
add_custom_target(_msg_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "msg_pkg" "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObjectArray.msg" "geometry_msgs/Point:msg_pkg/ProcessedObject:std_msgs/Header"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/msg_pkg
)
_generate_msg_cpp(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/msg_pkg
)
_generate_msg_cpp(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/msg_pkg
)
_generate_msg_cpp(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/msg_pkg
)

### Generating Services
_generate_srv_cpp(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/srv/GetMapCompressed.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/melodic/share/sensor_msgs/cmake/../msg/CompressedImage.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/msg_pkg
)

### Generating Module File
_generate_module_cpp(msg_pkg
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/msg_pkg
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(msg_pkg_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(msg_pkg_generate_messages msg_pkg_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/srv/GetMapCompressed.srv" NAME_WE)
add_dependencies(msg_pkg_generate_messages_cpp _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_cpp _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_cpp _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObjectArray.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_cpp _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObjectArray.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_cpp _msg_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(msg_pkg_gencpp)
add_dependencies(msg_pkg_gencpp msg_pkg_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS msg_pkg_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/msg_pkg
)
_generate_msg_eus(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/msg_pkg
)
_generate_msg_eus(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/msg_pkg
)
_generate_msg_eus(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/msg_pkg
)

### Generating Services
_generate_srv_eus(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/srv/GetMapCompressed.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/melodic/share/sensor_msgs/cmake/../msg/CompressedImage.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/msg_pkg
)

### Generating Module File
_generate_module_eus(msg_pkg
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/msg_pkg
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(msg_pkg_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(msg_pkg_generate_messages msg_pkg_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/srv/GetMapCompressed.srv" NAME_WE)
add_dependencies(msg_pkg_generate_messages_eus _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_eus _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_eus _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObjectArray.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_eus _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObjectArray.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_eus _msg_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(msg_pkg_geneus)
add_dependencies(msg_pkg_geneus msg_pkg_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS msg_pkg_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/msg_pkg
)
_generate_msg_lisp(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/msg_pkg
)
_generate_msg_lisp(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/msg_pkg
)
_generate_msg_lisp(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/msg_pkg
)

### Generating Services
_generate_srv_lisp(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/srv/GetMapCompressed.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/melodic/share/sensor_msgs/cmake/../msg/CompressedImage.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/msg_pkg
)

### Generating Module File
_generate_module_lisp(msg_pkg
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/msg_pkg
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(msg_pkg_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(msg_pkg_generate_messages msg_pkg_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/srv/GetMapCompressed.srv" NAME_WE)
add_dependencies(msg_pkg_generate_messages_lisp _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_lisp _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_lisp _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObjectArray.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_lisp _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObjectArray.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_lisp _msg_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(msg_pkg_genlisp)
add_dependencies(msg_pkg_genlisp msg_pkg_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS msg_pkg_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/msg_pkg
)
_generate_msg_nodejs(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/msg_pkg
)
_generate_msg_nodejs(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/msg_pkg
)
_generate_msg_nodejs(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/msg_pkg
)

### Generating Services
_generate_srv_nodejs(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/srv/GetMapCompressed.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/melodic/share/sensor_msgs/cmake/../msg/CompressedImage.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/msg_pkg
)

### Generating Module File
_generate_module_nodejs(msg_pkg
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/msg_pkg
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(msg_pkg_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(msg_pkg_generate_messages msg_pkg_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/srv/GetMapCompressed.srv" NAME_WE)
add_dependencies(msg_pkg_generate_messages_nodejs _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_nodejs _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_nodejs _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObjectArray.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_nodejs _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObjectArray.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_nodejs _msg_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(msg_pkg_gennodejs)
add_dependencies(msg_pkg_gennodejs msg_pkg_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS msg_pkg_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msg_pkg
)
_generate_msg_py(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msg_pkg
)
_generate_msg_py(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msg_pkg
)
_generate_msg_py(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msg_pkg
)

### Generating Services
_generate_srv_py(msg_pkg
  "/home/nano/vehicle_ws/src/msg_pkg/srv/GetMapCompressed.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/melodic/share/sensor_msgs/cmake/../msg/CompressedImage.msg;/opt/ros/melodic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/melodic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msg_pkg
)

### Generating Module File
_generate_module_py(msg_pkg
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msg_pkg
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(msg_pkg_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(msg_pkg_generate_messages msg_pkg_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/srv/GetMapCompressed.srv" NAME_WE)
add_dependencies(msg_pkg_generate_messages_py _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObject.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_py _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObject.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_py _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/DetectedObjectArray.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_py _msg_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nano/vehicle_ws/src/msg_pkg/msg/ProcessedObjectArray.msg" NAME_WE)
add_dependencies(msg_pkg_generate_messages_py _msg_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(msg_pkg_genpy)
add_dependencies(msg_pkg_genpy msg_pkg_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS msg_pkg_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/msg_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/msg_pkg
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(msg_pkg_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(msg_pkg_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(msg_pkg_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/msg_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/msg_pkg
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(msg_pkg_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(msg_pkg_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(msg_pkg_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/msg_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/msg_pkg
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(msg_pkg_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(msg_pkg_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(msg_pkg_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/msg_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/msg_pkg
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(msg_pkg_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(msg_pkg_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(msg_pkg_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msg_pkg)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msg_pkg\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msg_pkg
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(msg_pkg_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(msg_pkg_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(msg_pkg_generate_messages_py geometry_msgs_generate_messages_py)
endif()
