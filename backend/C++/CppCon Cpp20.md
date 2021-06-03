
#### Four Main Changes in C++20
coroutine  
ranges  
concept  
modules  
#### Example 1
~~~C++
// coroutine
// code in c++14 to iterate and print a sequence
// [i = 0] is **init caputuring**
auto g = [i = 0]() mutable {
    return i++;
};

cout << g() << '\n';
cout << g() << '\n';
cout << g() << '\n';

// in c++20, use coroutine
int f() {
    int i = 0;
    while (True) {
        co_yield i++;
    }
}

auto g = f();
// --------
// generator = promise type + coroutine_handle
// generator 存在stack上

std::coroutine_handle frame 存在heap上

~~~

#### Example 2

c++ 20没有提供generator类型,只有在c++23有提案,要自己实现  
    只能用cppcoro类似的库, **只有在非常简单的场景下才能自己实现一个coroutine**

~~~C++
// generator需要实现的接口
template <typename T>
struct generator {
    struct promise_type;
    using handle_type = std::coroutine_handle<promise_type>;
    handle_type handle;

    struct promise_type {
        // impl...
    };
    generator(promise_type& promise) :
        handle(handle_type::from_promise(promise)) {
    };

    generator(const generator&) = delete;

    generator& operator=(const generator&) = delete;

    generator(generator&& other): handle(other.handle) {
        other.handle = nullptr;
    }

    generator& operator=(generator&& other) {
        if (this != other) {
            handle = other.handle;
            other.handle = nullptr;
        }
        return *this;
    }

    ~generator() {
        if (handle)
            handle.destroy();
    }

    T operator() {
        assert(handle != nullptr);
        handle.resume();
        return handle.resume().current_value;
    }
};

~~~

使用co_await解决回调地狱 (在协程环境下)
~~~C++
async_generator<T> f1() {
    auto u = co_await f2();
    // more code
    co_return u;
}
~~~

### Concepts
#### Example 3
~~~C++
// 在C++20前,要重定义一个特定类型的模板函数,只有一种方式
// CFINAE, std::enable_if
// 在C++20的时候, 如下

template<typename T> requires std::integral<T>
bool is_power_of_2(T i) {
    return i > 0 && (i & (i - 1)) == 0;
}

template<typename T> requires std::floating_point<T>
bool is_power_of_2(T i) {
    int exponent;
    const T mantissa = std::frexp(x, &exponent);
    return mantissa == T(0.5);
}

// 自定义concepts
#include <concepts>
concept arithmetic = std::integral<T> || std::floating_point<T>;

template<typename T>
concept my_number = arithmetic<T> && sizeof(T) <= 8;

~~~

### ranges
#### Example 4

~~~C++
struct User {
    std::string name;
    int age;
};

vector<User> users = {};

int main() {
    std::ranges::sort(users, std::less{}, &User::age);
}


// 在C++20之前,对一个数组做过滤

// 链式ranges的调用, 不用再写两次循环
bool underage(const User& user) {
    return user.age < 18;
}

int main() {
    auto result = users
        | std::views::filter(std::not_fn(underage))
        | std::views::transform([] (const auto& user) {return user.age; });
}

~~~

### modules
#### Example 5
~~~C++
template <typename T>
struct generator {
    // code ...
};

// in c++ 20
export module generator;
template <typename T>
export struct generator {
    // code ...
};

struct helper {
    // code ...
};

~~~
BMI Binary module interface


[CppCon ](https://www.bilibili.com/video/BV1kV411h78u?from=search&seid=368482001852892295)
