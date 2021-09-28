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
