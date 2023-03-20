## 2019-05
<%
模块: 编译器  
### 编译器
#### 4. Exercises

lcc编译器的源代码可在 ftp.cs.princeton.edu (128.112.152.13) 服务器的pub/lcc目录下免费获得。关于lcc设计和实现最权威的书籍当属两位开发者合著的的经典\<\<A Retargetable C Compiler: Design and Implementation>> ,中文译本叫《可变目标C编译器——设计与实现》.
而lcc的最新版本4.2却仅有近4万行的代码，这是比较小的，效率高的话大概几天就能看完。
**lcc编译器源码注释工程** https://github.com/nikon77/lcc42
as命令
lcc
cpp
ar命令
-B编译选项

  **编译原理**: <br>
      / 应用 <br>
          读取数据结构定义的.h文件生成meta文件,或者由Python文件进行解析 <br>
          生成JavaDoc <br>

**References**
虎书,龙书,自制编译器,Parsing Techniques,The Reasoned Schemer,The Little Schemer

**Discussion**
1. CSDN 2012.7.4 https://blog.csdn.net/tianwailaibin/article/details/7716833
2. iteye 2012.1.12  https://www.iteye.com/topic/1119240?page=3  
我觉得反而是过去的眼光看的话postgresql功能更多，现在功能上是mysql追了上来。至于前面朋友说的postgresql的大表性能，确实表现平稳些，但mysql这些年真的进步很快，像表分区功能已经看起来像oracle一样了。

上面楼层说C这样的语言难以实践软件工程学，我觉得倒不如说现在的软件工程学太狭隘了。这是我近来的体会。 -2012.1.12 <br>
%>


3. https://www.cnblogs.com/chaser24/articles/6874188.html
 3.0发布后，开始更多的参与版本的设计工作，先是做了3.2 ap易部署版本总体设计并完成了一个模块的编码后就交给其他人做，接着就被老大安排去搞wcloud4.0版本，主要是将软件部署于云平台，在原有基础上虚化出虚拟控制器来实现客户隔离，即访客分权、推送分权等，这一个版本的难点在于几点，如何将软件支持云化部署，访客数据库改造以支实现支持分权的同时提升性能，还有如何实现ap端管理员简易接入管理，这个项目相对顺利的完成了。


### Docker
- docker 编译镜像搭建
1. virtualbox  
  安装过程网络会断开
  迁移位置: 设置UUID
~~~
    VBoxManage internalcommands sethduuid  "C:\Users\euler\VirtualBox VMs\ubuntu-docker\ubuntu-docker.vdi"  
~~~

2. modify source 换源

    可以这样，不换源，就用官方源。然后搭个goagent。然后用sudo apt-get -o Acquire::http::proxy="http://127.0.0.1:8087/" update，进行更新。用代码更新。更新完再sudo apt-get upgrade。国内的源经常出现一些问题，官方源虽然慢了些，但基本不出错。

    rm -rf /var/lib/apt/lists/partial/
    如果你现在能够稳定的重现这个问题，请将apt-get的完整输出发给我们，以便我们排查问题。注意，404和hash sum mismatch一般是由于不同的原因造成的，所以如果你两种情况都能复现，请将两种情况的输出都发给我们。

    对于404 not found，这种问题出现的概率非常小，一般都是客户端配置的问题。但是在没有看到你的输出之前，我暂时先不给你提示，以免产生误导。你如果现在无法重现问题，但是将来碰到的话，可以随时联系我们。

    对于hash sum mismatch，最常见的是小区宽带缓存造成的（国内也有许多学校部署了类似小区宽带缓存的设备），有少数原因是你使用的镜像服务器配置有问题。如果你现在能重现这个问题，那么请将输出发给我们，我再帮助你进一步确认问题。
~~~
    作者：KISS_Gentoo
    来源：CSDN
    原文：https://blog.csdn.net/u011626066/article/details/40107613
~~~

3. 安装virtualbox

  遇到的问题:
  共享粘贴板:
  -1  复制粘贴:虚拟机设置-存储-控制器SATA-勾选"使用主机输入输出(I/O)缓存"  
  -2 常规-高级-共享粘贴板修改配置  
  -3 目录下找到autorun.sh  
  -4 重启ubuntu  
  -5 关于3,要知道/media目录是做什么的  
  修改新源:   vi /etc/apt/sources.list
    每一个Ubuntu发布版本都有它的结束时间，通常，Ubuntu发布版本支持18个月，而LTS (Long Term Support)（长期支持）版本分别支持3年(服务器版)和5年(桌面版)。
  对于那些使用旧版本的Ubuntu的用户，Canonical会维护　old-releases.ubuntu.com　，这是一个过期库的归档。因此，当Canonical支持的Ubuntu过期后，你必须把源切换到 old-releases.ubuntu.com（除非你想在过期前进行升级）。  
  Sol:  sed -i -r 's/([a-z]{2}.)?archive.ubuntu.com/old-releases.ubuntu.com/g'  ./sources.list  
  http://mirrors.ustc.edu.cn/ubuntu-old-releases  
  Sol:  sed -i -r 's/([a-z]{2}.)?archive.ubuntu.com/mirrors.ustc.edu.cn\/ubuntu-old-releases/g'  ./sources.list

5. 安装ssh  
~~~shell
      apt-get install openssh-server
  　　sudo /etc/init.d/ssh resart
~~~

6. 安装docker
  - **Docker ubuntu 16.04 安装稳定版本，社区版版本**
      https://www.jianshu.com/p/b3f70bcffe75
    15.10 安装失败的原因: 各个源中没有对应15.10版本的docker-ce
    sudo apt-get install apt-transport-https \
                        ca-certificates \
                        software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    查看apt-key fingerprint XXXX


  -  **查看apt提供的版本**
  apt-cache madison docker
  -> output:
        docker.io | 1.6.2~dfsg1-1ubuntu4 | https://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ wily/universe amd64 Packages
        docker.io | 1.6.2~dfsg1-1ubuntu4 | https://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ wily/universe Sources
  apt-cache stats

-  6.1 安装完docker后原接口无法上网  
    正确的解决方案难道不是指定 docker0 的IP 地址范围或者监听的时候指定 bind 吗？

-  6.2 添加稳定源  

  由于apt官方库里的docker版本可能比较旧，所以先卸载可能存在的旧版本：
  sudo apt-get remove docker docker-engine docker-ce docker.io

  sudo add-apt-repository \
  "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
  ->  lsb_release -c 无法用 docker-ce 不支持15.10

  sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io  
  apt-get install docker-compose

  6.3 添加用户  
  sudo groupadd docker
  tips: 网上的安装参考教程不成体系,可以看一下有没有参考的代码
  sudo usermod -aG docker $USER
  docker run hello-world
    ->Are you trying to connect to a TLS-enabled daemon without TLS?

  6.4 其他状态命令： 
  sudo service docker start    #启动
  sudo service docker stop    #关闭
  sudo service docker restart #重启

  6.5 实际使用docker  
  docker pull \<yourapp_name\>
  安装docker-ce(docker.io是老版本名称)
  sudo apt-get install docker-ce=18.03.1~ce-0~ubuntu

  USTC的docker hub源太慢:
  /etc/docker/daemon.json
  {
    "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
  }


**使用VirtualBox+Docker搭建可移植的Linux开发环境**

  https://www.jianshu.com/p/7ca57e4f66c5
  **Docker 国内仓库和镜像**
  http://www.cnblogs.com/wushuaishuai/p/9984228.html
  https://raw.githubusercontent.com/silenceshell/docker_mirror/master/docker_mirror.py
  Linux系统目前存在的三种系统启动方式所对应的配置文件目录分别为：
  1. SysVinit：/etc/init.d目录；
  1. UpStart： /usr/share/upstart目录；
  1. Systemd：/usr/lib/systemd目录；
  但是大多数系统上，都会存在多个类似的目录，因此不能简单地根据是否存在相应的配置目录的方式来判断系统的启动方式，这里推荐的方式上是根据init进程号1所对应的可执行文件来判断，如：

  systemctl enable docker # 随系统启动  
  作者：发条蛙  
  链接：https://www.jianshu.com/p/43933d125075

  大多数问题这里都能找到答案，同时官方的态度是不推荐用户自己添加 ppa 源，出了问题概不负责╮(╯▽╰)╭
  3.我听过太多不信任 deepin 的声音，然而我自己用它开发快两年，包括 web 安卓 python 和 c 系等等技术栈，没有什么问题是系统原因导致的，总结下来有几点:①尽量用官方源装软件，那种不由分说就让你添加 ppa 或者下载源码自己编译的辣鸡教程基本可以无视②出了问题多查日志，多搜索错误信息，而不是先怀疑系统有问题③各种乱七八糟的自动化脚本尽量别用，如果一定要用最好自己看一下……有些所谓的自动化脚本为了省事直接拿发行版当做分支判断条件，一言不合就是破坏系统环境……④一定要看教程的话要先 debian 其次 ubuntu，上次碰到个直接卸了 apt 装 yum 的"老手"也是醉的不行⑤实在不行也可以去 launchpad.net 下载需要的 deb 包，然后自己保存好这些 deb 包做安装卸载的管理……
  > sudo docker run -itd -p 21024:22 --privileged=true --name=my_centos -v /home2/my_centos:/home -e LC_CTYPE="zh_CN.UTF-8" -e IS_PARALLELLY_MAKE="1" centos

#### <<Docker_practice>>
  docker 命名空间  
    dock1,pid;netid,pid;userid,pid
  cgroups 技术: Linux内核的技术, 可以对容器的内存和CPU,IO进行限制
  UnionFS 技术:分层联合文件系统
  容器格式: 从0.7 LXC -> libcontainer -> runC -> containerd

  vi /etc/init.d/
  //安装完docker出现的
  docker network is unreachable + unkown host
  iface eth0 inet dhcp
  sudo service network-manager restart
  **出现 connect: Network is unreachable解決方法**
  **DNS**:
  -> auto eth0
  "#iface eth0 inet dhcp"
  配合代码
    /etc/init.d/networking restart

  **Docker search 功能**  
  e.g. docker search [git]
  **Docker build**  
  使用URL github.com/creack/docker-firefox 的 Dockerfile 创建镜像。docker build github.com/creack/docker-firefox
  **Docker常用命令**  
  docker stats
  docker logs

  8. **构建centos docker**
  yum -y install gcc automake autoconf libtool make #安装make
  yum -y install vim
  all-> rcc = $Blburg$E -> $Brcc$E::       $Bmain$O $Blibrcc$A $(EXTRAOBJS)
                $(LD) $(LDFLAGS) -o $@ $Bmain$O $(EXTRAOBJS) $Blibrcc$A $(EXTRALIBS)
  -> $Blibrcc$A $(EXTRALIBS) <br>
  // 查看yum的安装软件版本:
    rpm -qa gdb
  // 查看哪个版本提供某个命令行工具:
  yum provides */netstat
  // 查看当前安装的包

  **实际docker hub**  
  在docker-hub托管的官方镜像如何查找
  https://docs.docker.com/docker-hub/official_images/

#### 搭建SVN 环境
  **启动SVN**  
  svnserve -d -r=/opt/svn/repository【仓库地址】
  **增加默认路由**[delete]
  route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.1.254 <br>
  iptables -t nat -A  DOCKER -p tcp --dport 8001 -j DNAT --to-destination `your_ip`:8000
  **配置SVN 服务器端口内外映射**[delete]
  1、获得容器IP
  docker inspect `your_container_name` | grep IPAddress
  2、 iptable转发端口
  将容器的8000端口映射到docker主机的8001端口 <br>
  iptables -t nat -A DOCKER ! -p tcp -m tcp --dport 3690 -j DNAT --to-destination 172.17.0.2:3690

  locale -a #查看安装的语言包
  cannot set LC_CTYPE locale to XX #可能是没有安装XX语言包

  2.    LC_CTYPE
  用于字符分类和字符串处理，控制所有字符的处理方式，包括字符编码，字符是单字节还是多字节，如何打印等。是最重要的一个环境变量。

  7.    LANG
  LC_*的默认值，是最低级别的设置，如果LC_*没有设置，则使用该值。类似于 LC_ALL。

  8.    LC_ALL
  它是一个宏，如果该值设置了，则该值会覆盖所有LC_*的设置值。注意，LANG的值不受该宏影响。

  你可以选择编辑"/etc/sysconfig/i18n"文件, 但是这个文件是作用于所有用户的,这里我们只修改成自己登录时显示中文。
  在终端中输入命令 vim ~/.bashrc 来编辑“.bashrc”文件, 在最后添加export LANG="zh_CN.UTF-8"。
~~~
> **docker centos7 容器支持 zh_CN.utf8**
  https://www.jianshu.com/p/1381918fb17e

  # 此时需要安装下面的包 ，但是别着急，先看一眼 /etc/yum.conf

  # /etc/yum.conf 中有一句话
  override_install_langs=en_US.UTF-8
  # 将其注释掉!!!
  # 然后运行下面的命令
  yum install kde-l10n-Chinese -y
  yum reinstall glibc-common -y

  相关文件:
  Centos Version Command:
    cat /etc/redhat-release

  **CentOS 7 SVN搭建 (YUM安装)**
  svn co svn://localhost/www /project/wwwTest
  /** TODO: docker 中的svn 端口无法映射, commit Authorization failed
      SOLVED: 修改设置authz,passwd等,注意取消注释**/
~~~

#### Error:
  // Error:
    E220001:
  1. squashfs error
  // downloading
  Get:17 https://mirrors.ustc.edu.cn wily/stable amd64 Packages [166 B]
  Err https://mirrors.ustc.edu.cn wily/stable amd64 Packages
  HttpError404

**Knowledge**:
  5. 字符替换:
      当前行：
      :s/foo/bar/g
      全文：
      :%s/foo/bar/g

  6. 一般添加PPA源是不靠谱的
  yum apt ppa
    echo "deb https://mirrors4.tuna.tsinghua.edu.cn/docker-ce/" >> <br>

  7. **docker容器中查看容器linux版本**
    正确：
    cat /etc/issue
    错误:
    cat /proc/version 或 uname -a ，这样查到的是宿主机的系统。

  8. 卷相关
    LVM 是什么?
    根分区 / 必须总是物理地包含 /etc、/bin、/sbin、/lib 和 /dev，否则您将不能启动系统。典型的根分区需要 150–250MB 大小空间。

**Ubuntu 版本的命名规则和开发代号等科普**  
~~~
    uname -r
    uname -a -> 4.2.0-16-generic #19-Ubuntu SMP Thu Oct 8 15:35:06 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
    cat /etc/issue
    docker 要求 linux kernel 版本 >= 3.10:
    // # 查看当前ubuntu 版本<br>
    cat /etc/lsb-release <br>
    // # 查看 apt-get 中包含的稳定版本<br>
    **apt-get 相关命令**
    sudo apt-cache show docker.io | grep Version <br>
    sudo apt-cache show docker | grep Version
    apt-cache stats
~~~

**References**
    清华源:     https://mirrors.tuna.tsinghua.edu.cn/help/virtualbox/
    中科大源:
    https://mirrors.ustc.edu.cn/help/ubuntu.html
    https://mirrors.ustc.edu.cn/help/dockerhub.html

    网盘工具
    https://www.xiaobd.net/t/12799316

    Ubuntu通过apt-get安装指定版本和查询指定软件有多少个版本
    https://www.cnblogs.com/EasonJim/p/7144017.html


## 2019-06
<%
书单: C# 相关图书推荐: Professional C#

%>

<%
### SQL 必知必会
  子查询
  许多DBMS处理联结比处理子查询快得多
  Oracle 起表的别名需要删掉AS

#### CH13
  Access、MariaDB、MySQL、Open Office Base和SQLite不支持FULL OUTER JOIN语法。

#### CH14 组合查询
  UNION 从多个表中做查询的话可能较快,
  跟多个SELECT语句分开查询的方式要进行比较哪个更快
  UNION ALL 会把不同表的结果都返回,而不是去重

#### CH15 插入数据
  INSERT & INSERT SELECT
  SELECT INTO (DB2不支持)

#### CH16 更新数据
  UPDATE SET WHERE
  如果想从表中删除所有行，不要使用DELETE。可使用TRUNCATE TABLE
语句，它完成相同的工作，而速度更快（因为不记录数据的变动）。

#### CH17 对表的操作
  建表
    时间戳类型
  ALTER TABLE

#### CH18 视图
  CREATE VIEW AS
  所有DBMS非常一致地支持视图创建语法。
  视图可以嵌套
#### CH19 存储过程
CREATE PROCEDURE MailingListCount (
  ListCount OUT INTEGER
  )
AS
v_rows INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_rows
  FROM Customers
  WHERE NOT cust_email IS NULL;
  ListCount := v_rows;
END;

#### CH21 游标
### End of SQL 必知必会
%>



<%
### 大型网络技术架构
一致性哈希算法和缓存集群的关系

%>


<%
### SQL进阶教程
CH 1-4
~~~

HAVING 语句可以单独使用,表示整个表
  COUNT(列名)会去掉NULL的记录
  而COUNT(*)不会去掉
~~~
CH 1-5 外连接的作用
~~~

  报表
  外连接与乘法的相似
  为了减少生成临时表,在两个JOIN的表满足过滤字段的记录数为1对多时,直接相JOIN
~~~

CH 1-6
~~~
关联子查询和自连接很多时候是等价的
E.G.
SELECT year,sale
  FROM Sales S1
  WHERE sale = (SELECT sale
  FROM Sales S2
  WHERE S2.year = S1.year - 1)
ORDER BY year;

SELECT S1.year, S1.sale
  FROM Sales S1,
  Sales S2
  WHERE S2.sale = S1.sale
  AND S2.year = S1.year - 1
ORDER BY year;
~~~

#### Reference
  SQL权威指南
%>

<%
### Tricks:
怎么grep ^M (Windows换行符)
grep -r $'\r' *
删除(亲测没用)
tr -d $'\r' < filename
sed $'s/\r//' -i filename

find ./ -type f -print0 | xargs -0 dos2unix
%>



<%
###Java 核心技术
CH4.
方法参数
值调用和引用调用
  值调用:
    基本数据类型
    对象引用
  引用调用:
    Java没有
4.9
Java Jar包放在基目录/类名的地方

- @注解
- Javadoc 工具

CH5.继承
~~~
超类
super关键字,调用super.ParentMethod();
跟C++的区别:
  方法的动态绑定是默认的,如果不想的话就声明final关键字,这样就不会被子类重写;
覆盖与动态绑定,重写
  @Override

抽象类:
  当且仅当包含>=0个抽象方法的类(可以包含非抽象函数)

所有类的超类:Object
    public boolean equals()
    public int hashCode()
    public String toString()

    Class getClass()
    String getName()
    Class getSuperclass()
    Tips:
    Logger.global.info

泛型数组
    ArrayList
      老版本:Vector
      赋值:  .set(i, value)
            .get(i)
            add(value)
            remove(index)
      ArrayList<> 带尖括号能在编译时提前暴露错误

对象包装器与自动装箱  
  装箱->拆箱

可变数量的参数  
  max(double ... values)
~~~

5.6 枚举
~~~
    java.lang.Enum
    Enum valueOf(Class enumClass, String enumName)
    String toString()
    int ordinal()
    int compareTo(E other)
~~~

5.7 反射
~~~
    获得类名
        Class cl = getClass(className);
        String clname = cl.getName();
    获得类的对象
        String className = "xxx";
        Class cl = Class.forName(className);
    e.g. int.class 也是一个类,但是 int不是一个Class
    异常处理:
        已检查异常和未检查异常
        checked exception
        unchecked exception (如Core)
    Class.
      getFields()：获得某个类的所有的公共（public）的字段，包括父类中的字段。
      getDeclaredFields()：获得某个类的所有声明的字段，即包括public、private和proteced，但是不包括父类的申明字段。

        Field[] getFields()
        Field[] getDeclaredFields()
    Field:
          String Field.getName()
          int Field.getModifiers()
          String Field.getType()
~~~

CH 6.
  @Override注解是一种提示编译器,减少自己出错的方法,
  不写也可以但是不合规范
接口
  Java SE8的一个新特性: 接口中可以写static方法的实现
  接口中的方法实现,这样也避免了使用**伴随类**(就是接口啥事也没干,
  得多加一个类);
  用关键字default,可以在接口中实现空方法;这样implements后的类可以
  不用关心那么多方法的实现(因为implements接口要求每个方法都要有实现)

**解决多接口同名方法冲突**
  直接在新类中Override选择指定方法

JOptionPane.showMessageOialog(nul1, "Quit program?");
6.2
~~~
  Cloneable 接口
  复习final类:适合作为在方法内catch cloneException的类
  clone方法:所有数组都有的方法
~~~
6.3
~~~
  lambda表达式(第10版才有,JDK 1.8以后)
  class NewComparable implements Comparable<> {

  }
  public static void main() {
    Arrays.sort(a, new NewComparable());
  }
  lambda表达式可以与只含一个抽象方法的接口互相转换;
  lambda表达式不能单独存在,要依赖于接口;
  带::的类方法表达式
    Math::pow 等价于 x->Math.pow(x)
  lambda表达式的常用接口:
    Predicate<T>: seek(x, Predicate<int> y);
                  <=> x-> ~x
                Predicate.isEqual(a).or(Predicate.isEqual(b)) 就等同于 x -> a.equals(x) || b .equals(x)
    Runnable
    Consumer
~~~

6.3.5
  构造器引用
    stream.toArray(Person[]::new)
6.4
~~~
  内部类
   内部类可以引用包含它的类的内容,达到访问私有域的效果;不能有static方法
  局部内部类
  匿名内部类
~~~

6.5 代理

  new一个接口会发生什么
  抽象类和接口是一种东西吗?
  javap是什么?

Chapter 7
  To watch class loading, launch the Java virtual machine with the -verbose flag
  jconsole processID
  jmap -dump:format=b,file=dumpFileName processID
  jhat dumpFileName


hashMap在单线程中使用大大提高效率，在多线程的情况下使用hashTable来确保安全。
hashTable中使用synchronized关键字来实现安全机制，但是synchronized是对整张hash表进行锁定即让线程独享整张hash表，在安全同时造成了浪费。
concurrentHashMap采用分段加锁的机制来确保安全

CH 8. 泛型编程
~~~
	T ? newInstance getMethod
~~~

| | | |
|-|-|-|
|Set |HashSet |SetIterator |
|Set |TreeSet |SetIterator |
|Set |TreeSet |SetIterator |
|List |LinkedList |ListIterator |
|Queue | | |
|Map |HashMap | |


CH 9
集合
9.4.4
~~~
	**Immutable** ImmutableMap is convenient for public static final maps.
	**Unmodified**
	Collections类与Collection接口
~~~

CH 10
	UI

CH 11
	Event Handling


CH 14

~~~
	Lock:可重入锁是为了同一个线程能够进入多个函数(它们持有相同的锁)
	Condition Object:await()+signalAll()
	instrinc Lock: wait() + notifyAll()
	compareAndSet()
	DeadLocks
	Ctrl+\
	tryLock和可以被打断的锁lockInterruptibly

	ReentrantReadWriteLock
~~~

14.6
Blocking Queue

14.7
~~~
Thread-Safe Collection
  Map, Set, Queue
  ConcurrentHashMap 弱一致性
  CopyOnWriteArrayList
  同步包装器 Collections.synchronizedList
~~~

14.8 Callables and Future
  Callable, Future and FutureTask

14.9
~~~
  Executor
  pool.submit(Callable)
  pool.submit(Runnable)
  并行计算线程(如归并排序)
  CompletableFuture
~~~
封装的同步数据结构
14.10
SynchronousQueue
14.11 GUI编程
EventQueue.invokeLater

**End of Java Concurrent**

<%
### VIM 实用技巧
普通模式下
  x 删除字符
  >G 缩进到结尾

  C剪切到行尾
  插入上一行:O
  f{ch}: find **ch**
  **;**: repeat to find the character of f{ch}
  **,**: step back to previous
  num<C-x>:Ctrl + x, 在之后的第一个数字加数num
  加减法

vim恢复swp文件以及比较swp文件的变化
  vi -r file.txt

CapsLock键可能造成普通模式输入问题

7zip和其他压缩软件的对比:
	加密 OK
	任意文件后缀压缩 No,比如tar.gz(tgz)就不行
	文件后缀关联 可以在设置中修改
	直接压缩tar.gz
	No,要先打包tar，再把tar用gzip压缩

%>



### CMake
~~~
check_function_exists
template:
	cmake_minimum_required(VERSION 3.0)
	project(Hello)
	set(SOURCE main.cpp)
	add_executable(${PROJECT_NAME} ${SOURCE})
	add_definitions("-Wall -g -O0")
~~~



### Make
打印make过程中的执行命令

make -n xxx  
make --just-print

