

- 1. install on guest addition
	Virtualbox scale up
		从官网安装VirtualBox; 下载了镜像启动, 可能会不小心进入scale mode, 导致菜单栏不存在; 要么切换回非scale mode, 导致界面无法放大, 要么从

	Virtualbox Guest Additions

	Guest Addtion需要安装在系统内, 这样才有各种增强的功能, 比如剪贴板粘贴, 大小可以随主窗口缩放, 原理是直接在类Linux系统内安装驱动; (为什么VMWare不用而Virtualbox这么麻烦, emmm...)
	因此, 每个系统必须安装而不是全局设定

- 2. host key 是指右键盘的Right Ctrl
	https://www.virtualbox.org/manual/ch04.html#guestadd-intro


3. vagrant源  
 	[Discover Vagrant Boxes](https://app.vagrantup.com/boxes/search)


4. 安装vagrant
	[本地开发环境搭建利器--vagrant (juejin.cn)](http://mirrors.opencas.cn/ubuntu-vagrant/vagrant/)

5. 手动导入vagrant镜像  
https://stackoverflow.com/questions/22065698/how-to-add-a-downloaded-box-file-to-vagrant

~~~shell
	vagrant box add --name ${name} ./Ubuntu.box  
	vagrand init ${name}
	vagrand up
	vagrant ssh   # 登录镜像, 会发现是
	vagrant ssh-config
~~~

vagrant box add my-box file:///d:/path/to/file.box

6. Vagrant入门教程
	https://www.sitepoint.com/getting-started-vagrant-windows/

attention:
	You can use VirtualBox to see any VMs you’ve created, but you don’t actually have to open or use VirtualBox at all to use Vagrant. If you make certain changes to the VM from VirtualBox, there’s a chance Vagrant could lose the association to the VM.

7. Vagrant UI工具  
	[Vagrant Manager - Windows](https://www.vagrantmanager.com/windows/)

~~~shell
	windows环境下，我是一直用vmware的，配个nvme的固态硬盘，就是搭各种集群做实验。不用纠结什么，反正就是学习用，要学的是linux而不是vm workstation或者virtual box，生产环境这俩都没用。生产环境直接用kvm还更方便，如果有条件搭个OpenStack，底层其实也是kvm

	至于图形界面有问题什么的，安装open-vm-tools，不要安装vmware提供的。
	要模拟集群，还是vm workstation好用，不会配网络的时候吧，他不用配，会搞网络吧，才懒得搞
	链接：https://www.zhihu.com/question/33701295/answer/311275921
~~~

Lubuntu是Ubuntu Linux桌面系统计划的一个分支，自从18.10版其默认桌面环境为LXQt，特别适用于配备老旧的电脑。和Xubuntu、Ubuntu Lite一样，都是属于追求轻巧的Ubuntu分支。其特色除了轻巧快速外，并提供极低的包相依性，将因为包相依造成的操作问题减到最低。
