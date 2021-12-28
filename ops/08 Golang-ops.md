1. 
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

2.
package xxx is not in GOROOT  
    export GO111MODULE=on  
    go mod init `mod_name`  

    或者
    This package requires go v1.16, please upgrade your go version or use the appropriate docker builder.

3. go版本升级  
    sudo apt-get purge golang*
    rm -rf /usr/local/go

4. 打包
    写Makefile,makefile里的命令是 go build -X "xxx" -o dest ./main.go

部署

发布module

#### golang
dlv-dap


#### golang 常见命令
~~~
# help
go help get

## in project/
go build  

## in project/src/
go get -u # u: use the network(which default does not use so not latest)
go get -dv ./...

# For packages

go build   # builds your package then discards the results.
go install # builds then installs the package in your $GOPATH/pkg directory.


go build ./...  # build the package in the current folder and all pakcages recursively.
go get -d -v ./...  # discard install; v: verbose of get; ./...: 

## auto clean unuse module (by code analysis)
go init mod modname
go mod tidy

go vendor

~~~

### go 调试工具
#### go devle

go get -u github.com/derekparker/delve/cmd/dlv
