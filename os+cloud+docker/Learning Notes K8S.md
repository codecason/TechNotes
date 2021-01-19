LXC cgroups Union FS = Docker

1.Kubernetes集群的基本结构

2.kubectl的基本使用

3.Resource的基本概念

4.Namespace的基本概念

kubeadm
#### Pod是什么?


Kubernetes实战功能
1. 安装Kubernetes
2. 

知识点: 1.Kubernetes内置的的账号管理及特点 2.Kubernetes采用的权限控制模型及模型特点 3.Kubernetes创建新的ServiceAccount 4.Kubernetes通过ServiceAccount控制资源访问

知识点: 1.熟悉Go应用的编译和镜像构建 2.熟悉Go应用打包好的镜像推送 3.熟悉如何使用YAML配置创建一个Pod 4.熟悉如何使用YAML配置创建一个Service 5.熟悉如何通过Service访问Pod中的应用

lab-classic

实验 4

搭建命令行管理工具的基本框架
需加入课程后学习，点击加入

知识点: 1.熟悉命令行工具开发框架cobra的使用 2.熟悉命令行工具的基本设计和开发方式 3.分析Kubernetes管理工具的基本功能 4.使用cobra搭建命令行工具的基本框架

知识点: 1.学习Kubernetes中Pod的作用和组成 2.学习如何使用GoSDK来创建Pod对象 3.学习如何使用GoSDK来更新Pod对象 4.学习如何使用GoSDK来获取Pod对象 5.学习如何使用GoSDK来删除Pod对象

知识点: 1.学习Kubernetes中Service的作用和组成 2.学习如何使用GoSDK来创建Service对象 3.学习如何使用GoSDK来更新Service对象 4.学习如何使用GoSDK来获取Service对象 5.学习如何使用GoSDK来删除Service对象

实验 7
开发 Ingress 管理的相关功能

开发 Secret 管理的相关功能

开发 Deployment 管理的相关功能


https://juejin.im/post/5d7fb46d5188253264365dcf
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
sudo update-alternatives --set arptables /usr/sbin/arptables-legacy
sudo update-alternatives --set ebtables /usr/sbin/ebtables-legacy

References:
实验楼
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.23.0/minikube-linux-amd64
chmod +x minikube && sudo mv minikube /usr/local/bin
minikube start

curpath=${curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt}
curl -Lo https://storage.googleapis.com/kubernetes-release/release/$(curpath)/bin/linux/amd64/kubectl
chmod +x kubectl && sudo mv kubectl /usr/local/bin
kubectl cluster-info
kubectl get nodes
echo `alias k=kubectl` >> ~/.bashrc
kubectl run kubia --image=luska/kubia --port=8080 --generator=run/v1

apt-get install virtualbox

启动Node.js
	kubectl run kubia --image=luksa/kubia --port=8080 --generator=run/v1
kubectl get pods
kubectl get services
同一pod名称会有不同的IP地址，并且运行的服务不相同;
所以要用IP地址做引用,而非其他地址做引用

