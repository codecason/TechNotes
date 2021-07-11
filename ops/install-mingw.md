#### 目的
在Windows上安装g++,避免每次编译g++都要开虚拟机或visual studio

#### prerequisite
先安装 msys2
wget https://mirrors.tuna.tsinghua.edu.cn/msys2/distrib/x86_64/ 

#### 用msys2安装
pacman -S mingw-w64-x86_64-gcc
pacman -S mingw-w64-x86_64-cmake
pacman -S mingw-w64-x86_64-make
pacman -S mingw-w64-x86_64-pkg-config

#### 用mingw安装应该选择哪些版本

用mingw下载的时候

可选项:
    exception: seh sjlj  
    threads: posix mingw  

#### 或者安装codeblocks
codeblocks IDE 自带 mingw 安装包

#### 
pacman -R mingw-w64-x86_64-gcc && pacman -R mingw-w64-x86_64-cmake && pacman -R mingw-w64-x86_64-make && pacman -R mingw-w64-x86_64-pkg-config
