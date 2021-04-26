
#### Kubernetes
helm init -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.14.1 

k delete deploy tiller-deploy -n kube-system
k delete svc tiller-deploy -n kube-system


kubectl create secret generic harbor-registry-secret \
    --from-file=.dockerconfigjson=/root/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson \
    -n kube-system

#### 以安装Kruise为例
helm install kruise https://github.com/openkruise/kruise/releases/download/v0.7.0/kruise-chart.tgz --disable-openapi-validation


#### 基于Helm的发布管理

https://cloud.tencent.com/document/product/1141/41944
~~~shell
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
~~~

[基于Helm的发布管理](https://help.aliyun.com/document_detail/86791.html)

#### Helm v3
[为什么你应该快点转向helm v3](https://developer.aliyun.com/article/709187)

这也解释了为何 Helm 很快就提出了 Release 的概念，发布了 helm upgrade 、 helm rollback 等应用升级和回滚的能力。这些设计，其实都与 Helm 最终 PaaS 化的思路有着千丝万缕的联系。

[Helm V3 新版本发布](https://developer.aliyun.com/article/703821)  
- 架构性变化 - 去除了 Tiller
- 实验性功能 - 推送charts到容器镜像
- Library Chart支持

#### 下载 Helm v3
[下载资源](https://github.com/cloudnativeapp/workshop/tree/master/kubecon2019china/charts/guestbook#installing-helm-v3)

https://github.com/cloudnativeapp/charts

#### 源的管理

怎么安装helm,kubectl,operator-sdk等外网的docker源,避免因为没有对应的源而调度失败?

针对k8s.gcr.io,可以用阿里云的

如k8s.gcr.io/kube-apiserver:v1.20.2
替换成:
registry.aliyuncs.com/google_containers/kube-apiserver:v1.20.2

registry.aliyuncs.com/k8s-artifacts-prod/kas-network-proxy/proxy-agent:v0.0.14

## Helm 命令工具
从0开始制作云原生应用
~~~shell
helm init
helm create my-hello-world
helm install my-app my-hello-world-0.1.0.tgz --set
helm show values kvaps/kubernetes > values.yaml

~~~

排查工具
	tsar
