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

- 

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

