#### Go语法及关键字
- defer
- gofmt工具
    查看go 格式化后的代码
- go doc工具
- go install
- go test

- 因式分解关键字 (就是列表语法)
    - import ("unsafe"; "fmt")

- 函数不需按照顺序声明(类似Javascript)
- iota(等于枚举中的行数值, 从0开始)
- 类型别名
~~~go
type TZ int
~~~
- 字符串类型
~~~go
var ch byte = "\x41"
var ch int = '\u0041' // 又称为runes
~~~

- 支持多值返回
- switch
~~~go
k := 6
switch k {
    case 4: fmt.Println("was <= 4"); fallthrough;
    case 5: fmt.Println("was <= 5"); fallthrough;
    case 6: fmt.Println("was <= 6"); fallthrough;
    case 7: fmt.Println("was <= 7"); fallthrough;
    case 8: fmt.Println("was <= 8"); fallthrough;
    default: fmt.Println("default case")
}
~~~

### Channel
~~~go
// channel

~~~


#### Go库
~~~go
// 若要使用cgo,需要:
import "unsafe"
import "C"

func Print(s string) {
    cs := C.CString(s)
    defer C.free(unsafe.Pointer(cs))
    C.fputs(cs, (*C.FILE)(C.stdout))
}

~~~


#### differences in rune string byte

#### Go插件

goreturns
Rpc相关编程
	rpc.Register(m)
	在shell里可以起timeout的新进程
	timeout -k 2s 100s

#### Golang 语法细节
1. golang 遍历map
~~~go
for k, v := range mp {
}
~~~

2. go是否能够修改一个map(或者其他结构体)里的值?
例:
~~~go
type dummy struct {
    a int
}

x := make(map[int]dummy)
x[1] = dummy{a:1}
x[1].a = 2  // ok

y := x[1]   // not ok
y.a = 3   // result: x = {a:2}

~~~
Safety during parallelism. When you are adding elements to a hash, the language often has to copy all the values to a new (bigger) hash table in the background. If elements can be directly modified in memory, it will be impossible to keep all the copies in sync. If all update operations are forced thru "here is a new value", then it's easy to make sure both copies get updated. Without this, copying a hash would be a "stop the world" operation.
https://stackoverflow.com/questions/40578646/golang-i-have-a-map-of-int-to-struct-why-cant-i-directly-modify-a-field-in-a


#### Golang 标准库
2. 遍历目录dirPth
~~~go
package main

import (
    "fmt"
    "io/ioutil"
    "os"
    // "path/filepath"
    "strings"
)

func main() {
	suffix := "log"
	dirPth := "."
	files := make([]string, 0, 10)
	dir, err := ioutil.ReadDir(dirPth)
	if err != nil {
		fmt.Println("error ", dir, err)
	}

	PthSep := string(os.PathSeparator)
	suffix = strings.ToUpper(suffix) //忽略后缀匹配的大小写

	for _, fi := range dir {
		if fi.IsDir() { // 忽略目录
			continue
		}
		if strings.HasSuffix(strings.ToUpper(fi.Name()), suffix) { //匹配文件
			files = append(files, dirPth+PthSep+fi.Name())
		}
	}

	fmt.Println("Hello")
}
~~~

3. 遍历目录dirPth

4. time 库 的使用

https://studygolang.com/articles/12617


5. 反射
~~~
import "reflect"
fmt.Println(reflect.TypeOf(m))
~~~

#### 常用命令

关于模块管理
go.mod 文件里的
replace (
	A => your_real_module_name
)


#### References
[Go 入门指南](https://learnku.com/docs/the-way-to-go/build-and-run-go-programs/3576)  
[Go builtin functions](https://golang.org/pkg/builtin/#make)  
[Go 语言原本](https://golang.design/under-the-hood/zh-cn/part1basic/ch01basic/)
