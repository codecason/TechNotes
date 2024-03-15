#### FAQ

注解有什么用,是一种注释还是编译限制?


同步在Java里经常跟信号量关联?  
但是同步似乎又表示多个线程里的数据相同?  
	Synchronization refers to one of two distinct but related concepts: synchronization of processes, and synchronization of data.

	Forks and Joins: When a job arrives at a fork point, it is split into N sub-jobs which are then serviced by n tasks. After being serviced, each sub-job waits until all other sub-jobs are done processing. Then, they are joined again and leave the system. Thus, parallel programming requires synchronization as all the parallel processes wait for several other processes to occur.

	Producer-Consumer: In a producer-consumer relationship, the consumer process is dependent on the producer process till the necessary data has been produced.

而且还表示阻塞与否? 
	同步与异步
	Synchronous = happens at the same time. Asynchronous = doesn't happen at the same time. 

怎么构造一个visibility有问题的例子?

#### IDEA的快捷键

idea:
	替换:  
	关闭: ctrl + F4  
	运行: shift + F10  
