execute_process(COMMAND "/home/nano/vehicle_ws/build/nmea_navsat_driver-melodic-devel/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/nano/vehicle_ws/build/nmea_navsat_driver-melodic-devel/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
