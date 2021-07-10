#### 并发 on Go

    sync.Once

#### 
竞态条件

互斥 + 临界区

管道: 多路复用的命名管道

标准信号与实时信号

#### 多线程 3.1

pthread_attach 连接线程

pthread_detach 分离线程

pthread_cancel 取消线程

    线程调度

    调度器预测

    动态优先级
    静态优先级

    线程分类  
        用户级线程  
        内核级线程  Linux的默认实现  
        两级线程模型  

#### 多线程同步 3.2
互斥量:
    避免竞争

    临界区:
        合理范围内尽量大  
        合理切分避免大锁耗费时间  
        避免保护的临界区重叠造成死锁

    锁定-回退
        tryLock - goBack解决死锁
        可能造成程序复杂性增高

    固定顺序解锁方法
        防止死锁

    保持共享数据的独立性是预防因为使用互斥量而导致死锁的最佳方式

信号量:

条件变量:
    生产者, 消费者问题

~~~Go常见问题
WaitGroup
    wg := sync.WaitGroup()

goroutine 和 channel 的关系

waitgroup和mutex

sync.Done()

mutex

~~~
