#### 1.
~~~
> Dockerfile.centos
  FROM centos
  RUN    yum -y install gcc automake autoconf libtool make \
  && yum -y install vim \
  && yum -y install gdb \
  && yum -y install subversion \
  && yum install kde-l10n-Chinese -y \
  && yum reinstall glibc-common -y \
  && yum -y remove subversion \
  && yum -y install subversion \
  && yum -y autoremove
~~~

#### 2. 启动服务
sudo docker run -itd -p 21025:22 --privileged=true --name=demo_svn_centos -v /home2/svn_centos:/home -e LC_CTYPE="zh_CN.UTF-8" -e IS_PARALLELLY_MAKE="1" svn_centos

#### 3. 自制镜像生命周期管理流程

~~~
    docker build -f ./Dockerfile -t svn_centos .
    sudo docker run -itd -p 3691:3690 --privileged=true --name=demo_svn_centos -v /home2/demo_svn_centos:/home -e LC_CTYPE="zh_CN.UTF-8" -e IS_PARALLELLY_MAKE="1" svn_centos
    // 清理测试docker images和docker container:
    docker stop demo_svn_centos
    docker rmi svn_centos
    docker rm demo_svn_centos
~~~

#### 4. **从docker hub的svn-server搭建SVN服务**
    docker pull garethflowers/svn-server
    sudo docker run -itd -p 3691:3690 --privileged=true --name=svn_server -v /home2/svn_server:/var/opt/svn -e SVN_REPONAME=repository garethflowers/svn-server
    docker exec -it svn_server /bin/sh
    svnadmin create /var/opt/svn/LCC
    cd LCC/conf
    vi svnserver.conf
    vi passwd
    vi authz
    exit
    docker cp svn_server:/var/opt/svn/LCC /home2/svn_server/

#### 5. 从alpine测试相同过程
~~~shell
    docker stop svn_server && docker rm svn_server && rm -rf 
    cd ~/working_space/svn_server
    docker pull alpine:3.9
    cd /home/svn_base
    vi Dockerfile
    docker build -f ./Dockerfile -t demo/svn_server .
    // Import and Export Images
    docker save -o rasp_svn_server.tar demo/svn_server
    docker load rasp_svn_server.tar
    sudo docker run -itd -p 3691:3690 --privileged=true --name=svn_server_tmp -v /home2/svn_server_tmp/svn_server:/var/opt/svn -e SVN_REPONAME=repository demo/rasp_svn_server
~~~

Kubenetes
#### 1.kubeadm

#### 2.kubectl

#### 3.cri-o
#####　Prerequisites
~~~shell
modprobe overlay
modprobe br_netfilter

# Setup required sysctl params, these persist across reboots.
cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system
~~~

add-apt-repository ppa:projectatomic/ppa
apt-get update && apt-get install crio-o-1.15
ln -s /usr/bin/conmon /usr/libexec/crio/conmon
system-ctl start crio

#### X.containerd
~~~shell
# Install containerd
## Set up the repository
### Install packages to allow apt to use a repository over HTTPS
apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common

### Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

### Add Docker apt repository.
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

## Install containerd
apt-get update && apt-get install -y containerd.io

# Configure containerd
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml

# Restart containerd
systemctl restart containerd
~~~

#### kubeadm
~~~shell
apt-get update && apt-get install -y apt-transport-https
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
systemctl enable kubelet && systemctl start kubelet
~~~

~~~
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system
~~~
SVN

    linux 下停止所有的svn服务
    killall svnserve
    基于Docker搭建一个SVN服务器 https://www.missshi.cn/api/view/blog/5a9bfdd35b925d5dce000000
    指定端口号启动服务
    svnserve -d –listen-port 3691 -r /opt/svn/repository
  原文：https://blog.csdn.net/nanshaowei/article/details/52506083

PPA 增删
    add-apt-repository ppa:projectatomic/ppa  
    sudo add-apt-repository --remove ppa:projectatomic/ppa

~~~
Docker添加普通用户
~~~

sudo groupadd docker
usermod -aG docker $USER
newgrp docker


~~~
Docker 应用遇到的网络问题和配置
~~~

[Kubernetes(一) 跟着官方文档从零搭建K8S](https://juejin.im/post/5d7fb46d5188253264365dcf)  
[快速创建Kubernetes集群](https://help.aliyun.com/document_detail/85903.html?spm=a2c4g.11174283.4.1.17742ceeQ8XKmy)  
[aliyun 的Kubernetes源](https://developer.aliyun.com/mirror/kubernetes)


如何从镜像反推Dockerfile

    docker history --format {{.CreatedBy}} --no-trunc=true ImageID/Name
