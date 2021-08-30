## 2019.
<%
### MySQL 技术内幕: InnoDB存储引擎

1.3.2
    
1.3.3
AdventureWorks
下载示例数据库 dev.mysql.com/doc
https://dev.mysql.com/doc/index-other.html
https://github.com/datacharmer/test_db
%>

#### Mysql的元数据排查
锁与事务
select * from information_schema.INNODB_LOCKS;

select * from information_schema.INNODB_LOCK_WAITS;

select * from information_schema.INNODB_TRX;

[姜承尧MySQL课程](https://kaiwu.lagou.com/course/courseInfo.htm?courseId=869#/detail/pc?id=7317)

#### 复习MySQL (姜承尧课程)

- 01 避免自增类型踩坑

~~~sql
CREATE TABLE `t` (
  `a` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`a`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
~~~

    Big Int类型
    自增类型的回溯问题解决

- 02 字符串类型

    编码
    show collation like 'utf8mb5%';

- 06 表压缩  
    怎么使用COMPRESS功能实现性能提升? (话说压缩了又有啥用?)  
    Transparent Page Compression TPC压缩功能  
        利用文件系统的空洞（Punch Hole）特性进行压缩  
    只有对核心业务表以上的性能分析才有意义  
    非核心业务表可以使用页压缩  

使用 sysbench 工具进行测试观察，启用 TPC 压缩后，ZLIB 和 LZ4 压缩算法的压缩率各是多少？  

- 07 以NoSQL的方式使用MySQL

    X-Protocol

- 08 索引的设计

多版本读, 多版本写


TPC-H 是美国交易处理效能委员会( TPC：Transaction Processing Performance Council ) 组织制定的，用来模拟决策支持类应用的一个测试集的规范定义，其模拟的就是一个类似电商业务，看一下其对核心业务表 rders 的设计：


#### 11. 索引执行

索引的选择是基于开销计算的,MySQL存储引擎会根据其先验知识判断数据查询的开销。在一些情况下,执行器能够分析出较好的结果,但是对于不同的数据分布,尤其是数据倾斜,可能会分析错误。
针对数据倾斜,可以使用直方图(即可选值的记录统计)来提前计算数据的分布,让MySQL有可以分析的正确依据

~~~sql
ANALYZE TABLE orders 
UPDATE HISTOGRAM ON o_orderstatus;  # 或其他字段
~~~

索引计算的过程记录
~~~sql
EXPLAIN FORMAT=json 
SELECT o_custkey,SUM(o_totalprice)   # 或其他的语句
FROM orders GROUP BY o_custkey;
~~~

#### 12. JOIN 查询

nested loop join

    驱动表

hash join算法

回表,二级索引

#### 15. MySQL 复制

~~~
gtid_mode = on
enforce_gtid_consistency = 1
binlog_gtid_simple_recovery = 1
relay_log_recovery = ON
master_info_repository = TABLE 
relay_log_info_repository = TABLE
~~~

``无损半同步复制``: master在收到ack之后才commit, 不会造成中间crash的损失  

``多源同步``: 多主一从

``延迟复制``: 设置延迟同步, 可以恢复一天前的数据

#### 17. 高可用设计
可以通过 MySQL 提供的无损复制技术，来保障“数据一致性”。而“发现主服务器宕机”“处理故障转移逻辑”要由数据库高可用套件完成

#### 18. 金融级高可用架构
同城双活

两城三活

#### 20. InnoDB Cluster

金融行业的高可用解决方案

下一代金融场景的标准数据库高可用解决方案:

MySQL Group Replication (MGR)

#### 21. 数据库备份
除了高可用之外要做到备份架构

mysqldump -A --single-transaction > backup.sql

参数 --single-transaction 是必须加的参数，否则备份文件的内容不一致，这样的备份几乎没有意义。

- mysqldump, mysqlpump
命令 mysqlpump 唯一不同的是它可以设置备份的线程数；但是当备份并发线程数超过 1 时，它不能构建一个一致性的备份

- 物理备份与逻辑备份
    逻辑备份只能按照

对于 MySQL 8.0 之前的版本，可以使用第三方开源工具 Xtrabackup，网址：https://github.com/percona/percona-xtrabackup。

#### 22. 分布式数据库架构
计算层

元数据层

存储层

#### 23. 分布式数据库表结构设计
分片算法  
    根据哈希分片  

根据业务的查询需求, 设计根据某个键作为分片键, 不同的表在根据同一个键进行查询, 避免跨分片

四种分库分表方式:  
    表名库名一样  
    库名不一样, 表名一样  
    表名不一样, 库名一样  
    表名不一样, 库名不一样  

#### 24. 分布式数据库表索引设计
- 辅助索引表二次查询

- 查询键字段中包含分片键


#### 25. 分布式数据库架构选型: 分库分表 or 中间件


#### FAQ
索引:
    Rtree索引  
    B+ Tree  
    哈希索引  

锁:
    什么是next-key locking  
    什么是gap-lock  

高性能:  
    MVCC  

分布式事务:
    2PC  
    XA  2PC是XA的一个具体实现?

集群:
    主从复制崩溃了怎么恢复  

    千万级别的表如何分库分表  
    sharding的程序到底怎么写,是否对业务有侵入  
        没有,但是要注意使用场景; 怎么写一般都是改业务的主键字段  

SQL:
    in和exists  
    子查询是什么?  答: 嵌套的select  
    派生表降低子查询复杂度  
    分区表技术不是用于提升 MySQL 数据库的性能，而是方便数据的管理。  
    分表

分布式带来的问题:
    自增实现  
    索引设计  
    分布式事务  
