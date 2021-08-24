

G-P-M 模型
    work-stealing算法
        每个P绑定下的Goroutine队列  
        全局的Goroutine队列  
    阻塞与唤醒  

~~~go
// 两种遍历方式
for i := range ch {
    fmt.Println(i)
}

// 以返回值判断

for {
    i, ok := <- ch
    if !ok {
        break
    }
    fmt.Println(i)
}

~~~

#### Example II

~~~go
// channel 的select语法
func main() {
    ch := make(chan int, 1)
    for i := 0; i < 10; i++ {
        select {
            case x := <- ch:
                fmt.Println(x)
            case ch <- i:
        }
    }
}
~~~

~~~go
package main
import "fmt"
import "reflect"

func createCases(chs ...chan int) []reflect.SelectCase {
    var cases []reflect.SelectCase
    for _, ch := range chs {
        cases = append(cases, reflect.SelectCase{
            Dir: reflect.SelectRecv,
            Chan: reflect.ValueOf(ch),
        })
    }
    // 创建send case
    for i, ch := range chs {
        v := reflect.ValueOf(i)
        cases = append(cases, reflect.SelectCase{
            Dir: reflect.SelectSend,
            Chan: reflect.ValueOf(ch),
            Send: v,
        })
    }
	return cases
}

func main() {
    var ch1 = make(chan int, 10)
    var ch2 = make(chan int, 10)
    var cases = createCases(ch1, ch2)
    // 执行10次select
    for i := 0; i < 10; i++ {
        chosen, recv, ok := reflect.Select(cases)
        if recv.IsValid() {
            fmt.Println("recv:", cases[chosen].Dir, recv, ok)
        } else {  // send case
            fmt.Println("send:", cases[chosen].Dir, ok)
        }
    }
}

~~~

~~~go
// 循环中使用go协程
for _, peer := range peers {
    go func() {
        fmt.Printf("%v", peer)
    }()
}
~~~

#### 使用Context同步信号 [3]
context.Context 的使用方法和设计原理 — 多个 Goroutine 同时订阅 ctx.Done() 管道中的消息，一旦接收到取消信号就立刻停止当前正在执行的工作。

~~~go
func main() {
    ctx, cancel := context.WithTimeout(context.Background(), 1 * time.Second)
    defer cancel()
    go handle(ctx, 500 * time.Millisecond)
    select {
        case <- ctx.Done():  // 这里订阅, 如果挂了就停止
            fmt.Println("main", ctx.Err())
    }
}

func handle(ctx context.Context, duration time.Duration) {
    select {
        case <- ctx.Done():  // 这里订阅
            fmt.Println("handle", ctx.Err())
        case <- time.After(duration):
            fmt.Println("process request with", duration)
    }
}

~~~

[Go Preemptive Scheduler Design]()
[GPM模型](https://www.cnblogs.com/X-knight/p/11365929.html)
[Go 语言设计与实现](https://draveness.me/golang/docs)
