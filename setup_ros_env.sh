bash -c "echo \"alias eb='nano ~/.bashrc'\" >> ~/.bashrc"
bash -c "echo \"alias sb='source ~/.bashrc'\" >> ~/.bashrc"
bash -c "echo \"alias gs='git status'\" >> ~/.bashrc"
bash -c "echo \"alias gp='git pull'\" >> ~/.bashrc"
bash -c "echo \"alias cw='cd ~/$name_catkin_workspace'\" >> ~/.bashrc"
bash -c "echo \"alias cs='cd ~/$name_catkin_workspace/src'\" >> ~/.bashrc"
bash -c "echo \"alias cm='cd ~/$name_catkin_workspace && catkin_make'\" >> ~/.bashrc"

bash -c "echo \"source /opt/ros/$name_ros_version/setup.bash\" >> ~/.bashrc"
bash -c "echo \"source ~/$name_catkin_workspace/devel/setup.bash\" >> ~/.bashrc"

bash -c "echo \"export ROS_MASTER_URI=http://localhost:11311\" >> ~/.bashrc"
bash -c "echo \"export ROS_HOSTNAME=localhost\" >> ~/.bashrc"