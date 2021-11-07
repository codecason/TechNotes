### 前置知识
C++11的一些特性:
using

decltype auto

funciton, lambda 表达式, tuple

double free  


### CH4. boost工具

ignore_unused

optional: 提供了无效值这个语义, 可以包装任意类型, 利用两个值, 一个为有效标志值, 一个为正式

由于STL容器的初始化,多次push值在原生的用法下显得繁琐,因此产生了repeat,list_inserter,map_list_of,tuple_list_of的类或方法

#### 4.7 exception
由于C++标准里针对exception类型没有通用错误类型,
为了容纳信息要写大量相似的代码,造成了编码的负担

boost里增加了一些错误信息的追加操作,以及打印错误信息的接口,
在外部代码侧继承标准exception,即能用该exception使用错误信息

线程间传递异常

#### 4.8 uuid
~~~c++
#include<boost/uuid/uuid.hpp>
#include<boost/uuid/uuid_generators.hpp>
#include<boost/uuid/uuid_io.hpp>

~~~


#### 4.10 utility

BOOST_BINARY  
BOOST_CURRENT_FUNCTION  

注: 看起来并没有什么用...就是来凑篇幅的,要用函数名原先的宏其实也够用了,顶多就是转成字符串了


### CH5. 字符串与文本处理

lexical_cast


### CH6. 正确性与测试

### CH7. 容器与数据结构
