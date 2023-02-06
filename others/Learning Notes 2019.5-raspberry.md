
### 1. raspberry
#### Raspbian 安装
  接网线 + 扫描IP(注意同一网段)  
  要想连接路由: VNC 路由  
  VNC Viewer: 可视化界面  
  默认密码要改: sudo passwd pi + sudo passwd root  

#### 2. 自定义可重烧录的树莓派镜像

#### 3. Raspbian 配置
3.2 设置wifi连接(有网线连接可跳过此处)
```
在boot分区下新建wpa_supplicant.conf文件
ssid 为wifi 名称
psk 为wifi密码
country=CN
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
```

network={
    ssid="wifiname"
    psk="password"
    priority=1
}
- 打开时区设置
sudo dpkg-reconfigure tzdata
- 选择Asia  ---> ShangHai

#### 3.3 修改系统软件源
    # 树莓派系统默认使用nano做为编辑器，修改完成后使用ctrl+x退出，退出时会提示是否保存文件, 按Y即可
    sudo nano /etc/apt/sources.list
    # 修改系统源为清华大学源
    deb http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ stretch main contrib non-free rpi
    deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ stretch main contrib non-free rpi
- 3.4 更换pip源
```shell
# 国内源
# 阿里云 https://mirrors.aliyun.com/pypi/simple/
# 中国科技大学 https://pypi.mirrors.ustc.edu.cn/simple/
# 豆瓣(douban) http://pypi.douban.com/simple/
# 清华大学 https://pypi.tuna.tsinghua.edu.cn/simple/
# 中国科学技术大学 http://pypi.mirrors.ustc.edu.cn/simple/

# 临时使用某一个源下载
pip install scrapy -i https://pypi.tuna.tsinghua.edu.cn/simple

# 更换源
# linux 编辑~/.pip/pip.conf , 如果不存在就新建一个
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple

# windows 在C:\Users\[username]\pip目录下新建pip.ini文件
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
```

####  vnc-server
```shell
# 给板子装服务端
sudo apt-get install tightvncserver
# 开启一个 VNC 流，代号为 1， 冒号前有一个空格
tightvncserver :1
# 输入命令后，即可开启服务
# 第一个运行时，会做初始化设置，按提示设置访问权限、连接密码，密码限制为8个字符
```

#### 配置WIFI连接(和断开)
```shell
vi /etc/network/interfaces
  > iface wlan0 inet dhcp 
  > wpa_conf /etc/wpa_supplicant/wpa_supplicant.conf
https://www.jianshu.com/p/e311e3f5a566
vi /etc/wpa_supplicant/wpa_supplicant.conf
  > network={
    ssid=""
    psk=""
    priority=1
  }
sudo service wpa_supplicant restart
wpa_cli -i wlan0 reconfigure #不用重启树莓派
```

**树莓派设置 WiFi 一定要重启才能生效吗?**  https://www.v2ex.com/amp/t/446403

#### 安装docker
  Error!  The dkms.conf for this module includes a BUILD_EXCLUSIVE directive which
  does not match this kernel/arch.  This indicates that it should not be built.

#### 安装image-net
   docker pull clarkchan/rpi-tensorflow-imagenet

#### 装SVN_SERVER
  sudo docker run -itd -p 3690:3690 --privileged=true --name=svn_server -v /opt/data/svn/data_repo:/var/opt/svn -e SVN_REPONAME=data_repo garethflowers/svn-server

[**GIT ISSUE 解决**]
  https://github.com/docker/hub-feedback/issues/1675
  my 'slow pull'-problem was solved today: after an update of the raspi software and a downgrade of docker-ce to '18.06.2ce3-0~raspbian', the pull command worked with normal speed - magic :-)

**References**

**镜像版本下载**

树莓派实验室 http://shumeipai.nxez.com/2013/09/07/how-to-install-and-activate-raspberry-pi.html  
Raspbian下载 https://www.raspberrypi.org/downloads/raspbian/  
USB Image Tool:【树莓派】如何烧录镜像详细版 http://www.cnblogs.com/jakeyChen/p/9304538.html  
QA平台 https://unix.stackexchange.com  
树莓派一键部署系列之一：tensorflow上的神经网络图像识别程序 https://www.jianshu.com/p/c1ae2127221d  
Docker hub:Extremely Slow Image Pulls https://github.com/docker/hub-feedback/issues/1675  
