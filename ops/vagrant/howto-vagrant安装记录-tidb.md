
## Virtualbox

1. install on guest addition

	**Virtualbox scale up**

	从官网安装VirtualBox; 下载了镜像启动, 可能会不小心进入scale mode, 导致菜单栏不存在; 要么切换回非scale mode, 但同时界面无法放大, 要么在界面中使用Right Ctrl (即Host Key) + Home选择菜单

	**Virtualbox Guest Additions**

	Guest Addtion需要安装在系统内, 这样才有各种增强的功能, 比如剪贴板粘贴, 大小可以随主窗口缩放, 原理是直接在类Linux系统内安装驱动; (为什么VMWare不用而Virtualbox这么麻烦, emmm...)
	因此, 每个系统必须安装而不是全局设定

2. **Host key**  
	是指右键盘的Right Ctrl
	https://www.virtualbox.org/manual/ch04.html#guestadd-intro

## Vagrant

3. **Vagrant源**

 	[Discover Vagrant Boxes](https://app.vagrantup.com/boxes/search)


4. 安装vagrant  
	[本地开发环境搭建利器--vagrant (juejin.cn)](http://mirrors.opencas.cn/ubuntu-vagrant/vagrant/)

5. 手动导入vagrant镜像  
	https://stackoverflow.com/questions/22065698/how-to-add-a-downloaded-box-file-to-vagrant


6. Vagrant入门教程
	https://www.sitepoint.com/getting-started-vagrant-windows/

	Attention:
	You can use VirtualBox to see any VMs you’ve created, but you don’t actually have to open or use VirtualBox at all to use Vagrant. If you make certain changes to the VM from VirtualBox, there’s a chance Vagrant could lose the association to the VM.

7. Vagrant UI工具  
	[Vagrant Manager - Windows](https://www.vagrantmanager.com/windows/)

	windows环境下，我是一直用vmware的，配个nvme的固态硬盘，就是搭各种集群做实验。不用纠结什么，反正就是学习用，要学的是linux而不是vm workstation或者virtual box，生产环境这俩都没用。生产环境直接用kvm还更方便，如果有条件搭个OpenStack，底层其实也是kvm

	至于图形界面有问题什么的，安装open-vm-tools，不要安装vmware提供的。
	要模拟集群，还是vm workstation好用，不会配网络的时候吧，他不用配，会搞网络吧，才懒得搞
	链接：https://www.zhihu.com/question/33701295/answer/311275921

#### 登录SSH/配置密钥
查看配置文件

vagrant && vagrant ssh-config
```
Host default
  HostName 127.0.0.1
  User vagrant
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile D:/my-projects/ubuntu/.vagrant/machines/default/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL
```

open xshell and input the private key  
after login, su root  
vi /etc/ssh/sshd_config and change PermitRootLogin to yes
systemctl restart sshd   -- [2]

8. Vagrant常用命令
~~~shell
vagrant global-status #
vagrant destroy <id> #

vagrant plugin install vagrant-proxyconf

	vagrant box add --name ${name} ./Ubuntu.box  
	vagrant init ${name}
	vagrant up
	vagrant ssh   # 登录镜像, 会发现是vagrant用户
	vagrant suspend + resume # 休眠 + 苏醒
	vagrant ssh-config
	vagrant halt # 关机
	vagrant box add my-box file:///d:/path/to/file.box
	vagrant plugin install vagrant-proxyconf  # 安装代理插件
	vagrant reload # 重启
~~~

## Vagrant TiDB

9. Vagrantfile

**Vagrant网络加速1**

	Vagrant默认使用NAT网络,内部git clone的速度非常慢。

	新增配置项:
~~~
	config.vm.provider "virtualbox" do |vb|
		vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
	end
~~~

[StackOverflow: Vagrant: Slow internet connection in guest](https://serverfault.com/questions/495914/vagrant-slow-internet-connection-in-guest/496612)  
[How to fix extremely slow Virtualbox network download speed?](https://superuser.com/questions/850357/how-to-fix-extremely-slow-virtualbox-network-download-speed)

**Vagrant网络加速2 如何使用宿主机代理**

```shell
# 在 ~/.bash_profile配置
export http_proxy=http://192.168.1.xxx:xxxx
export https_proxy=http://192.168.1.xxx:xxxx  (http://是否要+s根据实际代理软件确定)  
# 同时代理软件需要允许LAN的连接

```

- 9.1 VirtualBox 的典型网络模型  

NAT，Hostonly，Bridge以及Internal。

这些模式的细节我们不再列举。

借用一张表格来归纳：

|| NAT	| Bridged	| Internal	| Hostonly |
| -- | -- | -- | -- | -- |
|vm -> host	| √	| √	| ×	| × |
|host -> vm	| ×	| √	| ×	| × |
|vm -> others hosts	| √	| √	| ×	| × |
|others hosts => vm	| ×	| √	| ×	| × |
|vm <-> vm	| ×	| √	| same subnet	| √ |

- 9.2
	vagrant配置CPU

~~~ruby
	config.vm.provider :virtualbox do |vb|
		vb.cpus = 2
	end
~~~

10. Vagrant TiDB

[TiDB 部署及数据同步](https://dudashuang.com/tidb/)  
tiup playground  
安装yum or 安装docker  

实验结果:  
	To connect TiDB: mysql --host 127.0.0.1 --port 4000 -u root
	To view the dashboard: http://127.0.0.1:2379/dashboard
	To view the Prometheus: http://127.0.0.1:9090
	To view the Grafana: http://127.0.0.1:3000

11. 迁移box

如何迁移已经有的box到另外一个盘(例如默认的C盘已经满了,要移到D盘)?

1. 修改VAGRANT_HOME环境变量,移动.vagrant.d(这个好像没啥用?)  
2. 修改virtualbox的默认路径(这个是为了后续新建的box能在新的路径建立), File->General->Default Machine Folder,
改为 D:\VirtualBox VMs(举例)
3. 参考 [Vagrant盘迁移], 主要是停机、拷贝目录, 修改存量配置的目录, 其中关于.VirtualBox/VirtualBox.xml的修改为关键,将目录改掉就可以了
~~~xml
<MachineRegistry>
 <MachineEntry uuid="{vagrant_vm_uuid}" src="d:\[path]\.VirtualBoxVagrantVMs\[vagrant_vm_name]\[vagrant_vm_name].vbox"/>
<MachineEntry uuid="{vagrant_vm2_uuid}" src="d:\[path]\.VirtualBoxVagrantVMs\[vagrant_vm2_name]\[vagrant_vm2_name].vbox"/>

<MachineEntry uuid="{other_vm_uuid}" src="C:\Users\[username]\.docker\machine\machines\default\default\default.vbox"/>
</MachineRegistry>
~~~

## 一些常用box
vagrant box add ubuntu/trusty64  

## FAQ
If you create a private box, only you (the owner) and collaborators will be able to access it.


#### References

[1][Vagrant (三) - 网络配置](https://www.jianshu.com/p/a1bc23bc7892)  
[2] https://www.programmersought.com/article/25075868899/  
[3] [capistrano - How to find the Vagrant IP? - Stack Overflow](https://stackoverflow.com/questions/14870900/how-to-find-the-vagrant-ip)  
[4][Vagrant盘迁移](https://medium.com/@cedricdue/moving-vagrant-boxes-and-related-virtualbox-vms-to-another-drive-f1d7c50d20bc)  
[5][征服诱人的Vagrant](https://www.huaweicloud.com/articles/0e7b0fe6ca2fc4d60c9fdfaf61e05092.html)  
[6][腾讯云-Vagrant快速入门教程](https://cloud.tencent.com/developer/article/1585736)  
[7][Windows下傻瓜Vagrant+VirtualBox快速创建centos7虚拟机](https://juejin.cn/post/6844903862801809415)  
