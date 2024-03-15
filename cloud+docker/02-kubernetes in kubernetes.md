
~~~
helm v2 tiller 组件

~~~

https://kubernetes.io/

#### quickstart

kubectl: v1.14以上  
cert-manager: 1.0.0  
kubernetes v1.15+  
helm: v3以上  
网络: 有外网访问权限  


#### 背景
项目
  https://github.com/kvaps/kubernetes-in-kubernetes

#### 命令
~~~shell
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.0.1/cert-manager.yaml

helm show values kvaps/kubernetes > values.yaml
# modify the repository to inner network
kubectl create namespace foo
helm install foo kvaps/kubernetes --version 1.9.1 \
 --namespace foo \
 -f values.yaml

# helm install foo kvaps/kubernetes --version 1.9.1 \
#  --namespace foo \
#  --set persistence.storageClassName=local-path
registry.aliyuncs.com/google_containers/kube-apiserver:v1.20.2
~~~

docker pull registry.aliyuncs.com/google_containers/kube-apiserver:v1.20.2
docker pull us.gcr.io/k8s-artifacts-prod/kas-network-proxy/proxy-server:v0.0.14
docker pull registry.aliyuncs.com/google_containers/k8s-artifacts-prod/kas-network-proxy/proxy-server:v0.0.14

docker pull gcr.azk8s.cn/k8s-artifacts-prod/kas-network-proxy/proxy-server:v0.0.14