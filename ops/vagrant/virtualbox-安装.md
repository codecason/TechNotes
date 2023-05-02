
[win10虚拟机Oracle VM VirtualBox安装和使用教程](https://zhuanlan.zhihu.com/p/111567471)

### Virtualbox 迁移vdi文件（文件移动)

#### 1. vdi文件uuid不同,无法启动

Ref: 
https://stackoverflow.com/questions/44114854/virtualbox-cannot-register-the-hard-disk-already-exists
1.
Select File from Oracle VM VirtualBox Manager  
Virtual Media Manager  
Remove the file (highlighted yellow) from Hard disks tab.  
2.
之后在Settings->Storage修改文件

### 2. 网络配置
```
Host-Only
Internal
Bridged
```

重装Virtualbox

不同网络配置

https://www.cnblogs.com/bakari/p/10592421.html
### 其他

### 3. 

挂载目录  
~~~shell
sudo mount -t vboxsf weixin-ocr-lab ~/Labs/ocr-lab
~~~

weixin-ocr-lab    /home/hugo/Labs/ocr-lab    vboxsf    rw,uid=1000,gid=1000    0    0

### 4.
持久化

#### Reference
