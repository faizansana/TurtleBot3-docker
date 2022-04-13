FROM ubuntu:20.04
SHELL ["/bin/bash" , "-c"]

# Setup environment variables
ENV name_os_version="focal"
ENV name_ros_version="noetic"
ENV name_catkin_workspace="catkin_ws"
ENV TZ=Etc/GMT-4

RUN apt update && apt upgrade
# Install general tools
RUN apt install -y wget curl
WORKDIR /downloads

# Install build environment
RUN apt install -y chrony ntpdate curl build-essential
# Add ROS repo
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN echo "deb http://packages.ros.org/ros/ubuntu ${name_os_version} main" > /etc/apt/sources.list.d/ros-latest.list
RUN apt update -y
# Install ros-desktop-full version of Noetic
RUN DEBIAN_FRONTEND=noninteractive apt install -y ros-${name_ros_version}-desktop-full
# Install RQT & Gazebo
RUN apt install -y ros-${name_ros_version}-rqt-* ros-${name_ros_version}-gazebo-*
# Environment setup
RUN apt install -y python3-rosinstall python3-rosinstall-generator python3-wstool build-essential git
# Install rosdep and update
RUN apt install python3-rosdep
RUN rosdep init && rosdep update
RUN mkdir -p $HOME/${name_catkin_workspace}/src
RUN source /opt/ros/$name_ros_version/setup.sh && cd $HOME/${name_catkin_workspace}/src && catkin_init_workspace
RUN source /opt/ros/$name_ros_version/setup.sh && cd $HOME/$name_catkin_workspace && catkin_make

# Setup ROS environment
COPY ./setup_ros_env.sh /downloads/setup_ros_env.sh
RUN bash /downloads/setup_ros_env.sh

RUN apt-get install -y ros-noetic-joy ros-noetic-teleop-twist-joy \
  ros-noetic-teleop-twist-keyboard ros-noetic-laser-proc \
  ros-noetic-rgbd-launch ros-noetic-rosserial-arduino \
  ros-noetic-rosserial-python ros-noetic-rosserial-client \
  ros-noetic-rosserial-msgs ros-noetic-amcl ros-noetic-map-server \
  ros-noetic-move-base ros-noetic-urdf ros-noetic-xacro \
  ros-noetic-compressed-image-transport ros-noetic-rqt* ros-noetic-rviz \
  ros-noetic-gmapping ros-noetic-navigation ros-noetic-interactive-markers

# Install TurtleBot3 packages
RUN apt install -y ros-noetic-dynamixel-sdk \
    ros-noetic-turtlebot3-msgs \
    ros-noetic-turtlebot3