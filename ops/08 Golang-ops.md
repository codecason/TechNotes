
go的低版本拉不到一些镜像的问题:

    export GO111MODULE=on (1.14版本后可以默认支持,之前的话需要export)

其他变量:  
~~~sh
    // export GOPROXY=http://mirrors.tencentyun.com/go,direct
    export GOPROXY=https://goproxy.cn,direct
    export GONOPROXY=
    export GONOSUMDB=
    export GOPRIVATE=
~~~

package xxx is not in GOROOT  
    export GO111MODULE=on  
    go mod init `mod_name`  

    或者
    This package requires go v1.16, please upgrade your go version or use the appropriate docker builder.

go版本升级  
    sudo apt-get purge golang*
    rm -rf /usr/local/go

打包
    写Makefile,makefile里的命令是 go build -X "xxx" -o dest ./main.go

部署

发布module
