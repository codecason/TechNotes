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


References:
    C Standard Library
    C++ Standard Library
    The Elements of Programming
%>