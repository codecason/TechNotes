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

#### References
[Go 入门指南](
https://learnku.com/docs/the-way-to-go/build-and-run-go-programs/3576)
