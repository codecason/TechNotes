
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


#### rewrite里的last和break
rewrite可以作为location和server里的参数

#### proxy_pass

~~~conf
location /ops-coffee/ {
    proxy_pass http://192.168.1.4:8181
}

会被替换为: http://192.168.1.4:8181/ops-coffee/

如果proxy_pass http://url后面加了/, 即 proxy_pass http://192.168.1.4:8181/
    则替换方式为完全替换: http://192.168.1.4:8181
    因为如果表示原来的含义(拼接), 那么多了这个/没有意义

~~~

https://www.ucloud.cn/yun/39278.html

#### rewrite

``rewrite regex replacement [flag];``  

location /data/ {
    rewrite ^(/data/.*)/geek/(\w+)\.?.*$ $1/linux/$2.html break;
}


下面是可以用作if判断的全局变量
~~~txt
$args ： #这个变量等于请求行中的参数，同$query_string
$content_length ： 请求头中的Content-length字段。
$content_type ： 请求头中的Content-Type字段。
$document_root ： 当前请求在root指令中指定的值。
$host ： 请求主机头字段，否则为服务器名称。
$http_user_agent ： 客户端agent信息
$http_cookie ： 客户端cookie信息
$limit_rate ： 这个变量可以限制连接速率。
$request_method ： 客户端请求的动作，通常为GET或POST。
$remote_addr ： 客户端的IP地址。
$remote_port ： 客户端的端口。
$remote_user ： 已经经过Auth Basic Module验证的用户名。
$request_filename ： 当前请求的文件路径，由root或alias指令与URI请求生成。
$scheme ： HTTP方法（如http，https）。
$server_protocol ： 请求使用的协议，通常是HTTP/1.0或HTTP/1.1。
$server_addr ： 服务器地址，在完成一次系统调用后可以确定这个值。
$server_name ： 服务器名称。
$server_port ： 请求到达服务器的端口号。
$request_uri ： 包含请求参数的原始URI，不包含主机名，如：”/foo/bar.php?arg=baz”。
$uri ： 不带请求参数的当前URI，$uri不包含主机名，如”/foo/bar.html”。
$document_uri ： 与$uri相同。
例：http://localhost:88/test1/test2/test.php
$host：localhost
$server_port：88
$request_uri：http://localhost:88/test1/test2/test.php
$document_uri：/test1/test2/test.php
$document_root：/var/www/html
$request_filename：/var/www/html/test1/test2/test.php
~~~

#### References
[nginx配置location总结及rewrite规则写法](https://segmentfault.com/a/1190000002797606)
