1. 如何保证消息处理的顺序?
有消息M1, M2, M3...

收到的是M1, M3...  --消息丢失
没有返回            -- 返回超时 ->
        分布式系统本身不保证在不返回结果时的任何语义,只保证返回错误的时候是错误,及返回正确的时候是正确提交

Kafka不能处理这种需求, 尽管topic内单partition可以解决, 但是性能会下降,而且不符合它的高性能设计目的

2. 多客户端写同一数据的并发

事务

3. 两个异构系统跟同一个数据关联的一致性  
例如, 对系统内某个数据更新了实际的内容, 在另一个系统内需要同时更新数据;
又如客户端A依赖两个DB, 根据DB1的数据更新DB2; 如果再次期间DB2更新了, 可能不是期望的结果(两个DB的共同锁怎么设定?)

4. 异步任务线程在处理高并发异步任务,如果停等数目不够用了怎么办?

    一个异步任务的返回结果如何使用?  

    答: 使用全异步框架; 如果停等是使用定时的,则利用ID绑定任务映射关系,加入一个定时器的异步任务,定时处理某个任务的结束;

5. 如何解决持久化文件数据在单机存储的单点问题?

6. CAP理论

分区容忍性

7. BASE理论


BigTable的实现: HBase

Spanner的实现: TiDB

BASE理论:
Basically Available  

Soft State  

Eventually Consistency  

AP: dynamo, Cassandra

CP: etcd、HBase、redis

CA: SQL Server, MariaDB

8. DHT、一致性哈希、memached、负载均衡


#### References

[系统面试题精选](https://soulmachine.gitbooks.io/system-design/content/cn/)
