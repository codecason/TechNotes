# install
## Linux
~~~bash
wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh

bash Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
~~~

[Ref](https://zhuanlan.zhihu.com/p/489499097)

## Windows


# conda install
. ~/miniconda3/etc/profile.d/conda.sh


# 怎么查询conda的路径
conda info --envs

#### 修改conda的文件安装目录
[condarc](https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/use-condarc.html)

~/.condarc

~~~yaml
channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - defaults

pkgs_dirs:
  - D:\ProgramData\.conda\pkgs

envs_dirs:
  - D:\ProgramData\.conda\envs
~~~

- 创建环境

conda create -n myenv python=3.9
conda create -n myenv python=3.9

- 配置环境变量 (否则无法识别cmd)

D:\ProgramData\Miniconda3\condabin

- conda 初始化
conda init powershell  

conda activate myenv  

#### conda install
场景: 已知某个包, 想安装匹配的python环境(低频)
To create an environment with a specific version of a package:

conda create -n myenv scipy=0.15.0

#### channel
安装pytorch之后可能会出现一些BUG,可能要考虑是不是channel的BUG  
channel

Then I found that torchvision should be installed together with pytorch in anaconda.
conda install -c pytorch torchvision

#### 与cmd的适配
由于cmd没有默认的conda activate base, 不像powershell, 所以需要提前activate才能执行命令

一般在bat脚本前加入 call conda activate base即可

