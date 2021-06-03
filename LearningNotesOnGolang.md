

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
~~~

[Go Preemptive Scheduler Design]()
[GPM模型](https://www.cnblogs.com/X-knight/p/11365929.html)
