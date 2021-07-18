apt install python-pip
mkdir -p ~/.pip
echo "[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple/ #这个pypi源自己定义[install]
trusted-host=pypi.tuna.tsinghua.edu.cn  # 这个也是根据pypi源自己定义
" > ~/.pip/pip.conf

# 指定源下载
python3 -m pip install -i https://mirrors.cloud.tencent.com/pypi/simple taichi
pip install -i https://mirrors.cloud.tencent.com/pypi/simple taichi

阿里镜像源
https://developer.aliyun.com/article/29941
https://account.aliyun.com/login/login.htm?spm=5176.21213303.J_8058803260.35.56df3edasFI6LQ&oauth_callback=https%3A%2F%2Fwww.aliyun.com%2Fsearch%3Fspm%3D5176.10695662.0.0.353e5bb40Ic6hK%26k%3D%25E9%2595%259C%25E5%2583%258F%25E6%25BA%2590%26page%3D1%26scene%3Dproduct

https://promotion.aliyun.com/ntms/act/kubernetes.html
maven 源
https://cr.console.aliyun.com/cn-shanghai/instances/mirrors
http://dblab.xmu.edu.cn/blog/1709-2/

https://juejin.cn/post/6844904184752373768

