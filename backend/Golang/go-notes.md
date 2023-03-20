go的环境搭建



go参考项目


#### 1. go mod tidy

go 

`go build` just compiles the executable file and moves it to the destination. `go install` does a little bit more. It moves the executable file to `$GOPATH/bin` and caches all non-main packages which are imported to `$GOPATH/pkg`. The cache will be used during the next compilation provided the source did not change yet.



~~~shell


~~~

[grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway)

```
go env -w GO111MODULE=off
go install \
    github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
    github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2 \
    google.golang.org/protobuf/cmd/protoc-gen-go \
    google.golang.org/grpc/cmd/protoc-gen-go-grpc
```

~~~
go get -u google.golang.org/protobuf/protoc-gen-go
go get -u google.golang.org/protobuf/proto

go get -u github.com/golang/protobuf/protoc-gen-go

~~~


C:\Program Files\Go\bin\go.exe

D:\All-Jobs\goPath\bin\protoc-gen-grpc-gateway.exe

