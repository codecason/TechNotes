windows里怎么知道端口哪个进程在用


ssh密钥能连通虚拟机, 但是密码连通失败 (卡住了)
    选错认证方式了
    vagrant ssh-config

开VPN连接,后面关掉无法连接baidu.com(其他网站一般没问题);  
    浏览器提示: ERR_CONNECTION_RESET
    解决方式: ctrl + r  
        ipconfig /release  释放当前IP  
        ipconfig /flushdns  
        ipconfig /renew  
    参考:   https://www.zhihu.com/question/21512577

睡眠模式之后重启无法打开网页
    在设备管理器里修改电源管理,禁止允许关闭适配器以节省电源  --没啥用
	https://www.tenforums.com/network-sharing/170800-ethernet-slow-connect-after-sleep-reboot.html  
	https://superuser.com/questions/889297/issues-with-internet-after-sleep-mode  

    看是不是安装sangfor VPN或其他会影响网络的软件了(根据注册表和服务判断)  --有用

Reference
#### 浏览器网页加载不全
![](./img/网络CDN问题.png)
