## Linux install
~~~bash
#!/bin/bash

# Download the Miniconda installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh

# Verify the integrity of the downloaded installer
sha256sum miniconda.sh

# Compare the output with the SHA256 hash on the Miniconda website to ensure integrity

# Run the Miniconda installer
bash miniconda.sh -b -p $HOME/miniconda

# Add Miniconda to the PATH
echo 'export PATH="$HOME/miniconda/bin:$PATH"' >> $HOME/.bashrc

# Refresh the current shell session
source $HOME/.bashrc

# Test the installation by printing the Conda version
conda --version
~~~

[Ref](https://zhuanlan.zhihu.com/p/489499097)

## Windows install

### conda 初始化

~~~
. ~/miniconda3/etc/profile.d/conda.sh
~~~

## 查询已安装的环境
~~~
conda info --envs
~~~

### 创建环境

~~~
conda create -n myenv python=3.9
~~~

~~~
# 拷贝已经存在的环境
# 场景：例如在一个实验的四个项目中，可能下载差不多的包，但是不想影响原环境
conda create --name myenv_clone --clone myenv
~~~



### 删除环境

~~~
conda remove --name <env_name> --all
~~~

### 节省C盘空间
修改conda的文件安装目录

[condarc](https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/use-condarc.html)

~/.condarc：

~~~yaml
channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - defaults

pkgs_dirs:
  - D:\ProgramData\.conda\pkgs

envs_dirs:
  - D:\ProgramData\.conda\envs
~~~

- 配置环境变量 (否则无法识别cmd)

D:\ProgramData\Miniconda3\condabin

- conda 初始化
conda init powershell

~~~shell
# 进入环境
conda activate myenv
~~~

- git bash 识别conda 命令：

~~~
. /c/Anaconda3/etc/profile.d/conda.sh （换成自己的profile.d所在,在powershell识别）
~~~

### 创建指定环境
场景: 已知某个包的版本, 想安装匹配的python环境(低频)
To create an environment with a specific version of a package:

conda create -n myenv scipy=0.15.0



### 与cmd的适配
由于cmd没有默认的conda activate base, 不像powershell, 所以需要提前activate才能执行命令

一般在bat脚本前加入 call conda activate base



### 命令执行debug
如果solving problem很慢，用--debug查看日志即可

如 conda install -c <your_channel>

### channel

安装pytorch之后可能会出现一些BUG,可能要考虑是不是channel的BUG  

torchvision should be installed together with pytorch in anaconda.
conda install -c pytorch torchvision


### [Python] 安装当前目录
pip install -e .

Is used to install a Python package locally in "editable" mode.

**虚拟机配置http_proxy**

~~~
export http_proxy=1.1.1.1:1234
export https_proxy=1.1.1.1:1234
~~~

**python install的区别**

```
pip install --upgrade pip # for PEP 517

python3 setup.py install 
```

jupyter

~~~
subprocess.run的内容是?
python os.system执行的时候，python如何解释它的包导入机制?为什么会出现no module named

hp, ht, pid, tid = _winapi.CreateProcess(executable, args,
FileNotFoundError: [WinError 2] 系统找不到指定的文件。
~~~

### conda 创建环境
conda env create -f env.yaml

## [Python] 查找路径

python -m site可以看到

~~~
 sys.path = [
	...
]
USER_BASE: ...
USER_SITE: ...
ENABLE_USER_SITE: True
~~~



## [包管理]Pip 版本冲突案例

~~~
如何解决包的版本问题？
场景：

在写kaggle的时候，发现用到了keras_nlp的包；同时它依赖于keras, tensorflow；
于是随便用本地的环境安装了keras，tensorflow，keras_nlp
结果import keras_nlp的时候直接出现问题，这三者同时安装无法兼容；

于是知道了keras 2,3的版本迁移，因此安装新项目的时候，keras版本一般要在3以上；
由于安装tensorflow会卸载已有的keras版本，因此要先装tensorflow再装keras；
而keras的api还在持续的变化，例如from keras import tree，所以要找到对应的keras版本；

我是怎么找到对应的keras版本的?
二分法（在[A,B]之间找到对应的可用版本），并且一般是cannot import是因为版本不够新（除非是tensorflow这样的乱删旧API），用此思路找到一个最新的版本；

即使这样，keras_nlp -> keras -> tensorflow的依赖，还未知tensorflow的版本；
看keras_nlp的文档推荐，tensorflow >= 版本A；因此按照 pip install tensorflow -> keras（为什么？因为tensorflow会删版本）的顺序试验tensorflow的版本；之后重新安装keras_nlp，就完成了；

总结：
conda 可能会没有收录一些pip的库，例如keras_nlp;
1.希望pip有这样一种版本选项，pip check <已知包==已知版本> <other包1> <other包2>
	给出对应的兼容性版本；
2.或者给定三个包，能够直接给出范围内的兼容性列表；

另外有已知的pip freeze | findstr 

另外，有其他的包版本管理的工具，太多了，不一一列举

~~~



pip的其他选项

~~~
[no-deps]:
pip install --no-deps tensorflow 可以不删除keras

~~~

查询可用的版本

~~~
# 一个小trick
pip install tensorflow==
会报错给出可用的版本

~~~

#### pip conflict查看

~~~
pip install pipdeptree
pipdeptree

~~~

### [Advanced ] PEP Standard

