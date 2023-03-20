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
2022.3

错误: ```SSH-RSA key rejected with message "no mutual signature algorithm"```

需要增加如下配置项

	PreferredAuthentications publickey
	HostKeyAlgorithms +ssh-rsa
	PubkeyAcceptedKeyTypes +ssh-rsa


[SSH-RSA key permission deined](https://confluence.atlassian.com/bitbucketserverkb/ssh-rsa-key-rejected-with-message-no-mutual-signature-algorithm-1026057701.html)

