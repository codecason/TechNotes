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



#### http 1.0


#### http 1.1


#### http 2.0

#### 跨域访问请求

### Q & A
物联网之间需要TLS吗？


### References
MDN http doc https://developer.mozilla.org/zh-CN/docs/Web/HTTP

