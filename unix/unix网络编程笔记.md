
初始是一个套接字监听端口，后面所有的事情都要从这里发生，用bind, listen等进行监听，最后close
一个epoll(端口)里很多个描述符，一个描述符对应一个事件
每次调用epoll_wait返回事件events, 每个event可以包含文件描述符和要处理的事件类型，恰好知道套接字的端口就可以处理socket的套接字了

epoll_create 文件描述符
epoll_ctl 调用单个端口
epoll_wait

Unix 网络编程UDP.h环境配置




>> DHCP
DHCP如何实现分配ip的
发现阶段（DHCP客户端在网络中广播发送DHCP DISCOVER请求报文，发现DHCP服务器，请求IP地址租约）、提供阶段（DHCP服务器通过DHCP OFFER报文向DHCP客户端提供IP地址预分配）、选择阶段（DHCP客户端通过DHCP REQUEST报文确认选择第一个DHCP服务器为它提供IP地址自动分配服务）和确认阶段（被选择的DHCP服务器通过DHCP ACK报文把在DHCP OFFER报文中准备的IP地址租约给对应DHCP客户端）。

>> NIO 和BIO, AIO 非阻塞IO, 阻塞IO, 

作者：俊雪恋
>>

#### CH5
TCP Client/Server
5.9 回收zombie进程
	zombie process + signal + wait
5.10 wait and waitpid
	都用于回收子进程
	waitpid可以指定pid和block与否
FD_ISSET

#### CH7
7.2 getsockopt and setsockopt
IPPROTO_SCTP
IPV6
什么情况下用到socket选项:
	SO_BROADCAST
	SO_DEBUG
	SO_DONTROUTE
IP选项:
	IP_TOS
SCTP选项:
	SCTP_ADAPTION_LAYER

7.11
fcntl函数

#### CH8 UDP套接字
传输层协议
recvfrom and sendto
需要解决的问题:
	
	无流量控制
SCTP 套接字

Tip:
	应用: 4G LTE网络中; 除此之外没有大量应用
