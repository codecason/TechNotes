## 2019.
### MySQL 技术内幕: InnoDB存储引擎

1.3.2
    
1.3.3
AdventureWorks
下载示例数据库 dev.mysql.com/doc
https://dev.mysql.com/doc/index-other.html
https://github.com/datacharmer/test_db

#### Mysql的元数据排查
锁与事务
select * from information_schema.INNODB_LOCKS;

select * from information_schema.INNODB_LOCK_WAITS;

select * from information_schema.INNODB_TRX;

#### SQL 常识与术语

1. 事务
1.1 总流程
UPDATE:  
begin->用排他锁锁定该行->记录redo log->记录undo log->修改当前行的值，写事务编号，回滚指针指向undo log中的修改前的行

锁: 是程序开发的概念  

redolog, undolog: 是实现的层面  

MVCC: 目的层面  

1.2 undolog实现原理  
    undolog: 用来回滚操作
    事务版本号: 当前事务的ID  
    最小、最大事务版本号:  用来判断是否应该看到
    当前活跃版本号: 未提交的事务号列表  
    自己事务号:  
    ReadView: MVCC的一种限制, 即当前事务只能看到自己的修改(或发起事务前的改动)的视图  
    保存时比较版本号，如果成功（commit），则覆盖原记录；失败则放弃copy（rollback）  
    每条纪录会有一个trx_id和rollptr,表示操作该记录的事务ID和回滚指针  
    版本链:  从rollptr往前回溯的链  
    一致性非锁定读: 一种机制, 用MVCC 实现  
    一致性锁定读、共享锁

1.3 redolog实现原理  
    有多种数据结构,避免直接拷贝浪费空间,是一种物理日志  
    其实就是WAL技术,提供重写操作,保证事务的持久性  
    redolog保存了对记录的操作,包括undolog
    落盘的时间点:  定时, commit  

两者的关系: 
    在恢复时，对于已经COMMIT的事务使用redo log进行重做，对于没有COMMIT的事务，使用undo log进行回滚

1.4 MVCC的回滚操作  
    乐观锁机制, 在提交的时候会判断数据是否为最新的版本  
    SELECT 的时候会有版本号  

1.5 间隙锁  

1.6 当前读与快照读  
普通读（也称快照读，英文名：Consistent Read），就是单纯的 SELECT 语句，不包括下面这两类语句：
SELECT ... FOR UPDATE
SELECT ... LOCK IN SHARE MODE  

当前读（也称锁定读，Locking Read）。

1. [MVCC概念与基本原理](https://www.jianshu.com/p/73b5546d6b43)
2. [事务还没提交的时候，redolog 能不能被持久化到磁盘呢？ ](https://www.cnblogs.com/cswiki/p/15816371.html)
3. [当前读和快照读的区别](https://www.modb.pro/db/38160)
4. [Innodb引擎 · 基础模块篇(三) · 详解redo log存储结构](https://juejin.cn/post/6895265596985114638)

## 1. 书籍 - 索引设计与优化 

聚簇索引  
    不要望文生义(跟多个字段无关,也跟表存储无关); 所谓聚簇索引是索引保持顺序,而其对应的真实数据也是按该索引的顺序组织的;  
    2. 在Oracle中, 聚簇的含义是多个表的行交错存储（跟上文毫无关联）  

位图索引  
散列表  

- 过滤因子

- 三星评估法

WHERE 相等  

WHERE 范围  

ORDER BY  

⭐ x x
等值索引

x ⭐ x
范围索引

x  x ⭐
其他索引


#### 后记
本书过于枯燥而且不够详细, 所以不再继续看了  
遗留点: 慢查询 性能监控  
