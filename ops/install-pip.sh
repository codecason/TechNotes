apt install python-pip
mkdir -p ~/.pip
echo "[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple/ #这个pypi源自己定义[install]
trusted-host=pypi.tuna.tsinghua.edu.cn  # 这个也是根据pypi源自己定义
" > ~/.pip/pip.conf

# 指定源下载
python3 -m pip install -i https://mirrors.cloud.tencent.com/pypi/simple taichi
