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

####
rvalue举例:
~~~C++
...
    void doWork()&&;
...

Widget makeWidget(); // function

makeWidget().doWork();  // rvalue call doWork;
~~~

