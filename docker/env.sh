# Applied to every shell in the container (see Dockerfile).
export LIBGL_ALWAYS_SOFTWARE=1
export GALLIUM_DRIVER=llvmpipe
export QT_X11_NO_MITSHM=1
export ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST
export GZ_IP=127.0.0.1
[ -f /opt/ros/jazzy/setup.bash ] && . /opt/ros/jazzy/setup.bash
[ -f "$HOME/ros2_ws/install/setup.bash" ] && . "$HOME/ros2_ws/install/setup.bash"
# GUI apps started from VS Code / docker exec shells show up in the browser desktop.
export DISPLAY="${DISPLAY:-:1}"
