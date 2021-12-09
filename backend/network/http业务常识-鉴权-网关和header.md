#### 鉴权
一般是怎么用userid做鉴权的?

1. 服务端有鉴权网关, 会把user_id加到header里

2. 客户端的SDK自动加入到header里

不会用什么方式?
1. 在body里加入user_id

来源: 脉脉
