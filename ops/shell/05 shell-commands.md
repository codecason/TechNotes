
~~~bash

## 增删组
add a group  
    groupadd -g <gid> groupname  
delete a group  
    groupdel groupname  

## 查询用户, 组

# list all groups for current user
    groups <username> 

# list all groups with id
    getent group

# list all users  
    cut -d: -f1 /etc/passwd
    -d: : delimiter
    --fields : LIST

## 2. 增加用户
# add a user  
    useradd david -u 544
    useradd <username> -u <userid>
# list members of a group  
    lid <groupname>
# user -> groups: list groups for a user  
    groups <username>

## 3. 修改用户
# change a user from a group to another  
    usermod -g maingroup username
    usermod -G groupname username 

注: -g primary group  
    -G group  
# add an existing user to group:
    usermod -aG groupname username
    e.g. sudo usermod -aG sudo foo   #将用户foo添加到sudo组中，以获取root权限

## 4. 怎么添加用户到组
# add password for a user:
    useradd -aG <group> <username>
    passwd root
    > id root
    output: uid=0(root) gid=0(root) groups=0(root)

## 5. 删除
# delete a user
    userdel -u <username>


~~~

#### 测试io
dd if=/dev/zero of=/dev/shm/test bs=1M count=100  
bs: block size  
count: 次数  
写入 1M * 200 = 200 M  

[https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/](https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/)
