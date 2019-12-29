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


SVN

    linux 下停止所有的svn服务
    killall svnserve
    基于Docker搭建一个SVN服务器 https://www.missshi.cn/api/view/blog/5a9bfdd35b925d5dce000000
    指定端口号启动服务
    svnserve -d –listen-port 3691 -r /opt/svn/repository
  原文：https://blog.csdn.net/nanshaowei/article/details/52506083
