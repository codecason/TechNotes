### Chapter 1. 类型推导

type deduction 类型推导  

reference: T&
~~~C++
template<typename T>
void f(T& param);
~~~

universal reference: T&&
~~~C++
template<typename T>
void f(T&& param);
~~~
如果param是lvalue的int,则解析得到T为int&;如果param是rvalue,则T为int&&


pass by value (copy of value)

不继承const属性
~~~C++
template<typename T>
void f(T param);
~~~

4. 
array-to-pointer decay rule 退化规则
array可以在如下template中被真正的推导,即T=array
~~~C++
void f(T& param)
~~~

这个的作用是可以声明带大小的数组参数
~~~ C++
template<typename T, std::size_t N>
constexpr size_t arraySize(T (&)N)noexcept
{
    return N;
}
~~~

5.  

function types decay to function pointers rule
函数退化规则

函数类型可以被推导为ptr-to-func和ref-to-func  
ptr-to-func
~~~C++

template<typename T>
void f1(T someFunc);
~~~


#### Understand auto type deduction
auto 类型
auto x = 1;

~~~C++
// C++11 初始化

int x3 = {27};
~~~

auto可以默认识别initializer_list<T>, 但是template不行
即 auto x = {11, 23, 9};有效

而
~~~C++
template<typename T>
void f(T param);
f({11,23,9});
~~~
无法编译

C++ 14里对lambda表达式的模板类型推导

~~~C++
std::vector<int> V;
auto resetV = [&v](const auto& newValue) {v = newValue;}

~~~

auto 类型推导和template 类型推导相似,  
但是auto在初始化的时候会把{}识别为std::initializer_list;  
而lambda参数和返回值中无法把{}识别为该类型,因为它对应的是template类型推导  
(这可能是因为语义过于二义)

Item 3.  
decltype 是什么东西?
decltype(Point::x)可以获取参数的类型


#### Compiler Diagnostics


### Chapter 2 AUTO
Item 5. Prefer auto to function
C++11模板里的function对象用来存储任何可调用对象,包括函数
和闭包(Closure)

如
~~~C++
function<bool(int, int)>
deferUPless = [](int p1, int p2) {
    return p1 < p2;
};
~~~

但是会比auto占用更多的内存

auto的优点:  
    可以方便地切换类型,而且在一些情况下修改类型之后不必重构  
    表示函数型类型的时候占用更小内存

auto的缺点:
    在没有IDE的情况下类型可能没办法直接看出来

type inference是什么?

- Item 6. Use the explicitly typed initializer idiom when
auto deduces undesired types.

~~~C++
vector<bool> features(5);
bool highPriority = features(w)[4];
// warning ! highPriority的类型不是bool,而是vector<bool>::reference
auto highPriority = features(w)[4];

~~~

user proxy class type may violate the rules of standard library.

- Item 7. Distinguish between () and {} when creating
objects.

- Item 8.  Prefer nullptr to 0 and NULL.

- Item 9. Prefer alias declarations to typedefs.

~~~C++
using UPtrMap = unique_ptr<map<int, int>>;

// instead of 
typedef unique_ptr<map<int, int>> UPtrMap;

~~~

~~~C++

template<typename T>
struct MyAllocList {
    typedef std::list<T> type;
};

~~~

- Item 10. Prefer scoped enums to unscoped enums

~~~C++

enum class Color {black, white, red};

// instead of
enum Color {black, white, red};

// 避免全局名称被污染了
~~~

-  Item 11: Prefer deleted functions to private undefined
ones.

~~~C++
template<>
void processPointer<char>(char*) = delete;
// reason: can cover the case in which
// the function has been defined but params are different
~~~


- Item 12. Declare overriding functions override.

在函数最后使用override关键字, 避免重写错误


- Item 13. Prefer const_iterators to iterators

- Item 14. Declare functions noexcept if they won't emit exceptions

~~~c++

~~~
在编译阶段强制约束一个函数必须是noexcept的,防止一些场景(如stl vector的push_back操作执行move优化)下
使用了可能导致except的函数; 另外是为了优化性能,这样编译器不会对其进行插入异常处理代码的操作

- Item 15. Use constexpr whenever possible
~~~c++
constexpr
int pow(int base, int exp) noexcept
{

}

constexpr auto numConds = 5;
std::array<int, pow(3, numConds)> result;
~~~

- Item 16. Make const member functions thread safe
~~~c++
class Polynomial {
public:
    using RootsType = std::vector<double>;
    RootsType roots() const
    {
        std::lock_guard<std::mutex> g(m);
        if (!rootsAreValid) {
            rootsAreValid = true;
        }
        // ...
        return rootVals;
    }
private:
    mutable std::mutex m;
    mutable bool rootsAreValid{false};
    mutable RootsType rootVals{};
};
~~~
atomic 关键字的用法和禁忌

- Item 17. Understand special member function generation
~~~c++
class Base {
public:
    virtual ~Base() = default; // make dtor virtual
    Base(Base&&) = default; // support moving
    Base& operator=(Base&&) = default;
    Base(const Base&) = default; // support copying
    Base& operator=(const Base&) = default;
}
~~~


### Chapter 3  Smart Pointers
raw pointer and smart pointers

~~~C++

std::auto_ptr

std::weak_ptr
std::unique_ptr
std::shared_ptr
~~~

pitfall 陷阱
- Item 18: Use std::unique_ptr for exclusive-ownership resource management.

- Item 19: Use std::shared_ptr for shared-ownership resource management.

shared_ptr<T> = Ptr to T (T Object) + Ptr to Control Block (
    Reference Count, Weak Count, custom deleter, allocator, etc)

make_shared 会创建一个control block, 并返回对应的shared_ptr

引用计数器和对象不在一起
- Item 20: Use std::weak_ptr for shared-ptr, like pointers that dangle.

- Item 21. Prefer std::make_unique and std::make_shared to direct use of new.

减少new的重复代码
~~~C++
auto spw1(std:make_shared<Widget>());

std::shared_ptr<Widget> spw2(new Widget);

~~~

处理exception更加安全, 在初始化的时候如果用new; 可能会因为一个对象初始化的参数顺序不确定(取决于编译器), 抛出异常, 指针未释放, 导致资源泄露

但是: make_shared不支持自定义deleter, 所以make_shared不一定要用

效率问题:

~~~C++
// version 1
class ReallyBigType {...}
auto pBigObj = std::make_shared<ReallyBigType>();

// version 2
std::shared_ptr<ReallyBigType> pBigObj(new ReallyBigType)
~~~

- Item 22. When using the Pimpl Idiom, define special member functions in the implementation file.
对于类成员里的其他类的unique_ptr, 在头文件里要增加成员函数(析构函数, ), 在实现文件里增加实现 (???)

只能用在unique_ptr, 不能用在shared_ptr

### Chapter 5. Rvalue References, Move Semantics, and Perfect Forwarding
- Item 23. Understand std::move and std::forward
~~~c++
对于
void foo(A a) {
  // ...
}
void func(A&& a) {
  // ...
  foo(a);
}

// 上面的代码对于a, 会执行一次拷贝构造
// 此时我们可以使用 std::forward<T>() 这个函数. std::forward 与 std::move 的区别是，move 会无条件的将一个参数转换成右值, 而 forward 则会保留参数的左右值类型. 因此上面例子中 func 的 forward 版本可以写为

void func(A&& a) 
{
    // ...
    foo(std::forward<A>(a)); // 将参数 a 依照类型 A 进行转发
}
~~~

移动语义的本质
~~~c++
template<typename _Tp>
  constexpr typename std::remove_reference<_Tp>::type&&
  move(_Tp&& __t) noexcept
  { return static_cast<typename std::remove_reference<_Tp>::type&&>(__t); }
~~~

- Item 24. Distinguish universal references from rvalue references.

区分universal reference和右值引用  

~~~C++
1. 模板参数中的参数是T&&时是universal reference;
template<typename T>
void f(T&& param);
但是如果是const T&&, 则是rvalue reference  
2. 如果某个值不需要type deduction,那么是rvalue reference
template<class T, class Allocator = allocator<T>>
class vector {
public:
	void push_back(T&& x);
	// ...
};

但是有type deduction, 也不一定是rvalue reference,形式需要是跟T直接相关的类型推导,
而不能是
template<typename T>
void f(vector<T>&& params)这样params的类型推导(当f被调用时,T被自动推导,除非T已经显式声明)  


3.

~~~

即使形式上是右值引用, 也可能是普通的左值引用

- Item 25. Use std::move on rvalue references, std::forward on universal references.

- Item 26. Avoid overloading on universal references.

- Item 27. Familiarize yourself with alternatives to overloading on universal references.

- Item 28: Understand reference collapsing.
引用省略

不支持编译reference to reference, 但是支持根据单个reference的写法表示出两个reference

- Item 29: Assume that move operations are not present, not cheap, and not used.

- Item 30: Familiarize yourself with perfect forwarding failure cases.

### Chapter 7. The Concurrency API
- Item 35. Prefere task-based programming to thread-based.
~~~c++

int doAsyncWork();
std::thread t(doAsyncWork);
auto fut = std::async(doAsyncWork); // 这个比线程的写法好
task-based的程序

~~~

State-of-the-art thread schedulers employ system-wide thread pools to avoid over‐
subscription, and they improve load balancing across hardware cores through workstealing algorithms.

thread-schedulers: 线程调度器  通过work-stealing算法  实现

- Item 36: Specify std::launch::async if asynchronicity is essential.
如果是异步的, 用async显式声明
~~~c++
auto fut2 = std::async(std::launch::async | // run f either
                       std::launch::deferred, // async or
                       f);
~~~
std::launch::async:   
std::launch::deferred: will terminate when wait or get is called.  

??? 存疑

- Item 37: Make std::threads unjoinable on all paths.

joinable: 可运行或正在运行的线程  
unjoinable: 不可join的线程  

joinable的线程
thread.detach方法
~~~c++

class ThreadRAII {
public:
    enum class DtorAction { join, detach };
    ThreadRAII(std::thread&& t, DtorAction a): action(a), t(std::move(t)) {}

    ~ThreadRAII()
    {
        if (t.joinable()) {
            if (action == DtorAction::join) {
                t.join();
            } else {
                t.detach();
            }
        }
    }

};

~~~

- Item 38: Be aware of varying thread handle destructor behavior.
Future destructors 只会析构future变量自己的数据


### 脚注
instantiate  
TMP 模板元编程  
traits
std::remove_const<T>::type  
std::remove_reference<T>::type  
std::add_lvalue_reference<T>::type  
std::underlying_type<T>::type

static_cast
noexcept

decltype

std::forward<T>(params...)

std::forward<decltype(func)>(func)

perfect forward: parentheses
如何知道一个指针是dangling的?

pimpl: Pointer to implementation

std::async

####
rvalue举例:
~~~C++
...
    void doWork()&&;
...

Widget makeWidget(); // function

makeWidget().doWork();  // rvalue call doWork;
~~~

