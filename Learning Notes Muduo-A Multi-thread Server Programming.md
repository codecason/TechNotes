## muduo服务器编程

EPOLLOUT事件:
EPOLLOUT事件在连接时建立时首先触发触发一次，表示可写，其他时候的触发条件为：
1.某次write，写满了发送缓冲区，返回错误码为EAGAIN。
2.对端读取了一些数据，又重新可写了，此时会触发EPOLLOUT。
简单地说：EPOLLOUT事件只有socket从unwritable变为writable时，才会触发一次。
对于EPOLLOUT事件，必须要将该文件描述符缓冲区一直写满，让 errno 返回 EAGAIN 为止，或者发送完所有数据为止。
LT与ET事件下的读写
    https://www.cnblogs.com/LloydDracarys/articles/8881491.html

**The following is temp**
#### CH3.
zeromq 跟muduo的吞吐量测试
赖勇浩 以小见大-那些基于Protobuf的五花八门的RPC

#### CH11. 反思C++面向对象与虚函数
问题:
	新库与旧库的二进制不兼容
原因:
	以虚函数作为接口
	(虚函数表+偏移量实现虚函数调用,偏移量由位置隐式确定)

解决方法:
	COM带版本号的虚函数调用和带来的弊端
	1.用路径指定动态库的版本
    2.pimpl方法 方法转发
		增加非虚函数不会影响二进制兼容性(bind by name)

问题2:
    面向对象的测试:Mock类执行测试
	C++11中的bind方法
11.6 iostream
    iostream解决stdio安全问题
	fgets->getline

	浮点数到字符串的高效转换
		复杂而且无进展
		2010年Grisu3算法
11.7
	ADT:值语义
	面向对象:对象语义


#### CH12. C++经验谈
12.6 版本管理
	多行注释用//而不是/* */
12.8 STL:多路归并
	make_heap push_heap pop_heap多路归并
	4G内存,对单个100G文件排序
	a和b文件各100G,有少量重复行,4G内存求重复行

boost::nocopyable是否值得使用的吗?
分布式对象概念已经被淘汰
编译器优化
	侯捷 C++: 池内春秋
内存池分配:
	论文:Memory Allocation:Either Love It or Hate It
	论文:Reconsidering Custom Memory Allocation

