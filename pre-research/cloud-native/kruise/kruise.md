
helm install kruise https://github.com/openkruise/kruise/releases/download/v0.8.0/kruise-chart.tgz --set  manager.image.repository=openkruise-registry.cn-hangzhou.cr.aliyuncs.com/openkruise/kruise-manager

helm install kruise ./kruise-chart.tgz --set  manager.image.repository=openkruise-registry.cn-hangzhou.cr.aliyuncs.com/openkruise/kruise-manager

#### References
https://openkruise.io/zh-cn/docs/installation.html
