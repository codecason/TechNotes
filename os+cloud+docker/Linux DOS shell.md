## Chapter 1 print
#### echo
    echo -n #不加换行
    echo -e "\e[1;31m This"
    \e[1;31m 从这里开始为红色
    \e[0m 红色终止

### >> stdout,stdin和pipe的关系
    pipe: cmd1 | cmd2 => means that pipe connects stdout of cmd1 to stdin of cmd2.
    another problem:some commands don't have stdin as their input, like kill.

### printf
    printf "%-5s %-5s" No No2

### export
    export PATH
    echo $SHELL 查看版本

#### 检查root
    if [ $UID -ne 0 ]; then ; fi
    $UID: id
    []: 表达式
    -ne: not equal

### 1.4.2 数学运算
    let x=5 #cannot add spaces around =

#### bc
    echo "str" | bc
        str为bc专用的格式化字符串:
            result=`echo "$no * 1.5" | bc`
            result=`"echo sqrt(10)" | bc`
    (( ))
    $((t)): 取值
    $t

### 1.5 文件描述符与重定向
    cat 
    echo
    echo 'Text' | cat - file # - represents stdin
    >
    >>
    0,1,2
    cmd 2> xx.txt
    e.g. ls + 2>stderr.txt 1>stdout.txt
        执行顺序ls +, 2>stderr.txt, 1>stdout.txt
        2> /dev/null 用来吸收所有输出
    tee FILE1 用来读取同时输出stdin(没有stderr)到FILE1, 而-a可以改变为追加
    e.g. 只列出目录: ls -d */

## 1.5.2
    自定义文件描述符 (>=3)
        exec 3<input.txt
        cat <&3
    e.g.
        exec 4>out.txt
        echo newline >&4
        cat out.txt
    e.g ping 1.1.1.1 &> /dev/null #重定向stderr, stdout

## 1.6
## 1.6.1 数组
    ar=(1 2 3)
    echo ${ar[0]} 而不是$ar[0]
    打印数组 echo ${ar[*]}
    打印数组长度 echo ${#ar[*]}
## 1.6.2 关联数组
    declare -A arr
        arr=([1x]=1 [2x]=2)
        arr[3x]=3
    查看值
    echo ${arr[3x]}
    key:
    echo ${!arr[*]}
    value:
    echo ${arr[*]}

## 1.7 别名
#### alias
    alias install='sudo apt-get install'
    是暂时的
    永久性alias->echo "alias cmd="command seq"' >> ~/.bashrc
    !别名可能带来安全问题,有时候要注意用\command使用原始的命令

## 1.8 获取终端信息

## 1.9 日期
#### date
    date +%s
    测试时间
    start=$(date +%s)
    ...
    end=$(date +%s)
    difference=$(( end - start ))

    E.G. 计时器, tput sc: save cursor; tput rc: restore cursor; tput: ed: clear output to end
    echo -n Count:
    tput sc;
    count=0;
    while true;
    do
    if [ $count -lt 40 ];
    then let count++;
    sleep 1;
    tput rc
    tput ed
    echo -n $count;
    else exit 0;
    fi
    done

## 1.10 调试
#### bash
    bash -x script.sh
        set -x 开启调试 
        set +x 禁止调试
        e.g.
        for i in {1..6}
        do
        set -x
        echo $i
        set +x
        done
        echo "Script done"

#### DEBUG 保留字
    可以打开debug _DEBUG=on ./script.sh,打印script.sh中带_DEBUG的语句

#### bash shell 函数
    function fname() {
        statements;
    }

    导出shell函数到子进程
    export -f fname

#### 管道
    ls | cat -n > out.txt

#### 子进程
    (cmd) 只在括号内运行
    pwd
    ()

#### read
    read -n
    read -s
    read -p
    IFS保留字

#### 循环:
    while; do; done;
    for (( )); actions; done
    until [ ]; do; done

#### []:
    布尔测试
    [ -e $var ] 存在
    [[ ]]
    **comment**:
    -o represents OR operand,
    -a represents AND operand
        e.g.  if [ ! -d x86/ubuntu -o ! -d "idir" ]
        2019.6

## CH 2
#### cat
    cat: concatenate
    cat /proc/$PID/environ 查看进程的环境变量(???)
    cat -s file #compress blank lines
        <=> cat file | tr -s '\n'

#### script
    script -a a.txt b.session
    scriptreplay
        因为有时延，所以要耐心

#### find
    find /path "reg.txt" -print
    find [options]
    options: -regex -path -name !
        -maxdepth
        -type f
        -atime -mtime -ctime n: 指定xtime为最近n天的文件
        e.g. find . -mtime -amin +n: 指定超过n分钟的文件
        find -user root 所有者为root的文件
        find . -name "*.txt" -exec printf "%s" {} \;

#### xargs
    xargs运行结果返回值为传递参数,将结果传给下一个命令
        cat file.txt | xargs => 读取参数, 分界符\n
        echo "sggsgg" | xargs -d s <=> echo 'strstr'.split('s') <=>  gg gg
        shell.sh | xargs -n X: 每次执行shell.sh arg1-argX X个参数
    xargs -0 -n 3 将\0视为定界符

    tr 什么意思
        -s # delete regex chars like '[0-9]'
        -c # -c [set1] [set2]: keep set2 - C[set1]
    
    md5sum, md5deep

    sort, uniq, 
        sort file1 [file2...] 排序文件内容
        sort -n 按数字
        -r 逆序
        uniq
            uniq -s
            uniq -c --count
变量
    $RANDOM 随机变量(<=65535)
    "$$" 当前脚本的PID
split和csplit
    csplit server.log /SERVER/ -n 2 -s {*} -f server -b "%02d.log"; rm server00.log
        {*}, {n} 分割n次
        /正则表达式/
        -s : silent
        -f : 文件前缀

## 交互输入自动化
    Method 1.
    echo -e "cmd\ncmd2\n" | bash ./it.sh # the key is the -e and \n char
    Method 2.
    expect 和spawn(???)
    terminal input:
        expect autobash.sh
        in autobash.sh:
            ...
            spawn sudo cmd
            expect "Enter name:" #会设定一个map关联expect和send,如果没有匹配的不执行expect
            send "mrrobot"
            ...

## 目录与文件夹
    mv 移动/重命名文件
        mv A B C -t dir 多个文件移动

    comm A B
    col1 col2 col3: A - B, B - A, A 交 B
    求并集: comm A B -3 | sed 's/^\t//' 删除第3列且删除行首\t

    递归创建文件夹 mkdir -p /path1/path2
    权限 chown mode -R file/dirs
        类似于a+x的:
        arg1+arg2
        :a
        :u
        :g
        :o
        arg2
        +x
        -x
    touch
        创建空文件; 修改时间戳
    ln 
### 环回文件
    环回文件(???)
    e.g.
    Method1
    sudo mkdir /mnt/loopback
    mount -o loopback.img /mnt/loopback

    Method2
    losetup /dev/loop1 loopback.img #/dev/loop1 为系统自带
    mount /dev/loop1 /mnt/loopback

    e.g. 写镜像
    dd if=/dev/cdrom of=image.iso
    e.g.
    刻录(??)
    cdrecord -v dev=/dev/cdrom image.iso #把镜像刻录到/dev/cdrom

### diff
    diff -u ver1.txt ver2.txt > diff.patch
    patch -p1 version2 diff.patch # -p1 第一次用会修改,第二次撤销

    打印head, tail开头和结尾
    head -n +5 头5行
    head -n -5 去掉结尾5行的各行
    tail -n -5 最后5行
    tail -n +(N+1) 删除前N行的所有行

    目录记录栈(???)
        pushd, popd
    导出目录结构
        tree /PATH -H http://localhost -o out.html

#### wc
    wc:    wordcount 统计单词
    wc -w -l -c

## CH 4
    > Text Related
    正则表达式
    POSIX 字符类
        [:alnum:] [:alpha:] [:blank:] [:digit:] [:lower:] [:upper:]
    Perl 风格正则表达式
        \b \B \d\ D
    grep
        -B n: 所得文本增加之前n行
        -C n: 所得文本增加之后n行
        -A: 所得文本结果分界
    egrep 等价于 grep -E
#### cut, sed, grep, awk
    cut
        -f 2,3 #FIELD_LIST
        -f --complement 2,3 #除了2,3列外的列

    sed
        sed 's/pattern/replace_string/g' file
            pattern不是grep类型的正则表达式, 如(),?只是字符串,而/有特殊含义; 如果加上冒号, 则写成s:pattern::g # pattern的/不需转义
        -i #不要乱用,会替换源文件
        sed /g -> /Ng #从第N行开始替换
        sed /d #删除
        &  #匹配串引用
        \1 \2 后向引用
        sed 双引号内的$var可以引用变量; 单引号不可以
            如 sed "dkdk"
~~~
        # Read from the file words.txt and output the word frequency list to stdouse
        sed 's/  */\n/g' words.txt | sed -n '/^ *$/!p' | sort | uniq -c | sort -nr | awk '{printf "%s %s\n",$2,$1}'
~~~
**awk**
        按行处理; 含有BEGIN, {}, END三个可选块, BEGIN 和END可以做表头表尾
        保留变量: NR, $0, $1, $2, OFS(定界符)
            NR: 当前行号;
            NF: 当前field数(该行单词数)
            $0: 当前整行
            $1: 第一个文本
            $2: 第二个文本

        传外部参: awk '.x1..x2' x1=$var1 x2=$var2
        删除一行: BEGIN {getline;}
        e.g.
            其他函数 length, split(str, arr, delimiter)
**awk 样例**
    打印第10行
    awk  'NR == 10 {print $0}' # NR == 10是一个标识符,表示条件

    paste
        paste file1 file2 [...]
        合并列
            -d ',' 两个列相连时候的间隔符

    rev, tac 逆序打印

    文本切片
        echo{string:start:chr_number}
        start取值: 

## CH5
    wget, curl
    wget --mirror -c
    wget -O save.html <url> #指定下载文件
    curl -- silent -o -C
        --max-filesize bytes
        -u username:password 用户认证 可以直接登录邮箱
        --cookie 'user=kdkdk;pass=dddjjj'
    另外参考 https://atim.cn/post/1024/


## CH6 归档
    tar, cpio, gunzip, lzma, squashfs, zip, raync, dd
    tar out.tar file1 file2
        -tf # list files
        -rvf # add files
        -cf # compress and add files
        -xf # extract files
        -xf x.tar -C d # extract x.tar to directory d
        -Af # merge tars
        -z # filter
        tar --delete --file x.tar files # delete file from x.tar
        通过shell归档 tar -cf - file1 file2 file3 | tar -xf - -C ./dest

        如果想看到具体的过程加上参数-v, 在压缩包内文件较多的情况下不建议加上-v, 影响效率。
#### tar related
        不加-c则tar 只有归档功能,没有压缩功能
        # reference: http://jksoftcn.com/tag/tar.html
        tar.bz2 = tar + bzip2
        tar.xz = tar + xz
        tar.lzma = tar + lzma
        xz是什么东东？xz是一个使用LZMA2压缩算法的无损数据压缩文件格式。选tar.xz还是tar.lzma你自己看着办吧。

        提取tar: tar -xf test.tar
        解压tar.gz: tar -zxf test.tar.gz # gz=tar+gzip
        解压tar.bz2: tar -jxf test.tar.bz2
        解压比单纯的提取多了一个参数，这个参数就是压缩算法：
        -z gzip
        -j bzip2
        -J xz
        --lzma lzma

#### cpio
    大部分人可能一年都碰不到一次，但有人确实有这样的需求。现在很多路由器固件和手机rom会涉及到cpio这种archive格式。

    zip和unzip
        zip -r dst.zip folder/ file
        unzip foo.zip
        unzip foo.zip -d dir
#### squashfs
    超高压缩比工具
    mksquashfs
      e.g. sudo apt-get install squashfs-tools
      e.g. mksquashfs file dst

## 加密与散列
    crypt gpg base64 md5sum sha1sum rsync

#### openssl
    a library for socket encryption, which includes many sha and encryption algorithms.
    openssl sha1/smime/rsautl...

    **rsync** src dst
    e.g. rsync -az hadoop/ ubuntu@192.168.1.2:/home/hugo
    dst=path
        host@ip:path
#### dd
    dd 不正确的使用会造成数据丢失;因此它获得了data destroyer的谑称


## Chapter 7 ping, route, SSH
    传输文件
    SSH登录
    多播式窗口
    设置无线网
    
    ifconfig
        ifconfig eth0 hw ether
        多线程 http://blog.51cto.com/mochaming/1279864

    无用之术:
    sftp USER@domain
    scp
        e.g. scp filename user@remotehost:/home/path
                scp user@remotehost:/home/path filename
    
    ssh
        登录user@host后可以执行命令的做法:
            e.g. ssh user@host "commands" > ff.txt(not necessary)
            e.g. sshfs user@host:/path /mnt/mountpoint #在本地挂载远程目录
    
    GUI
        zenity --info --text "This is a message" # function:showing info in shell writing


    当前目录大小
    du -ah | tail -1 #get the last line
        <=>du -sh #summarize
    

## Chapter 8
    磁盘
    df
    
    查看登录信息
    last | head
    who # get user info

    **logrotate**
        系统管理员用的一种配置文件

### 入侵检测日志
    定时检测登录日志: TODO
    **crontab** 定时调度

## Chapter 9
#### ps, kill
    ps -e #所有进程
        -o [option] #show content based on option
        e.g. ps -eo para1,para2,para3 #搭配o取值
             -o para 取值:cmd,pcpu,pid,
        e.g. ps -eLf
    kill [option]
        -l # list the kill signals
        -9 # use signal 9 (SIGKILL) to kill process

#### wall, whereis, which, file, whatis

#### cron
    crontab file format: * * * * * filename #min, h, mday, month, weekday
    e.g. crontab -e

#### mysql


## References
http://man.linuxde.net
http://www.itdaan.com


符号:??? - 有啥用
??概念啥意思
??? 有意义吗

{} 替代符 不能加空格
${} 取值
$?
() 子进程
/dev/null 黑洞
192.168.0{1..255}
#### shell脚本特殊参数
    $0	当前脚本的文件名
    $n	传递给脚本或函数的参数。n 是一个数字，表示第几个参数。例如，第一个参数是$1，第二个参数是$2。
    $?	上个命令的退出状态，或函数的返回值。
    $#	传递给脚本或函数的参数个数。
    $*	传递给脚本或函数的所有参数。
    $$	当前Shell进程ID。对于 Shell 脚本，就是这些脚本所在的进程ID。

### 问题
怎么用sort 生成排序后的文件?
du -h 递归查看目录大小
lynx 清洗数据
    lynx -dump ./file
Twitter 客户端
Web后端查询

///
cmd并行ping
(
    ping $ip -c2 &> /dev/null;
    if [ $? -eq 0 ];
    then
        echo $ip is alive
    fi
)&
wait
///
1.
vim 光标移动到行尾之后
2.
复制单词
3.
如何使得脚本的内容执行后本shell不会改变(如切换目录)？
source ./ss.sh
