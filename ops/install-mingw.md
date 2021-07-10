#### prerequisite
先安装 msys2
wget https://mirrors.tuna.tsinghua.edu.cn/msys2/distrib/x86_64/ 

####
pacman -S mingw-w64-x86_64-gcc
pacman -S mingw-w64-x86_64-cmake
pacman -S mingw-w64-x86_64-make
pacman -S mingw-w64-x86_64-pkg-config

#### 应该选择哪些版本

用mingw下载的时候

可选项:
    exception: seh sjlj  
    threads: posix mingw  
