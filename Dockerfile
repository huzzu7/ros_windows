# ROS 2 Jazzy + Gazebo Harmonic desktop in the browser, CPU-rendered.
# Pinned by digest so every laptop gets the exact same bits.
FROM tiryoh/ros2-desktop-vnc:jazzy@sha256:0805be8174739ce4f81cfd81d44c04efb75370ccd70f733e0ca46842c4ce5acd

# Hardware independence: never touch a host GPU, always render with Mesa llvmpipe.
# Networking: keep ROS 2 / Gazebo discovery inside the container so host
# networks, VPNs and Docker Desktop's NAT can't change behaviour.
ENV LIBGL_ALWAYS_SOFTWARE=1 \
    GALLIUM_DRIVER=llvmpipe \
    QT_X11_NO_MITSHM=1 \
    ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST \
    GZ_IP=127.0.0.1 \
    DISPLAY=:1

COPY docker/env.sh /etc/profile.d/rosgz-env.sh
RUN echo '. /etc/profile.d/rosgz-env.sh' >> /etc/bash.bashrc

COPY docker/desktop/ /opt/rosgz/desktop/
COPY docker/rosgz-entrypoint.sh /rosgz-entrypoint.sh
RUN chmod +x /rosgz-entrypoint.sh /opt/rosgz/desktop/*.sh \
    && sed -i 's/\r$//' /rosgz-entrypoint.sh /etc/profile.d/rosgz-env.sh /opt/rosgz/desktop/*

ENTRYPOINT ["/rosgz-entrypoint.sh"]
