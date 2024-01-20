```c++
thread_local int tmp;
int add10(int a) {
  tmp = a;
  return tmp + 10;
}
```



网卡驱动的NAPI机制

    napi_schedule -> 发出软中断

IO 多路复用  
    每个连接或socket不立刻处理所有的事件, 而是先保存当前的数据  

select 注册的事件只能有1024个
epoll:  
    rbr + 双向链表
    rbr只是用来做增删改的

用户态异步:  
    AIO  
    用户态异步且IO 同步

proactor和reactor  
    是异步的吗?

多线程下的epoll  

    http://175.178.37.162:8888/tree



#### 语言里的并发

~~~
1. Semaphore = CountDownLatch = Channel
   Mutex = Semaphore(1)

2. JS语言里的 acquire

~~~



|                    | C/C++ | Java | Js   | Go   |
| ------------------ | ----- | ---- | ---- | ---- |
| mutex              | mutex |      |      |      |
| condition_variable |       |      |      |      |
| semaphore          |       |      |      |      |
| reentrant_lock     |       |      |      |      |
| P,V                |       |      |      |      |
| rwlock             |       |      |      |      |
| future, promise    |       |      |      |      |



#### C++ 并发编程实战(PENDING，不要看)

平台无关的C++类库: Boost, ACE  

大流量连接的场景下, 使用线程池可以产生性能优化  

不同的编程范式: 回调; future的计算, onreturn, onerr  

不同的体系架构  

计时器超时回调  

~~~golang
package main

import (
	"fmt"
	"time"
)

func startTimer(duration time.Duration, callback func()) {
	time.AfterFunc(duration*time.Millisecond, func() {
		callback()
	})
}

func myCallback() {
	fmt.Println("Executing myCallback...")
}

func main() {
	fmt.Println("Starting timer...")
	startTimer(20, myCallback)

	// Wait for the timer to finish before exiting
	time.Sleep(21 * time.Second)
}

~~~

~~~c++
std::thread my_thread([]{
    do_something();
    do_something_else();
});
~~~

thread.joinable，detach，join的意义

传参与std::ref的关系

~~~
std::thread t(update_data_for_widget,w,std::ref(data));

std::thread t(process_big_object,std::move(p));
~~~

scoped_thread

#### 2. 同步

细粒度锁

无锁数据结构

CPU、GPU体系结构

读写锁


#### Java并发编程实战(5.20)

2小时 (15:17)

