~~~
在Ubuntu-20.04 安装 openstack stable/2023.1
默认的python版本是3.8

1.
sudo apt-get update
sudo apt-get upgrade -y
2. create user
sudo useradd -s /bin/bash -d /opt/stack -m stack

#### python update

#### 版本check
git clone https://github.com/openstack/devstack.git -b stable/2023.1
sudo mv devstack /opt/stack
sudo chown -R stack:stack /opt/stack

#### LocalConf
[[local|localrc]]
ADMIN_PASSWORD=secret
DATABASE_PASSWORD=$ADMIN_PASSWORD
RABBIT_PASSWORD=$ADMIN_PASSWORD
SERVICE_PASSWORD=$ADMIN_PASSWORD


./stack.sh

#### 时区同步
0

#### 安装conda 39
0(不考虑)


#### clean operation
./clean.sh    # This cleans up previous installations
./unstack.sh  # This stops all running services
./stack.sh    # This starts the installation process again 

#### 过程记录
python:pip_install:148
+functions-common:time_start:2412
+functions-common:git_timed:709
nova
placement
horizon
processing
create_neutron_accounts

#### python3的安装
apt-get install python-is-python3
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.9 -y
sudo add-apt-repository --remove ppa:deadsnakes/ppa
删除ppa

#### Reference
https://docs.openstack.org/install-guide/environment-packages-ubuntu.html
[ubuntu18]https://www.digitalocean.com/community/tutorials/install-openstack-ubuntu-devstack
https://medium.com/@hdhakad54/how-to-install-openstack-on-ubuntu-20-04-with-devstack-678549fbf9cb
~~~

