## 2019
#### =============Start Of the Book =========
Nginx 的优势
轻量级：安装文件小，运行时 CPU 内存使用率低；
性能强：支持多核，处理静态文件效率高，内核采用的 poll 模型最大可以支持 50K 并发连接；
支持热部署，同时启动速度快，可以在不间断服务的情况下对软件和配置进行升级；
负载均衡，支持容错和健康检查；
代理功能强大，支持无缓存的反向代理，同时支持 IMAP/POP3/SMTP 的代理。
Nginx 的劣势
相比 Apache 模块要少一些，常用模块都有，支持 LUA 语言扩展功能
对动态请求支持不如 Apache
Windows 版本功能有限，受限于 Windows 的特性，支持最好的还是 Unix/Linux 系统
#### 第一部分 Nginx能帮我们做什么
#### CH1.准备工作
nginx

#### CH3. 如何编写http模块
ngx_chain_t 数据结构
nginx 编译自定义模块

3.6.4 获取HTTP包体
- 异步接收http包体;如果不用处理,要用ngx_http_discard_request_body主动丢弃包体

#### CH4. 配置、error和请求上下文
异步框架下的两种代理请求接口 代理用户请求
    upstream
    subrequest
透传???
反向代理基于upstream功能
- nginx 内存分配对配置项合并的考虑
- http请求上下文 API
	ngx_http_get_module_ctx(r, module)
    ngx_http_set_ctx(r, c, module)

#### CH5. 访问第三方服务
- 1. 全异步模式访问三方服务
- 2. 反向代理的核心,upstream
三大模块包括了filter,handler和upstream,upstream是多机通信的支撑
模块如proxy,fastcgi用到upstream编程结构,
它跟handler模式的不同在于多了一个ngx_http_upstream_create

- 3. subrequest 模块
- 什么叫上游服务器?
被nginx反向代理的服务器集群

#### CH6. 开发一个简单的http过滤模块
过滤模块调用顺序--先进后出

#### CH7. nginx提供的底层数据结构
ngx_queue_t
ngx_array_t
ngx_list_t
ngx_rbtree_t 定时器管理、文件缓存模块
ngx_radix_tree_t 基数树,以int为键
ngx_hash_wildcard_t
ngx_hash_combined_t 支持前后通配符的散列表,其成员为三个不同的散列表


## 第三部分 深入nginx
#### CH8. nginx的基础架构
#### CH9. 事件模块
- 9.3 被动连接 主动连接 连接池
	预分配大小的连接池
- 9.6
struct eventpoll {
    struct rb_root rbr; // root of rbtree
	struct list_head rdllist; // satisfied events
};
EPOLLOUT:连接建立成功的事件
ngx_epoll_module
	ngx_connection_t 重复连接的标志位翻转
- 9.7 红黑树的定时器
	哨兵节点
- 9.8 "惊群"问题的解决
    操作系统层面;应用层层面
    负载均衡:accept_mutex
- 9.9 Linux文件的异步IO
	Linux内核>=2.6.2版本
	Linux只支持异步读,异步写会降低效率
	大部分使用场景下不用文件异步IO
	io_setup
	io_destroy
	io_submit
	io_cancel
	io_getevents

#### CH10. http框架的初始化
[Omiitted]

#### CH11. http框架的执行流程
subrequest:
  用来解决异步流程难以编写复杂模块的限制

#### CH12. upstream机制的设计与实现

#### CH13. 邮件代理模块

#### CH14. 进程间的通信机制
	共享内存
	信号
		注册 sigaction
	信号量
	文件锁fcntl
	互斥锁
#### =============End Of the Book =========
