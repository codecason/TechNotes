### 鉴权
一般是怎么用userid做鉴权的?

1. 服务端有鉴权网关, 会把user_id加到header里

2. 客户端的SDK自动加入到header里

不会用什么方式?  
在body里加入user_id (因为容易暴露)  

来源: 脉脉

### 传输文件
HTTP/1.0 引入持久连接机制，通过 Connection: keep-alive 这个头部来实现，服务端和客户端都可以使用它告诉对方在发送完数据之后不需要断开 TCP 连接，以备后用。HTTP/1.1 则规定所有连接都必须是持久的，除非显式地在头部加上 Connection: close。[1] 所以实际上，HTTP/1.1 中 Connection 这个头部字段已经没有必要 keep-alive 这个取值了。

1. Transfer-Encoding

在头部加入 ```Transfer-Encoding: chunked``` 之后，就代表这个报文采用了分块编码
分块编码主要应用于如下场景，即要传输大量的数据，但是在请求在没有被处理完之前响应的长度是无法获得的。

Content-Encoding 和 Transfer-Encoding 二者经常会结合来用，其实就是针对进行了内容编码（压缩）的内容再进行传输编码（分块）
[1] [HTTP 协议中的 Transfer-Encoding](https://imququ.com/post/transfer-encoding-header-in-http.html)
