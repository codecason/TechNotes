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


#### 复习MySQL

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

什么是next-key locking  
sharding的程序到底怎么写,是否对业务有侵入  
主从复制崩溃了怎么回复  
千万级别的表如何分库分表  
MVCC  

多版本读, 多版本写


TPC-H 是美国交易处理效能委员会( TPC：Transaction Processing Performance Council ) 组织制定的，用来模拟决策支持类应用的一个测试集的规范定义，其模拟的就是一个类似电商业务，看一下其对核心业务表 rders 的设计：


[姜承尧MySQL课程](https://kaiwu.lagou.com/course/courseInfo.htm?courseId=869#/detail/pc?id=7317)
