#### 2024.7.28

1.根据已知包的版本找到对应的合适的python版本；



编译工具链

找库和定位库

确认版本信息

确认编译架构

翻墙

ABI库

系统encoding BUG；

查找无用的include

bazel

软件供应链 -> ERROR: Could not build wheels for opencv-python

In Different Platform

Jinja

Bazel

Incredbuild

包体积裁剪

环境动态库的版本信息收集；

无用依赖清理；

#### 1.重要内容目录

⭐编译；

⭐版本管理；



#### Visual Studio



#### 源代码header的定义

Visual C++ 工具链

~~~
另外， Visual C++提供的工具 dumpbin 可以列示出一个 PE 文件的各种信息，例如，
下面显示了 Windows Server 2003 SP1 系统中的文件 notepad.exe 的头信息：
C:\>dumpbin D:\Win2k3-Exe\notepad.exe /headers
~~~

#### 1.Windows子系统

Microsoft Visual Studio 的链接器（ linker）支持/SUBSYSTEM 命令选项 

##### 1.1 图形驱动

GDI与DirectX的区别；



#### 2. Windows 编译、配置和调试

2.1 搜索路径

2.2 两台机器的调试配置；虚拟机调试配置；

​	多处理器、中断依赖于特定硬件，一般无法直接在**虚拟机内**调试；

调试：符号服务器

#### Linux工具集合

binutils工具集

~~~
addr2line: 指令地址翻译器
ar: 静态库生成器
nm: 符号显示器
objdump: 信息查看器
objcopy: 段剪辑器
ranlib: 库索引生成器
size: 段大小观察器
strings: 字符串窥视器
~~~

#### 混合编程

~~~
~~~

#### 嵌入式

#### 各种概念

##### 隧道

##### 文件系统识别器驱动程序

文件系统过滤管理器 



#### References

Windows内核原理及实现

https://showme.codes/zh-cn/2023-11-20-bazel-king-of-build-tool/

1.时光机备份和恢复

2.ansible playbook

3.zsh工具

4.维护一份自己的开发环境的 dockerfile 。新机器先装个 docker，上去 gist 复制一下 dockerfile，然后 docker build，docker run，vscode attach（本机）

大家在开发环境配置上一般会花多长时间？ https://www.v2ex.com/t/790257

Python 小技巧：如何实现操作系统兼容性打包？ https://cloud.tencent.com/developer/article/1605170