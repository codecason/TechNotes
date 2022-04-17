#### 

#### 
一部分Antlr4的g4（grammar）文件的写法（主要参考Antlr4官方wiki：https://github.com/antlr/antlr4/blob/master/doc/index.md）。最有效的学习Antlr4的规则文法的写法的方法，就是参考已有的规则文法，大家在学习中，可以参考已有语言的文法。而且Antlr4已经实现了数十种语言的文法，如果需要自己定义，可以参考和自己的语言最接近的文法来开发。

规则文件/规则文法

~~~antlr
Id :        [a-zA-Z_] ([a-zA-Z_] | [0-9])*
IntLiteral: [0-9]+
GT :        '>'
GE :        '>='
~~~
intDeclaration : Int Identifier ('=' additiveExpression ) ?;
MatchIntDeclare() {

}

#### 
语法类型
    递归下降算法  


### 安装antlr
download antlr-4.0-complete.jar  
参考 https://www.antlr.org/  
https://time.geekbang.org/column/article/126910

unix 命令设置
~~~shell
export PATH='.:/usr/local/lib/antlr4-complete.jar:$PATH'
alias antlr='java -jar /usr/local/lib/antlr4-complete.jar  org.antlr.v4.Tool'
alias grun='java org.antlr.v4.gui.TestRig'

~~~

windows配置
~~~bat
1. windows环境下配置
可执行文件，放在D:\tools\antlr\antlr-4.7.2-complete.jar下面

2.配置环境文件
CLASSPATH=%CLASSPATH%;D:\tools\antlr\antlr-4.7.2-complete.jar
PATH=%PATH%;D:\tools\antlr

3.手写文件antlr4.bat和grun.bat
antlr4.bat
java org.antlr.v4.Tool %*

grun.bat
@ECHO OFF
SET TEST_CURRENT_DIR=%CLASSPATH:.;=%
if "%TEST_CURRENT_DIR%" == "%CLASSPATH%" ( SET CLASSPATH=.;%CLASSPATH% )
@ECHO ON
java org.antlr.v4.gui.TestRig %*

4.然后就可以执行antlr4和grun命令了
比如antlr4 Hello.g4,  javac Hello*.java, 
$ grun Hello r -gui
hello parrt
^Z (windows) 
~~~
