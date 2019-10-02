1.
If you are using git clone for ssh or git push origin and failed:
Create SSH
ssh-keygen -t rsa -C "youremail@example.com"

echo '
Host github.com
User git
Hostname ssh.github.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa
Port 443 ' > ~/.ssh/config

2.
ssh -T git@github.com

若上述操作成功，则用HTTPS协议代替SSH，需要将配置文件中的URL改为HTTPS
git config --local -e
Change url from git@ to:
url = https://github.com/username/repo.git

3.
