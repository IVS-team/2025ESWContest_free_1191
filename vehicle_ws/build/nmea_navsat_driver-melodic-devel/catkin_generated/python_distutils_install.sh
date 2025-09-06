#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/nano/vehicle_ws/src/nmea_navsat_driver-melodic-devel"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/nano/vehicle_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/nano/vehicle_ws/install/lib/python2.7/dist-packages:/home/nano/vehicle_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/nano/vehicle_ws/build" \
    "/usr/bin/python2" \
    "/home/nano/vehicle_ws/src/nmea_navsat_driver-melodic-devel/setup.py" \
     \
    build --build-base "/home/nano/vehicle_ws/build/nmea_navsat_driver-melodic-devel" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/nano/vehicle_ws/install" --install-scripts="/home/nano/vehicle_ws/install/bin"
