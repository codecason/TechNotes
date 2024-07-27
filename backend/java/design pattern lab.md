#### 创建型
- 单例模式
- <del>简单工厂模式(不在23种之中) </del>
- 工厂方法模式
- 抽象工厂模式
- 建造者模式
- 原型模式

#### 行为型
- 责任链模式 Chain Of Responsibility
- 命令模式 [难理解, 为什么Client端依赖于Command具体实现?而且Client明明持有了Invoker,但是UML图中没有直接连线到Invoker? ] Command
- 解释器模式 Interpreter
- 迭代器模式 Iterator
- 中介者模式 Mediator
- 备忘录模式 Memento
- 状态机模式 State
- 观察者模式 Observer
- 策略模式   Strategy
- 访问者模式 Visitor
- 空对象模式 Empty
- 模板方法模式 Template Method

#### 结构型
- 适配器模式 Adapter
- 桥接模式 [似乎是自由组合用的] Bridge
- 组合模式 Composite
- 装饰器模式 Decorator
- 外观模式 Facade
- 享元模式 Flyweight
- 代理模式 Proxy

#### QA
代理模式和桥接模式的区别
桥接模式看起来像组合,那起名为组合模式的模式是什么?
代理模式和适配模式的区别
组合模式是什么?
策略模式说是以多个相似策略进行替换,避免修改客户端,那么它跟外观模式(Facade)有什么区别?
策略模式跟状态模式的UML图是一样的,那么这两种模式有什么区别?
    另外,从这里也看出来,UML图不能用来完全确定地表示设计模式。

桥接模式是说抽象出两个维度,在实体和行为方面进行分离,那这跟接口的单纯实现和使用有什么区别?

Dispatcher Reactor用了什么设计模式?
    似乎用到了命令模式,代理模式,Overserver模式

Obverser模式有点像注册回调函数?无论是Kafka消息队列,还是各种异步处理请求方式,javascript的event listner似乎都有它的身影

中介者模式是一个主管管理很多个类,好像是facade模式一样,其实也不知道有什么区别.

抽象工厂和工厂方法模式有什么区别?

Proactor用了什么设计模式?

#### More infos:
https://www.cnblogs.com/edisonchou/p/7512912.html
[zyc设计模式](https://github.com/CyC2018/CS-Notes/blob/master/notes/设计模式%20-%20目录.md)
