ring buffer的实现:

网卡驱动的NAPI机制

    napi_schedule -> 发出软中断

IO 多路复用  
    每个连接或socket不立刻处理所有的事件, 而是先保存当前的数据  

select 注册的事件只能有1024个
epoll:  
    rbr + 双向链表
    rbr只是用来做增删改的

用户态异步:  
    AIO  
    用户态异步且IO 同步

proactor和reactor  
    是异步的吗?

多线程下的epoll  

    http://175.178.37.162:8888/tree
