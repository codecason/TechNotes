RAII 是什么?

#### Section I.

https://www.v2ex.com/t/541477  
C++ 虚函数这是面试初、中级 C ++ 职位一个概率 95%以上的面试题。一般有以下几种问法：

什么是虚函数？虚函数的实现原理是什么？  
    虚表: * __vptr成员变量,指向的一个表  

什么是虚表？虚表的内存结构布局如何？虚表的第一项（或第二项）是什么？  
    查看分布方式: gdb的时候用info vtbl obj

    内存结构为: 从上到下, 从基类的虚函数到子类继承得到的虚函数(如果虚函数已经被覆盖,则偏移量是子类的函数offset;)

菱形继承（类 D 同时继承 B 和 C，B 和 C 又继承自 A ）体系下，虚表在各个类中的布局如何？如果类 B 和类 C 同时有一个成员变了 m，m 如何在 D 对象的内存地址上分布？是否会相互覆盖？

    m会在每个类D所继承的表中占有自己独立的内存空间(不会被覆盖);
    D对象中会把继承得到的非虚函数的成员都放到最后; 不会互相覆盖, 它们会各自维护一个变量;

纯虚函数:
    virtual function that is required to be implemented by a derived class if the derived class is not abstract. 是一个为了强制继承者必须实现的语法特性

虚继承:  
    将自己的成员变量直接拷贝到派生类(也就是上面菱形继承所说的问题)

参考:  
    https://pabloariasal.github.io/2017/06/10/understanding-virtual-tables/

#### Section II.

#### 补充
新内容移动到universe_practice
