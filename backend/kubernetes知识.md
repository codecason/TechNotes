Deployment  
    所有Pod共享存储  
    service都有ClusterIP,可以负载均衡  

StatefulSet  
    每个Pod有自己的存储  
Kubernetes 的 1.5 版本开始出现了 StatefulSet，StatefulSet 提供了一系列资源来处理有状态的容器，比如：volume，稳定的网络标识，从 0 到 N 的顺序索引等。通过为 Pod 编号，再使用 Kubernetes 里的两个标准功能：Headless Service 和 PV/PVC，实现了对 Pod 的拓扑状态和存储状态的维护，从而让用户可以在 Kubernetes 上运行有状态的应用。



    Flannel  
    Calico  

[UCloud基于Kubernetes Operator的服务化实践](https://www.infoq.cn/article/pPP3LRqf8BApcg3azNL3)
