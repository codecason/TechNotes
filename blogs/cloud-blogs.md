

在[微服务](https://so.csdn.net/so/search?q=微服务&spm=1001.2101.3001.7020)带来便利的同时产生了新的挑战，如何对所有微服务进行快速部署？本文将介绍PPmoney如何践行推广容器化，建立应用从开发测试到部署的DevOps流程，提高团队工作效率。

云平台介绍

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/1708fdcac61cedac5979fc1b01e5ac23.png)

先给大家看看我们研发云1.x时候的一个包含部分微服务的关系图。

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/57fcf087eccf306b775bb715447abe98.png)

这边使用的主流语言是Java，Spring全家桶做后端服务，Python做数据相关开发，Node主要做前端应用。在此前还有.NET的SOA服务。如果采用传统虚拟机部署一整套开发环境的话，因为环境不一致，配置不规范等因素，可能需要运维同学花费一整周的时间来部署并调通环境。所以快速部署的需求是非常迫切的，于是我们开始打造内部的基于[Kubernetes](https://so.csdn.net/so/search?q=Kubernetes&spm=1001.2101.3001.7020)的容器研发云，代号“基拉祈”，又名“许愿星”，来源于Pokemon（我们架构部的很多基础框架应用都取名来自于此），希望能够通过Jirachi平台提供各种类型的问题的解决方案。

大致架构图：

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/90905a3e5d7e91f551150663b9c83389.png)

**Kubernetes集群部署**

基于kubeadm部署工具，现在新版本功能越来越完善，而且可以通过[alpha ]phase将初始化各阶段操作解耦。对于集群自动化操作，配合Ansible playbook使用更佳，推荐参考Kubespray[1]，如果是想对Kubernetes各组件有更深了解的话可以参考Kubernetes The Hard Way[2]。

刚入坑的同学可能遇到的一些比较常见的问题：

- 关于墙的问题，可以是先在能科学上网的机器上Pull再Push到内网的镜像仓库（我们使用的Harbor，主要后续IDC、云以及内网之间可以通过镜像复制功能进行镜像同步），或者是使用registry.cn-hangzhou.aliyuncs.com/google_containers/或gcr.azk8s.cn/google_containers/这些公有的镜像仓库， 然后通过指定--image-repository参数或者是config文件中的imageRepository字段来初始化/升级集群。
- 集群的证书期限问题，可以通过renew subcommand实现证书续期，当然改动源码将默认一年期改成更长的时间也是个方法，但是其实Kubernetes每个版本都有一个支持期，在升级版本的时候kubeadm工具会检查证书期限并执行renew操作。

说说我们的网络方案选型，因为在这边没有专业的网络研发的同学，所以只能用社区的开源方案。入门的话推荐选择配置相对较少的Flannel，熟悉了之后可以看看Calico/Kube-OVN这样子的方案。

我们想使用Calico的主要原因是需要通过BGP协议来实现打通原有网络以及容器内部网络，场景是集群内外的服务发现调用。但是在测试的时候遇到一个难题，集群外部Client无法调用集群内部的TCP类型服务，具体issue[3]，如对这方面有经验的同学望指点一二。

集群外部网络访问流量走向是：Client -> LVS -> nginx-ingress-controller -> Endpoints。

LVS这里我们实现一个简单的Operator去listWatch带有标识的Endpoints变化然后动态CRUD virtual_server，后面nginx-ingress-controller以共享主机网络方式运行，同时这里会添加一个sidecar去做LVS DR模式中real_server在start/stop时做的一些例如assign ip/del ip/route add/route del操作。

**Jenkins Pipeline**

在云平台导入/创建项目，按提示填写表单之后，会在项目下生成Dockerfile/Jenkinsfile，对应的Jenkins pipeline job，以及创建GitLab webhook。

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/1fc2a209dd19ef24e40471a41404c7f0.png)

项目类型当前是手动选择，之后会考虑使用github-linguist/buildpack类似的开源工具来实现autodetect。

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/a904958428aab6f8286614fa0c5d853d.png)

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/aced082605ddb33ea01f4410cf3b8f6f.png)

可以看出来，Git Hook的event是先发到云平台做过滤后再触发Jenkins的pipelinejob。这里主要核心是Jenkinsfile，其中引入share-library，封装了一些基础的groovy方法，import之后可直接使用。

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/88f054a770f8c040487c31edd6717788.png)

缺点：不够云原生，Master/Slave的运行还是依赖于外部的虚拟机实例，使用Jenkins的Kubernetes插件在启动Slave调度Job时耗时太长，封装方法内执行的操作对于使用者不够友好，改造成本较大。目前有在对比GitLab-CI/Drone/tektonci等。

Helm应用管理

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/1708fdcac61cedac5979fc1b01e5ac23.png)

### 

Helm是一个应用包管理工具。没有Helm之前我们是怎么做的？

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/d69dd6abe2d9f24bb32fee501307c64e.png)

通过类似上图这些模板文件，使用SCM管理，云平台会通过hook或定期同步这些文件。每添加一种应用支持，就需要“手写”这些yaml文件，然后经过测试才能“上线”使用。相关Kubernetes对象的逻辑也是使用硬编码。于是我们调研了Helm，如果我们需要支持一个新的中间件应用类型，例如RabbitMQ/MSSQL等，我们可以直接引用官方/社区维护完善的chart即可。

至于我们的服务应用，我们只需要写一个通用的baseChart即可，然后所有的应用都引入这个做为Dependency。然后发现这种做法存在的问题是，如果baseChart更新了，那么每个应用都需要更新生成一个新的chart（如果有需要的话）。于是又抽象出一个应用商店的概念。例如Java应用会使用Spring Boot的chart，然后在这个上面更新一些相关的默认值存在云平台的数据库（存放在ConfigMap中也是一个选项），每次部署的时候只需要将用户指定或者CI参数merge到这个默认值values，最后部署/更新即可。

同时我们在chart中添加了类似JSONschema（其实并不是）这样子的东西来自动生成部署应用的表单。毕竟用户大多数时候是使用云平台的WebUI来管理应用。helm3也会使用JSONschema来做values的校验，同样webUI前端可以通过这个文件来做form-rendering。不同应用暴露在schema文件中的可配置选项是不同的。

部署页面：

![640?wx_fmt=jpeg](https://img-blog.csdnimg.cn/img_convert/db53b2c1dfcdaf80d4ce52ed2c36000c.png)

服务列表（相对比较简陋）：

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/a5df672e8e3bfcb3dfbb88811c07932e.png)

环境复制需求，我们同样通过Helm实现，将例如整个dev分支上的服务复制到staging分支，有状态服务通过Job的形式去将数据导出导入，后面可以集成Velero工具来实现。

使用Helm 2感受到的缺点：整个集群当作一个大的租户，用户权限都由云平台（架构图里边的Almonds应用）来管理的，所以整个集群中只有一个tiller服务端（绑定了cluster-admin角色）来管理所有的release。需要保证releaseName的唯一性，且当release数量增多超过300个左右的时候（当前已部署1700个release，因为服务依赖没有使用helm chart来做，所以导致release超多），每次list操作都会比较耗时，看过tiller源码的同学应该知道，每次list都会在具体driver实现中获取所有的Kubernetes内置对象例如cm/secret，之后再decode所有的release，最后再把结果返回，而通常的情况下我们会使用一些filter，例如通过release的namespace，chartName，name中的subpattern来做过滤，那每次query都要经过这么久的list操作对用户体验是非常不友好的。所以我们catalog又添加了inmemorycache的实现来加速list查询。

***\*有状态应用部署\****

上面说到我们会支持MySQL/Pg/Redis这类有状态应用服务，那么就存在一个问题，数据存储在哪里？这里我们使用了Ceph RBD。因为是内部的测试环境，对读写的性能要求并不会太高，所以我们从开始就确定了使用开源的分布式网络存储。

RBD集群部署一开始是使用官方的ceph-deploy工具，后面由于集群故障（整个Ceph的所有mon节点都完全起不来），切换到了新的使用rook部署的集群，秉着专业的事情让专业的人做，Operator这种模式让管理复杂集群服务工作变得更简单。

说到Operator，例如etcd/ES/Redis这类有状态服务，仅仅使用官方的chart，部署成sts类型应用是远远不够的，于是我们使用awesome-operators里边的部分Operator来简化管理我们的有状态服务。例如创建一个es kibana集群服务（当然首先需要部署Operator）：

```yaml
apiVersion: elasticsearch.k8s.elastic.co/v1alpha1	
kind: Elasticsearch	
metadata:	
  name: quickstart	
spec:	
  http:	
    service:	
      metadata: {}	
      spec: {}	
    tls: {}	
  image: elasticsearch/elasticsearch:7.1.0	
  nodes:	
  - config:	
      node.data: true	
      node.ingest: true	
      node.master: true	
    nodeCount: 3	
  updateStrategy: {}	
  version: 7.1.0	
 ---	
apiVersion: kibana.k8s.elastic.co/v1alpha1	
kind: Kibana	
metadata:	
  name: quickstart	
spec:	
  elasticsearch:	
    auth:	
      secret:	
        key: kibana-user	
        name: quickstart-kibana-user	
    caCertSecret: quickstart-es-ca	
    url: https://quickstart-es.default.svc.cluster.local:9200	
  elasticsearchRef:	
    name: quickstart	
  http:	
    service:	
      metadata: {}	
      spec: {}	
    tls: {}	
  image: kibana/kibana:7.1.0	
  nodeCount: 1	
  version: 7.1.0
```

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/fb70b82cba1a6ca2f3d6ab7024266d7f.png)

**日志收集**

云平台本身提供简单的查看日志的功能。我们发生过一起事件，因查看日志功能导致云平台频繁OOM。CRI或者是kubelet（早期版本）默认没有对容器的日志文件大小做限制，logs接口会将整个容器日志文件读进内存。所以配置集群时建议对容器的日志文件大小做合理的规划限制。

日志收集是使用比较典型的EFK方案，其中F现在是Filebeat。Filebeat以DaemonSet类型应用部署运行在所有节点上，将/var/log目录以hostPath volume形式挂载到Filebeat Pod的文件系统中。

容器日志收集比较麻烦的是多行日志的处理，例如Java的exception，Golang的panic stack，可以使用multiline来处理，一个input里只能定义一个multiline的配置，所有的容器日志都属于同一个input，但是并不是所有的应用都是使用同一个pattern来输出日志的。以及通常情况下我们会使用add_kubernetes_metadata这个processor将关于Pod的元数据也一并放在日志信息中，例如lables中存在app:demo，那么Filebeat发出来的一条日志事件中就会包含...lables: {app: demo}...，此时如果有另外一个Pod包含了app.kubernetes.io:demo这个标签，那么输出的日志事件会是...labels: {app: {kubernetes: {io: demo}}}...，这样子的话，第一个App是string类型，另外一个是map[string]string类型，在索引到ES时就会报401错误，导致日志条目丢失。

解决这个问题，Filebeat的Autodiscover方案是个不错的选择，可以基于hints做Autodiscover，可以给不同的Pod类型添加multiline.*在labels中，Filebeat会自动对Pod的日志输出做处理。同时Kubernetes Provider可以使用labels.dedot/annotations.dedot配置解决上述的app字段类型不同引起的问题。但是，我们在测试过程中发现即使当前最新的版本启用该配置的话也会引起memory leak，报错issue[4]。

多行日志的问题我们更建议在应用层面解决，于是我们又提出要求，对接云平台的应用需要接我们实现的多行日志方案（其实就是封装log4j实现JSON日志输出）。

从Filebeat抓取日志后会输出到例如Kafka的消息队列中，之后再由Logstash indexer来处理并入到ES，最终kibana做用户界面查询展示。

**监控**

监控方案使用了prometheus-operator全家桶。这个推荐直接使用helm chart安装部署。（这里涉及的组件有点多就先略过了……）

可能遇到的问题会是某个Job中target个数是0（通过sd），这里排查需要了解的知识点是ServiceMonitor如何对应到Endpoints，以及如何使用Relabeling。

**其它的一些小功能**

- 在命名空间之上支持环境空间概念，将多个namespace包含在所属的业务团队空间中
- 支持简单的混沌测试功能，即通过开关随机删除应用实例来测试自愈功能以及上下游服务的熔断机制

未来工作

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/1708fdcac61cedac5979fc1b01e5ac23.png)

- 云平台使用RBAC来支持权限控制
- 优化CI/CD流程，引入云原生解决方案
- 线上业务容器化，提升[DevOps](https://so.csdn.net/so/search?q=DevOps&spm=1001.2101.3001.7020)能力（直接关系到所有人的幸福感）
- 引入服务网格，将服务治理能力降到基础设施层面，让开发更专注于业务

相关链接：

1. https://github.com/kubernetes-sigs/kubespray
2. https://github.com/kelseyhightower/kubernetes-the-hard-way
3. https://github.com/projectcalico/calico/issues/2473#issuecomment-510035824
4. https://github.com/elastic/beats/issues/11834

Q&A

![640?wx_fmt=png](https://img-blog.csdnimg.cn/img_convert/1708fdcac61cedac5979fc1b01e5ac23.png)

Q：怎么支持多租户不同流程定制使用及数据隔离需要？

A：这里我理解的是CI流程的定制？当前我们都是按照标准默认的Jenkinsfile/Dockerfile来接入，用户可自定义这两个文件。

Q：某个微服务节点比较，每次升级耗时特别长。有什么好的方式？

A：服务升级主要关系到的是Kubernetes的rollingUpdate策略，升级慢大部分时候其实是启动慢，服务没有很快达到ready状态。这个跟resource的limit以及request也有关系。

Q：目前生产环境Kubernetes是部署在公有云主机，还是物理机器上？有无做个性能测试对比？

A：生产环境我们目前还是小部分试点在IDC机房，之前也有在Azure上部署过AKS集群，AKS的话会有一些网络的问题，例如SVC的模式只能是使用iptables而不能使用ipvs。性能测试对比的话，对比过AKS上的实例跟内部云平台上的实例QPS，大概是1/3这样子。

Q：你们用过Istio吗，对容器性能有影响吗？

A：Istio还在调研阶段，当然测试集群也有部署，对于用户可见的命名空间是disable的。对容器性能，应该说是对服务的性能影响，因为多了几次iptables的转发，开启mixer影响会更大些。性能与服务治理之间会有取舍。

Q：如何通过更改源码的方式来修改kubeadm证书期限问题？

A：1年期的默认值是hardcode到kubeadm的源码中（在k8s.io/kubernetes/cmd/kubeadm/app/util/pkiutil/pki_helpers.go文件中的duration365d变量）的，改这个重新打包kubeadm的binary即可（非常不建议这种操作）。

Q：混沌测试怎么做，有介绍吗？

A：混沌测试借鉴了Chaoskube项目，我记得是，因为我们需要的混沌测试功能相对比较简单。阿里开源的ChaosBlade也非常不错。如果说有使用到Istio的同学试试fault injection。

Q：监控方面有平台化吗，没有的话报警规则增加是谁来做的？

A：现在告警规则还是管理员来处理，其实平台化实现，prometheus-operator中，Prometheus的规则是从CRD即PrometheusRule生成再生成到ConfigMap中，我们只需要实现创建这个PrometheusRule的接口即可（还需要对应到ruleSelector）。

Q：同一个宿主机上多个相同Pod，日志文件怎么收集？

A：Pod是不会有相同的ID的，通过filebeat/fluent-bit这类日志Agent收集都会有内置功能来支持将Pod的metadata信息也包含在每一条日志记录中。

Q：请问从开发到测试到生产的发布用到了哪些工具栈？分别起什么作用？

A：开发其实就只需要提交代码到SCM，之后的工作由云平台来触发，在分享中的CI/CD图里边有画出来。涉及的工具主要还是Jenkins，测试的同学会在Jenkins中做相应的任务。这种做法的缺点上面也有说到“似乎跟云原生背道而驰”。