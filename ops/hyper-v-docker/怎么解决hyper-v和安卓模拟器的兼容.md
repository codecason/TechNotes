[[提问] 如何让hyper v与安卓模拟器共存(已解决，解决方案在14L)](https://nga.178.com/read.php?tid=27069263&rand=4)

我自己用WSL-Arch，和Hyper-V最近刚解决这个问题，提供一个可行的方式。
使用微软的Visual Studio 2019附带的Visual Studio Android Devices可以完美解决，且附带GPU加速。

− 设置教程-多图预警 ...
先说一下，即使你不使用Visual Studio，微软也提供了一个独立版本的Android Emulator for Visual Studio
官网: [https://visualstudio.microsoft.com/zh-hans/vs/msft-android-emulator/]


https://nga.178.com/read.php?&tid=27069263&pid=522014504&to=1



#### Q1. 启用hyper-v
dism.exe /Online /Enable-Feature:Microsoft-Hyper-V /All
[enable hyper-v](https://stackoverflow.com/questions/39684974/docker-for-windows-error-hardware-assisted-virtualization-and-data-execution-p)

#### Q2. 怎么配置docker的registry
%programdata%\docker\config\daemon.json
