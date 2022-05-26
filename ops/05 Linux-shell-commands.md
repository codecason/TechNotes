
~~~bash
useradd,groupadd
usermod,groupmod

add a group  
    groupadd -g <gid> groupname  
delete a group  
    groupdel groupname  

# list all groups for current user
    groups  
    output: root
# list all groups with id
    getent group
    output: ...
# list all users  
    cut -d: -f1 /etc/passwd
    -d: : delimiter
    --fields : LIST

# add a user  
    useradd david -u 544
    useradd <username> -u <userid>
# list members of a group  
    lid groupname
# user -> groups: list groups for a user  
    groups username

# change a user from a group to another  
    -g primary group  
    -G group

    usermod -g maingroup username
    usermod -G groupname username  

# add an existing user to group:
    usermod -aG groupname username

# 2. 怎么添加用户
# add password for a user:
    useradd -aG <group> <username>
    passwd root
    > id root
    output: uid=0(root) gid=0(root) groups=0(root)
# delete a user
    userdel -u <username>
~~~

#### 测试io
dd if=/dev/zero of=/dev/shm/test bs=1M count=100  
bs: block size  
count: 次数  
写入 1M * 200 = 200 M  

[https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/](https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/)
