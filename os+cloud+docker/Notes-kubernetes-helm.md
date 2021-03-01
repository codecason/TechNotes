
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

