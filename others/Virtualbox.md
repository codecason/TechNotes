1. 挂载共享目录

~~~
# mount -t vboxsf interface_folder_name <os_folder> 挂载共享文件夹到os_folder
mount -t vboxsf shared_virtualbox ~/comvb/
~~~

2.
~~~
other operations:shutdown the machine first,modify the settings of the os:
settings-shared folder - add fixed allocation
~~~

3. 插入CD光盘

~~~
进入主界面，弹出光盘即可，Insert Guest Additions CD image
~~~

4. 持久化共享

~~~
To mount a shared folder during boot, add the following entry to /etc/fstab:
sharename   /media/songs   vboxsf   defaults  0   0
~~~


5.重装系统后要做的事情

~~~
硬盘分区
安装GuestAddition.iso
自适应布局
配源
安装rz
配ssh-server，docker组
配golang，python，js
~~~

Prompt:

~~~
I have to reinstall ubuntu in virtualbox， and I have the following work to do in the virtualbox.
Please write a script to reduce the repeated work.
1. First, 安装GuestAddition.iso
2. change the sources.list source to https://mirrors.ustc.edu.cn and update apt
3. install lrzsz, net-tools
4. install and configure ssh-server to enable
5. configure docker and add current user to docker group
~~~

~~~
################################################
################################################
##########暂时不要用##############################
################################################
################################################
#!/bin/bash
#!/bin/bash

# Install Guest Additions
echo "Installing Guest Additions..."
VBoxGuestAdditions.iso="/path/to/VBoxGuestAdditions.iso" # Replace with the path to your GuestAdditions.iso
sudo mount -o loop $VBoxGuestAdditions.iso
sudo /media/cdrom/VBoxLinuxAdditions.run
sudo umount $VBoxGuestAdditions.iso

# Change the sources.list to use USTC mirror and update apt
echo "Changing sources.list to USTC mirror and updating apt..."
sudo sed -i 's|http://archive.ubuntu.com/ubuntu/|https://mirrors.ustc.edu.cn/ubuntu/|' /etc/apt/sources.list
sudo apt-get update

# Install lrzsz
echo "Installing lrzsz..."
sudo apt-get install -y lrzsz

# Install and configure ssh-server
echo "Installing and enabling ssh-server..."
sudo apt-get install -y openssh-server
sudo systemctl enable ssh && sudo systemctl start ssh

# Configure docker and add current user to docker group
echo "Configuring Docker and adding current user to docker group..."
sudo apt-get install -y docker.io
sudo systemctl enable docker && sudo systemctl start docker
sudo usermod -aG docker $USER

# Reload the Docker daemon to apply group changes
echo "Reloading Docker daemon..."
sudo systemctl daemon-reload

echo "Script execution completed!"

# End of script
~~~

6.

~~~
无网络环境下安装包
https://www.cnblogs.com/ddcoder/p/18024804
~~~

7.网卡未指定

~~~
https://www.bilibili.com/video/BV15T411p78F
VBoxNetLwf.inf
~~~
