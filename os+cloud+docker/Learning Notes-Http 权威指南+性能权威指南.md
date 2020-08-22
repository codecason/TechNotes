### http header 字段
keep alive 选项: 

request header:
	Keep-Alive: 先发送Connection: Keep-Alive然后再执行; 在1.1中已经逐渐被替代

    Host: 客户端想要与哪个服务器连接(同个IP不同服务器)

#### 客户端IP
Client-IP 客户端IP
X-Forwared-For 客户端IP
X-Forwared-For 客户端IP

#### Authorization 首部

 Basic Authorization + Bearer Authorization
### 经过中间代理通信的http报文变化


### 安全

#### 证书问题
    1. 信任链
    2. CRL 证书撤销名单(Certificate Revocation List)
    3. SSL 2.0 会话标识符机制优化性能 (Session Ticket)

#### https
    Strict-Transport-Security
    追加HTTP严格传输安全首部


~~~
批注:  任意浏览器可以手动导入受信证书
~~~

#### nginx的设计架构与http的关联

-------- 
### 用户认证+cookie

#### cookie域属性
	secure 属性
	httpOnly 属性
	Set-Cookie response
	RFC 2965

Basic realm="finance coorporation"
指定应该进行的认证,给客户端提示

重放攻击 + 中间人攻击

证书格式
	X509.v3格式

opensssl

代理如何发送加密请求
	HTTP CONNECT扩展方法(?),可以明文告知,建立连接以后才进行修改


### 性能

#### 会话缓存
- 会话缓存的良性循环
- 共享TLS会话缓存
- 无状态的恢复(消除服务器保存缓存的压力)

#### TLS
- 增大TCP的初始拥塞窗口也许可以减少一次连接数

#### 无线网络性能

### Web性能要点
### 第10章
#### 降低延迟的重要性
    降低延迟比提高带宽有用

### 第11章

http管道,仅在客户端和服务端都在自己控制的情况下推荐使用,如itunes

挂起XHR,Server Sent Event和Websocket会造成占用一个TCP流

#### http 1.0


#### http 1.x
不支持多路复用

### 第12章 http 2.0
- 类似IO复用的http首部的二进制定义,拆帧和合并帧
- 多个http请求的并行处理

###　第13章 优化应用交付

- 压缩数据
    - 怎么压缩? 有什么优化方向?

- 客户端缓存
    - 什么可以缓存? 什么可以删掉? 有多大的提升? 有哪些具体案例?

- http 1.1和http 2.0的优化策略的变化?
    - http2不要再打包资源;不要多个连接

- http 2.0在全面部署前也必须依赖https

#### http 3.0
2020.8
### 第14章 浏览器API
xml和XORD(跨域请求访问)
#### 跨域访问请求
- Client
    - Origin域名
- Server
    - Allow 域名

#### 流式数据传输选择什么好?
- XHR: 有时候只支持文本,而且性能差(2014年)
- Server Sent Event: 支持下载文本和二进制,API规范

### 第17章 Websocket
- sockjs
- Socket.IO

### 第18章 WebRTC
srtp
rtcp (UNP里有)

### Q & A
- 物联网之间需要TLS吗？
- XHR现在支持Stream API吗?为什么要?

### References
MDN http doc https://developer.mozilla.org/zh-CN/docs/Web/HTTP

- 其他参考书   http权威指南 + 高性能网站建设指南
浏览器安全:  The Tangled Web: A Guide to Securing Modern Web Applications
