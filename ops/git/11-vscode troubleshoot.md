#### vscode-go-auto-format
vscode go插件在保存的时候会自动格式化, 本来不想格式化的也格式化了

修改下插件的lint on save选项

#### centos install python3
~~~shell
# yum install remove python3
yum install -y python3
~~~

#### configure remote ssh
1. ssh-keygen -t rsa -C <email>
2. copy the rsa.pub to server:~/.ssh/rsa.pub
3. add to authorized_keys:
~~~
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
~~~

4. possible problem troubleshoot: sudo tail -f /var/log/secure
try: chmod 600 authorized_keys

