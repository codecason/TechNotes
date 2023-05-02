
~~~bash

## 增删组
- add a group  
    groupadd -g <gid> groupname  

- delete a group  
    groupdel groupname  

-  delete a user
    userdel -u <username>

## 查询用户, 组

# show all users and groups
    cat /etc/passwd
    getent group

# list members of a group  
    lid <groupname>

## 2. 增加用户
# add a user  
    useradd <username> -u <userid>
    e.g. useradd david -u 544

## 3. 修改用户
# change a user from a group to another  
    usermod -g maingroup username
    usermod -G groupname username 

    -g primary group  
    -G group  


## 4. 添加用户到组

# add an existing user to group:
    usermod -aG groupname username
    e.g. sudo usermod -aG sudo foo   #将用户foo添加到sudo组中，以获取root权限

# add for a new user:
    useradd -aG <group> <username>

# change password
    passwd root

~~~

# list all users  
    cut -d: -f1 /etc/passwd
    -d: : delimiter
    --fields : LIST

# list all groups for a user
    groups <username> 

#### 测试io
dd if=/dev/zero of=/dev/shm/test bs=1M count=100  
bs: block size  
count: 次数  
写入 1M * 200 = 200 M  

[https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/](https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/)
