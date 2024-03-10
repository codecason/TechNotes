#### 内存管理


#### 2024

- install perf first
~~~
perf record -o my_trace.data <your-command-or-program>
timestamp=$(date +"%Y%m%d%H%M%S")
perf script -i my_trace.data | stackcollapse-perf.pl | flamegraph.pl > ../${timestamp}.svg
~~~

### C++ 分析题目

~~~
string s;
s = "a" + b + "c"; // 用到了几次拷贝
s = "a" + b + std::move(get_string(1)); // 这里呢
s = "a" + b + std::move(new string("")); // 这里呢?
make_shared<string>(get_string(1)); // 这里是否有内存泄漏?

for (auto y: vector<string> v) { // 这里有拷贝吗?; 有

}

3.
vector<string> v;
v = otherv; // 这里有逐个拷贝吗? 还是用了operator=执行逐个复制?

4.constexpr
// 用于编译时求值的

5.
const里可以使用mutable

6.
POD类型，RAII模型
RAII stands for "Resource Acquisition Is Initialization." 
RTTI stands for "Run-Time Type Information."

https://zhuanlan.zhihu.com/p/593044308 7-10
7.

类的大小为1的补丁：

class T {};
class T {};
void Demo() {
  T arr[10];
  sizeof(arr); // 0
  T *p = arr + 5;
  // 此时p==arr
  p++; // ++其实无效
}
发现了吗？假如T的大小是0，那么T指针的偏移量就永远是0，T类型的数组大小也将是0，而如果它成为了一个成员的话，问题会更严重：

struct Test {
  T t;
  int a;
};
// t和a首地址相同
由于T是0大小，那么此时Test结构体中，t和a就会在同一首地址。所以，为了避免这种0长的问题，编译器会针对于空类自动补一个字节的大小，也就是说其实sizeof(T)是1，而不是0。

8.
私有继承是一种组合

虚函数表指针在类成员的最后

9.
explicit关键字避免隐式构造

~~~

~~~
functor
~~~

~~~
网站 Compiler Explorer 可以查看编译优化结果
引擎 compiler-explorer

模板工具 C++ Insights
vcpkg包管理非常好用

~~~

