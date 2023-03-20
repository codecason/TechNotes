wget https://apache.website-solution.net/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip


# 换源加速
阿里云的：
http://maven.aliyun.com/nexus/content/groups/public/

配置方法：在maven安装目录的setting.xml中配置

<mirrors>
	<mirror>
	  <id>alimaven</id>
	  <name>aliyun maven</name>
	  <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
	  <mirrorOf>central</mirrorOf>        
	</mirror>
</mirrors>
