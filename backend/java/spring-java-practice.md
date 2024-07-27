#### 问题
Q:maven有哪些常用的命令?如mvn dependency:sources
A:mvn dependency:resolve -Dclassifier=javadoc
Q:第三方注解是什么?是怎么实现的?
A:
Java目前只内置了三种标准注解：@Override、@Deprecated、@SuppressWarnings，以及四种元注解：@Target、@Retention、@Documented、@Inherited
spring有    Autowired
    Service
    Repository
mybatis也有类似的。

Q:spring资源放在哪个路由和本地的位置?
A:默认在src/main/java/resources

Q:如何生成用户ID?
A:

Q:Eclipse在引入或创建Maven工程后，不显示Maven Dependencies，如下图所示：
https://blog.csdn.net/lin_xiaofeng/article/details/78803527
这是因为要么配置文件.classpath一开始就没配置maven的依赖,要么是手动增加依赖去了;改好maven然后maven update一下就没事了(侧面说明不能完全照着eclipse的提示错误改)
<classpathentry kind="con" path="org.eclipse.m2e.MAVEN2_CLASSPATH_CONTAINER">
    <attributes>
        <attribute name="maven.pomderived" value="true"/>
    </attributes>
</classpathentry>

Q:Java List是浅复制,取出元素的时候怎么不修改原元素?
A:

Q:freemarker的作用是什么?
A:用来填充application.properties的网页模板匹配,这样controller再返回url后缀的时候服务器就会选择对应的网页(默认)

Q:deployment descriptor
A:

Q:XSS过滤器有什么用?
A:

Q:spring框架不用担心线程安全吗?
A:

Q:jdbc,mybatis的#有什么用?
A:

Q:web.xml
A:

mybatis useGeneratedKeys param
spring-dao.xml
    typeAliasesPackage
    sqlSessionFactory
applicationContext.xml
    propertyConfigurer

Q:ApplicationContext和BeanFactory的异同
A:都是容器,能力不同

Q:applicationContext.xml的xmlns,xsi是什么?
A:命名空间;


#### 错误
parent项
dependency
build-plugin项
mvn spring-boot:run
mvn clean package -Dmaven.test.skip=true

#### 脚本

    框架基础——全面解析Java注解 https://www.cnblogs.com/Qian123/p/5256084.html

<%

<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://www.w3.org/2001/XMLSchema"
targetNamespace="http://www.lexueba.com/schema/user"
xmlns:tns="http://www.lexueba.com/schema/user"
elementFormDefault="qualified">
	<element name="user">
	　<complexType>
	　　 <attribute name="id" type="string"/>
	　　 <attribute name="userName" type="string"/>
	　　 <attribute name="email" type="string"/>
	　</complexType>
	</element>
</schema>
自定义XSD文件
用户类
getBean解析结果

Spring Bean的生命周期:
	实例化策略进行实例化
		是什么?
		AbstractBeanDefinition->BeanWrapper
	实例化的构造函数解析方法
		Class是类,可由任意类得到
		Aware后缀的自定义初始化Bean类
	单例的属性依赖的解决
	初始化
	销毁
	拦截器+动态代理
AspectJ
    AOP

%>




#### 微博
可改进:朋友关系;

测试用例:
1.异常处理:
	1.1 Redis
	redis无法连接
	redis中无对应数据
	初始化注册1000个数据

	1.2 MySQL
    MySQL连接失败;插入数据失败;MySQL断开

	1.3 网页
	登录页面
		ajax获取用户ID并获取新头像失败
		如果用户密码错误,js要知道怎么处理
		index页面
		返回404 Not Found页面
		注册页面
			注册失败
		微博发布页面
	1.4 通用问题
		redis停止了,**抛出异常**

	1.5 

2.性能指标
	2.1 监控CPU,IO,Disk
	2.2

3.正常功能
	3.1 注册用户
	3.2 登录用户
	3.3 home网页
	3.4 发布微博
	3.5 删除微博

4. 高级功能
4.1 文本搜索
	Elastic Search
	查找用户
	添加用户
4.2 发布视频

4.3 后台管理
    上传文件插入数据库
	可以配置是否启用redis-server

密码:
	mouse+666666

redis:
    2.8.0 low version of jedis can not connect new version redis.
	Linux:
		redis-server --daemonize yes
	Windows:

4.4
MySQL数据库
	Date数据
	比较
	减法

网页代码高亮
	prism.js + babel + webpack打包
	or monaco.js
安装:
	npm install --global webpack  --registry=http://r.cnpmjs.org

	npm install --global webpack-cli  --registry=http://r.cnpmjs.org
webpack
	entry
	output
	babel
	postcss
	module处理
	backbone(plugin)
	loaders
安装loader
	npm install url-loader --save-dev
配置文件web
module.exports = {
	module: {
		rules: [
		    {   test:/\.(png|jpg|gif)$/i,
				use: [
				{
				    loader:'url-loader',
					options: {
						limit: 8192
					}
				}
				]
			}
		]
	}
}
报错,继续安装file-loader
	> Error: Cannot find module 'file-loader'
	
	{
	  test:/\.m?js$/i,
	  exclute: /(node_modules|bower_components)/,
	  use: {
		loader: "babel-loader",
		options: {
		  presents: ['@babel/present-dev']
		}
	  }
	}
--save是对生产环境所需依赖的声明(开发应用中使用的框架，库),--save-dev是对开发环境所需依赖的声明(构建工具，测试工具)
CH5.
babel-loader
	async await语法糖 ES6
	jsx语法
	npm install @babel/plugin-transform-react-jsx -D
		AMD define
		less sass loader
css-loader
	npm install css-loader --save-dev --registry=http://r.cnpmjs.org
html-loader
	npm install html-loader --save-dev --registry=http://r.cnpmjs.org

style-loader:
	css-loader: 加载.css文件
	style-loader:使用<style>将css-loader内部样式注入到我们的HTML页面
	npm install style-loader --save-dev --registry=http://r.cnpmjs.org
修改style-loader顺序
	Module build failed (from ./node_modules/css-loader/dist/cjs.js):
	CssSyntaxError
修改github

#### References
	monaco https://zhuanlan.zhihu.com/p/47746336
	webpack.js.org
	webpack 从入门到工程实践
	https://www.jianshu.com/p/9349c30a6b3e
    [Spring Core](https://javabrains.io/courses/spring_core/)