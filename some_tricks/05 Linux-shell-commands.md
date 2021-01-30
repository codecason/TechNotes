
useradd,groupadd
usermod,groupmod
    add a group
        groupadd -g gid groupname
    delete a group
        groupdel groupname

    add a user  
        useradd david -u 544
    list members of a group  
        lid groupname
    list groups for a user  
        groups username
    change a user from a group to another  
        -g primary group  
        -G group

        usermod -g maingroup username
        usermod -G groupname username  
        add an existing user to group:
        usermod -aG groupname username

#### 测试io
dd if=/dev/zero of=/dev/shm/test bs=1M count=100
bs: block size
count: 次数
写入 1M * 200 = 200 M
