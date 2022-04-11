#### 配置文件
~/.condarc  


修改channels:  
envs  
pkgs  
channel  

envs_dirs

[condarc](https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/use-condarc.html)


#### 修改文件目录
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

conda 创建环境

conda create -n

- 配置环境变量 (否则无法识别cmd)

D:\ProgramData\Miniconda3\condabin

conda create -n myenv python=3.9

- conda 初始化
conda init powershell  

conda activate myenv  

#### conda install
To create an environment with a specific version of a package:

conda create -n myenv scipy=0.15.0

#### channel

channel

Then I found that torchvision should be installed together with pytorch in anaconda.
conda install -c pytorch torchvision
