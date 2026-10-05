#!/bin/bash
# Add our desktop shortcuts, then hand off to the base image's entrypoint
# (which creates the user, starts VNC + noVNC and chowns $HOME).
USER_HOME="/home/${USER:-ubuntu}"
mkdir -p "$USER_HOME/Desktop" "$USER_HOME/ros2_ws/src"
cp /opt/rosgz/desktop/*.desktop "$USER_HOME/Desktop/"
exec /bin/bash /entrypoint.sh
