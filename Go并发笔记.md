#### 并发 on Go

    sync.Once

#### 
竞态条件

互斥 + 临界区

管道: 多路复用的命名管道

标准信号与实时信号

#### 多线程 3.1

pthread_attach 连接线程

pthread_detach 分离线程

pthread_cancel 取消线程

    线程调度

    调度器预测

    动态优先级
    静态优先级

    线程分类  
        用户级线程  
        内核级线程  Linux的默认实现  
        两级线程模型  

#### 多线程同步 3.2
互斥量:
    避免竞争

    临界区:
        合理范围内尽量大  
        合理切分避免大锁耗费时间  
        避免保护的临界区重叠造成死锁

    锁定-回退
        tryLock - goBack解决死锁
        可能造成程序复杂性增高

    固定顺序解锁方法
        防止死锁

    保持共享数据的独立性是预防因为使用互斥量而导致死锁的最佳方式

信号量:

条件变量:
    生产者, 消费者问题

Go常见问题
~~~go
WaitGroup
    wg := sync.WaitGroup()

goroutine 和 channel 的关系

waitgroup和mutex

sync.Done()

mutex

~~~


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


#### WaitGroup

[Go Preemptive Scheduler Design]()
[GPM模型](https://www.cnblogs.com/X-knight/p/11365929.html)
[Go 语言设计与实现](https://draveness.me/golang/docs)
