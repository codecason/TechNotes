
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
