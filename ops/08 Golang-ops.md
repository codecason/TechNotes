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

~~~
Q: package xxx is not in GOROOT  
或者
This package requires go v1.16, please upgrade your go version or use the appropriate docker builder.

# 初始化GO MOD
    export GO111MODULE=on  
    go mod init `mod_name`  
~~~

3. go版本升级 

~~~
Q:1.13版本之后 https://goproxy.cn,direct
Q:1.16版本之后 GO111MODULE=on

A:

sudo apt-get purge golang*
rm -rf /usr/local/go
download go1.16.5.linux-amd64*tar.gz from https://golang.google.cn/dl/
如 https://golang.google.cn/dl/go1.18.10.linux-amd64.tar.gz

~~~


5. 打包
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

### 配置VScode
~~~
# 配置windows环境变量
GO111MODULE=on
GOPROXY=https://goproxy.cn,direct
~~~
~~~shell
# Ctrl+Shift+P -> go:tools, edit in settings.json
#### VScode: Preferences.Settings.json

    "go.alternateTools": {
        // "go.toolsGopath": "/home/code/.gocache/gotools", // tools的绝对路径
        "go.goroot": "/usr/local/go",
        "go.useLanguageServer": true,
        "go.autocompleteUnimportedPackages": true,
        "go.gocodeAutoBuild": true,
        "go.gotoSymbol.includeGoroot": true,
        "go.gotoSymbol.includeImports": true,
        "go.buildOnSave": "package",
        "go.vetOnSave": "package",
        "terminal.integrated.env.linux": {
            "GOPROXY": "https://goproxy.cn,direct",
            "GO111MODULE": "on",
        },
    },
    "go.toolsEnvVars": {
    
        "GOPROXY": "https://goproxy.cn,direct",
        "GO111MODULE": "on",
    }
~~~



### go 调试工具

#### go devle

go get -u github.com/derekparker/delve/cmd/dlv
