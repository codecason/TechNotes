https://github.com/operator-framework/operator-sdk
Operator的存在意义


## Operators 介绍
将运维知识应用到软件中。

站点可靠性工程师（SRE）是通过编写软件来运行应用程序的人员。他们是工程师，开发人员，知道如何专门为特定的应用领域开发软件。应用程序的操作领域的知识被编程到由此产生的软件中。

我们的团队一直致力于在Kubernetes社区中设计和实现这一概念，以便在Kubernetes之上可靠地创建，配置和管理复杂的应用程序实例。

我们将这类新型软件称为Operators。Operator是一个特定于应用程序的控制器，它扩展了Kubernetes API，代替Kubernetes用户来创建，配置和管理复杂有状态应用程序的实例。它建立在基本的Kubernetes资源和控制器概念的基础上，但包含特定域或者特定于应用程序的知识来自动执行常见任务。

#### 无状态容易，有状态难
使用Kubernetes来管理和扩展Web应用程序，移动后端和API服务是相对容易的，开箱即用。为什么？是因为这些应用程序通常都是无状态的，因此，基本的Kubernetes APIs，像Deployments，可以扩展和从故障中恢复，无需其它额外的知识。

最大的挑战是管理有状态的应用程序，如数据库，缓存和监视系统。这些系统需要特定应用领域的知识才能正确扩展，升级和重新配置，同时防止数据丢失或不可用。我们希望将这种特定于应用程序的操作知识编码到软件中，利用功能强大的Kubernetes抽象来正确地运行和管理应用程序。

Operator 是对该领域知识进行编码并通过第三方资源机制扩展Kubernetes API的软件，使用户能够创建，配置和管理应用程序。与Kubernetes的内置资源一样，Operator 不是管理应用程序的单个实例，而是管理在集群中的多个实例。

为了演示运行代码中的Operator概念，我们今天有两个具体的例子要宣布为开源项目：

​Etcd Operator 创建，配置和管理etcd集群。etcd是由CoreOS引入的可靠的分布式键值存储，用于维护分布式系统中最关键的数据，是Kubernetes本身的主要配置数据存储。

​Prometheus Operator 创建，配置和管理Prometheus监控实例。Prometheus是一个功能强大的监控，指标和警报工具，也是一个由CoreOS团队维护的云原生计算基金会（CNCF）的项目。

#### Operator 是如何构建的？
Operator 基于Kubernetes的两个核心概念：资源和控制器。例如，内建ReplicaSet 资源允许用户设置渴望运行的Pod数量，Kubernetes中的控制器通过创建或者删除运行中的Pod来确保其实际状态与在ReplicaSet 资源中设定的状态一致。在Kubernetes中有许多基本的控制器和资源是以这种方式工作的，包括 Services, Deployments, and Daemon Sets.

Operator 构建于基本的Kubernetes资源和控制器概念之上，并添加一些知识或配置，允许Operator执行常见的应用程序任务。例如，手动扩展etcd集群时，用户不得不执行一些步骤：为新的etcd成员创建DNS名称，启动新的etcd实例，然后使用etcd管理工具（etcdctl member add）告诉现有集群有关此新成员的信息。而使用etcd Operator，用户只需简单地将etcd size的值增加1。


来源: https://www.operator.org.cn/mongodb-operator

### OAM跟Operator的关系

### KubeVela 跟OAM的关系
在OAM的基础上,规范的一个定义

