
#### 自动生成nginx配置
[NGINX 配置自动生成](https://www.digitalocean.com/community/tools/nginx?global.app.lang=zhCN)



#### 根据域名自动转发到相应服务器的特定端口

    外网访问内网, 内网有多个不同端口的服务, 要根据路由进行转发, 并且同一端口服务跟机器是1对N的关系, 要有负载均衡

~~~
upstream monitor_server {
  server 192.168.0.131:80;
  server 192.168.0.132:80;
}

server
{
  listen 80;
  server_name nagios.xxx123.tk;
  location / {
    proxy_redirect off;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass http://monitor_server;
  }
  access_log logs/nagios.xxx123.tk_access.log;
}
~~~

#### server_name的作用
nginx配置中没有server_name会怎样？
答：此时Nginx会自动设置成 server_name ""; 它不会匹配任何域名，导致Nginx会优先将HTTP请求交给其它server处理。如果其它server不处理，则还是交给该server处理。

#### nginx 域名冲突

如果有两个server监听的端口和域名都相同, 运行Nginx时就会报错

#### nginx 最全操作
[Nginx 最全操作总结 腾讯技术](https://zhuanlan.zhihu.com/p/384752564)

#### nginx 匹配精确度
~~~
server {
    listen      8082;
    server_name localhost;

    location ^~ /foobar/ {
        echo "WITH: /";
    }

    location ^~ /foobar {
        echo "WITHOUT: /";
    }
}
~~~

在location里, 后缀加了/的是更加精确的匹配, 而 /foobar还会匹配/foobar123, 但是优先级低

#### QA
server_name _; 的作用

如果不用nginx代理额外端口A, 那么可以直接访问A吗?

没有server_name的时候如何使用IP访问网站?  

    listen 80 default;

