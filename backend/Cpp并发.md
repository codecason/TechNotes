grep -rniw thread . | wc -l
grep -rniw atomic . | wc -l
grep -rniw lock . | wc -l
grep -rniw unlock . | wc -l
grep -rniw jthread . | wc -l
grep -rniw mutex . | wc -l
grep -rniw runtime . | wc -l

thread
atomic
jthread
mutex
memory_order_relaxed

==========
tidb

thread 367
lock 3308
unlock 1427
jthread 0
mutex 364
runtime 872

==========
libuv

thread 399
lock 61
unlock 1
jthread 0
mutex 164
runtime 24

==========
pytorch

thread 2399
lock 1379
unlock 89
jthread 0
mutex 1504
runtime 2127

#### Task1

https://en.cppreference.com/w/cpp/thread

##### 1.c++ 并发原语


​    
    cpp 同步原语:
        yield
        条件变量
        future
        (C++11) promise 
        (C++11) scoped_lock
        (C++11) future
        (C++11) shared_future
        condition_variable
        (C++11) async
        (C++11) launch
        (C++11) future_status
        (C++11) packaged_task
       
    1. thread的detach
    	要搭配promise和future; 否则生命周期结束无法得到结果
    
    2.async返回了future, future的get会等待完成?
    	auto a2 = std::async(std::launch::deferred, &X::bar, x, "world!");
    	async用get
    	deferred用wait
    	且可以复合async和deferred
    
    3.wait不加condition_variable可能导致丢失事件
    
    4.⭐yield
    
    5.shared_ptr跟并发的关系?
    	可以不清楚生命周期，并且在临时决定删除一个对象的时候删除；
    
    ue的逻辑块umg, slate
    


##### 2. Java并发原语

~~~
synchronized
ReentrantLock
Semaphore(=1)
CountDownLatch(=N)
CyclicBarrier
	.await

StampedLock
	.tryOptimisticRead
	.readLock
	.writeLock

Executor
	.submit(Runnable Task) -> Future<?>
	.submit(Callable<T> Task) -> <T> Future<T>
	.invokeAll()

LinkedBlockingQueue

1.线程池Executor和Future
	Executors.newFixedThreadPool
	Executor.submit
	LinkedBlockingQueue
等价于 ThreadPoolExecutor(... new LinkedBlockingQueue<Runnable>())

2.AtomicInteger是什么

3.ReentrantLock是unstructured locking

~~~

##### 3.Golang并发原语

~~~
Channel
WaitGroup
Goroutine/go: 有栈协程

sync.mutex
sync.cond
sync.once
sync.Pool

⭐Context
GPM模型

~~~

##### 4.Python并发原语

~~~
multiprocessing

~~~

##### 5.C#/Rust

~~~
标记IO阻塞
委派模式 delegate
Lock
Thread
Monitor
Semaphore(可以跨进程使用)
	.waitOne
	SemaphoreSlim
Task

AutoResetEvent
CountdownEvent
Parallel

=====================================
Rust Arc
	Atomics
	Condvar
	Channel
	std::sync::mpsc(Multiple Producer Single Consumer)
		Sender
		Receiver

~~~



##### 5.多线程下的协程

~~~
TODO: 走不下去了
难道要看RTOS?

~~~



多线程协作工具：CyclicBarrier与CountDownLatch详解 https://cloud.baidu.com/article/3306872

C++ Core Guidelines: Be Aware of the Traps of Condition Variables https://www.modernescpp.com/index.php/c-core-guidelines-be-aware-of-the-traps-of-condition-variables/

GoChannel的实现 https://github.com/halfrost/Halfrost-Field/blob/master/contents/Go/go_channel.md

⭐ 有栈协程与无栈协程 https://mthli.xyz/stackful-stackless/



TODELETE

~~~
Android为什么用上协程后反而更慢了？ https://mp.weixin.qq.com/s/P9VIquZnp1lrYPfkqWqabg

~~~



#### 语言里的并发

~~~
1. Semaphore = CountDownLatch = Channel
   Mutex = Semaphore(1)

2. JS语言里的 acquire

~~~

#### 并发概念-参考知乎(5.6)

~~~
Golang在IO相关的生态上；
是否区分async：
	Python，C#区分async；
	Golang不区分async；底层异步；
	Golang是有栈协程；
	是否跟性能有关系? IO Golang > Rust/C++

有栈协程 vs 无栈协程
	协程环境下的阻塞API
	无栈协程=async协程? 看不到完整的栈信息？

协程Runtime
	M:N架构通用最优
	M:1（协程不会跨线程）的Runtime

网络代理 vs 存储服务 vs 金融量化
	Rust使用了Tokio和async-Std，性能弱于Golang；

Executor
	线程池；
	阻塞友好；
	线程池 vs 协程池
	Executor间互调用 vs Executor内调用 vs 进程间通信

Hook 系统调用


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



#### 基架项目

~~~
Hello Chatgpt.I wanna know the working mechanism of await in python.
For example,is it necessary to use lock in await in python? If yes,in what situations should it use?


~~~

