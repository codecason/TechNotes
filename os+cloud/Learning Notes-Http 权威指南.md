### http header 字段
keep alive 选项: 

request header:
	Keep-Alive: 先发送Connection: Keep-Alive然后再执行; 在1.1中已经逐渐被替代

### 经过中间代理通信的http报文变化

#### https的证书问题

#### nginx的设计架构与http的关联

-------- 
### 用户认证+cookie

#### 客户端IP
Client-IP 客户端IP
X-Forwared-For 客户端IP
X-Forwared-For 客户端IP

#### Authorization 首部

 Basic Authorization + Bearer Authorization
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

#### http 1.0


#### http 1.1


#### http 2.0

#### 跨域访问请求


### References
MDN http doc https://developer.mozilla.org/zh-CN/docs/Web/HTTP

