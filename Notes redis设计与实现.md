## 2019-09
<%
五种数据类型:
    字符串
    哈希表
    列表(List实现)
    集合
    有序集合(由跳表或ziplist实现)
~~~C
typedef struct listNode {
    struct listNode* prev;
    struct listNode* next;
    void* value;
}listNode;

~~~
#### CH3. 链表
慢查询
空间:非连续
顺序:无序

#### CH4. 字典
空间:非连续
顺序:有序
链地址法
htable {
    ht[2];
    ht = {

    }
}
-4.2 渐进式rehash

#### CH5. 跳跃表
空间:非连续
顺序:有序

#### CH6. 整数集合
空间:非连续
顺序:有序
特性:类型上升(升级)

#### CH7. 压缩列表
空间: 连续
存放内容:有序
何为压缩: 对于存放值长度的变量,是可变的,最多每个entry节省4个bytes

#### CH8. 对象
五种对象(数据类型)
- 8.10 空转时长

### 第二部分 数据库相关
#### CH9. 数据库
1. 服务器中的数据库
~~~
GET命令=切换数据库
SETEX命令=设置键+set expire time
~~~
9.6 过期键的删除
AOF、RDB和复制功能

~~~
AOF模式: 持久化
RDB模式: 一种持久化的方式
复制模式:主从
~~~
#### CH10. RDB持久化
- 10.4 分析RDB文件

#### CH11. AOF持久化

#### CH12. 事件
~~~
redis服务器处理的两种事件
文件
时间
~~~
#### CH13. 客户端
~~~
lua伪客户端
AOF伪客户端
~~~
#### CH14. 服务器
启动初始化时候的server.lua

#### CH15. 复制
旧版复制功能:传递全文件
新版复制功能:PSYNC

~~~
~~~
#### CH16. Sentinel
Sentinel 是Raft协议

#### CH17. 集群
复制与故障转移

### 第四部分 发布与订阅
#### CH18. 发布与订阅
频道的订阅与退订
publish 发布
subscribe 订阅

性能、准确度
redis AOF和RDB的对比
性能:AOF < RDB
准确度: AOF > RDB
可用性: AOF > RDB

References:
    C Standard Library
    C++ Standard Library
    The Elements of Programming
    Redis persistence demystified
    Pattern-Oriented Software Architecture:Volume 4: A pattern language for distributed computing


%>