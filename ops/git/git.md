#### list all notes
To list all the ignored files in tree format in Git, you can use the git ls-files command with the --others and --ignored options. This will show you a list of all the files that are ignored by Git in a tree-like format.

git ls-files --others --ignored --exclude-standard



#### Git init

### …or create a new repository on the command line



```
echo "# nlp-practice" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/<yourname>/<repo>.git
git push -u origin main
```

### …or push an existing repository from the command line



```
git remote add origin https://github.com/<yourname>/<repo>.git
git branch -M main
git push -u origin main
```

### …or import code from another repository

You can initialize this repository with code from a Subversion, Mercurial, or TFS project.





#### Git ssh 无法连通

```
网络连接：确保你的网络连接是稳定的。

端口阻塞：某些网络或ISP可能会阻塞SSH的默认端口（22）。尝试使用443端口连接到GitHub：

ssh -T -p 443 git@ssh.github.com
如果这成功了，你可以考虑永久地更改你的SSH配置以使用443端口。在 ~/.ssh/config 文件中添加以下内容：

Host github.com
Hostname ssh.github.com
Port 443
代理设置：如果你在使用代理，确保你的SSH配置正确地设置了代理。

SSH密钥：确保你的公钥已经添加到GitHub的SSH keys列表中，并且你的私钥存在于你的机器上。

防火墙设置：确保你的防火墙或安全软件没有阻止SSH连接。

DNS问题：尝试使用IP地址代替域名进行连接，以检查是否是DNS问题。但是注意，长期使用IP地址不是一个好办法，因为GitHub的IP地址可能会变化。

ping测试：尝试使用 ping github.com 来检查你的机器是否可以达到GitHub。

网络工具：使用 traceroute github.com 或 mtr github.com 来检查网络路径中可能存在的问题。

GitHub状态：虽然较少见，但有可能GitHub正在遇到问题。

重新启动：有时简单地重新启动你的计算机和路由器可能会解决问题。
```

Git 大文件

~~~
为什么需要 Git LFS
如果你在命令行用 git push > 50MB 的文件，你会收到一个 warning，但是你仍然可以正常 push，但是 > 100MB 的时候就无法 push 了。如果你是在浏览器要上传文件的话，这个限制更为严重，不能超过 25MB，这是 Github 对仓库的限制。Git lfs 就是用于解决这个问题1

什么情况下不需要用 Git LFS
下面几个场景不需要用

文件大小没有超过限制当然就没有必要用了
如果是要分发二进制文件（比如 *.exe）等，此时直接用 Github 提供的 release 功能就好了

Git LFS 原理
使用 Git LFS 之后，在仓库中存储的其实是对大文件的引用，可以理解为指针。而真正的大文件托管在 Git Lfs 的服务器上。Github 给不同用户的提供的存储空间不一样，免费用户和 Pro 用户都是 2 GB，而如果是企业用户则会高点2

引用文件长什么样子
比如官方文档里面提到的例子：

1 version https://git-lfs.github.com/spec/v1
2 oid sha256:4cac19622fc3ada9c0fdeadb33f88f367b541f38b89102a3f1261ac81fd5bcb5
3 size 84977953

#### https://martinlwx.github.io/zh-cn/gitlfs/
debug 方式：python3 -m rknn.bin.visualization

#### 扩容，手动分区

~~~

