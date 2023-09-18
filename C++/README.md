# C++ 编程

- [C++ 编程](#c-编程)
  - [I. 编译期强化](#i-编译期强化)
  - [II. 运行期强化](#ii-运行期强化)
  - [III 智能指针](#iii-智能指针)
  - [IV. 正则表达式](#iv-正则表达式)
  - [V. 并发编程](#v-并发编程)
  - [VI. 模板编程](#vi-模板编程)
  - [VII. 标准库学习](#vii-标准库学习)
  - [VIII. boost 库学习](#viii-boost-库学习)

如果能重来，绝对不再学 C,C++

按照现代 c++编程语言的特性进行书写(c++20 及其以后)

语言本身所具有的特性

## I. 编译期强化

指在编译时期所体现出来的特性

- if-switch 变量初始化

```cpp
int sum() {return 10;}
if (auto x = sum(); x>0) { // 作用域, if条件内

}

switch (auto x=sum();x) {

}
```

- 常量表达式

> constexpr

作用: 1. 如果编译器可以得出的结果就会直接在编译期进行计算, 如果不能计算的话会放到运行时

- 原始字符串字面量

里面的所有内容都会当做原始字符, 没有转义

```c++
const char* str = R"("Hello, world!")";
```

- 自定义字面量

通过重载""后缀运算符实现, 支持的格式

```cpp
// 重载字符
std::string operator""_abc(char);
// 重载字符创
std::string operator""_abc(const char *, size_t);
// 重载整数
std::string operator""_abc(unsigned long long);
// 重载浮点数
std::string operator""_abc(long double);
```

- 自动类型推断

> auto : 自动推断类型
> decltype : 推断值的类型

## II. 运行期强化

程序运行时期所体现出来的特性

- lambda 表达式

格式:

```cpp
// []() ->返回类型 {}
// 变量捕获: []
//    = 按值捕获: 只在声明时捕获一次
//    & 引用捕获: 按引用捕获
//    既可以是左值, 也可以是右值
// 传参: ()
// 返回类型:
```

- function 函数包装

头文件: \<functional\>
可以封装任何可调用对象

```cpp
#include <iostream>
#include <functional>
using namespace std;

int sum(int a, int b) {
    return a + b;
}
int sub(int a, int b) {
    return a - b;
}

int main() {
    cout << sum(3, 4) << endl;
    cout << sub(2, 3) << endl;
    function<int(int, int)> delegate;
    delegate = sum;
    cout << delegate(3, 4) << endl;
    cout << delegate(2, 3) << endl;
    return 0;
}
```

```cpp
int sum(int a,int b, int c) {return a+b+c};
int main() {
  function<int(int,int,int)> f1 = sum;
  auto f2 = std::bind(f1, 2, std::placeholder::_2, 5);
  // 相当于调用了 sum(2,14,5);
  f2(14);
}
```

- 右值引用和移动语义

右值引用和左值引用可以看做是完全相关的内容

- 赋值规则:

> 左值引用 $\neq$ 右值
> 右值引用 $\neq$ 左值
> 常量左值引用 = 右值
> 常量右值引用 $\neq$ 左值

- 引用塌缩:

引用符号 && 可以成对抵消掉

## III 智能指针

智能指针所在头文件 \<memory\>

智能指针采用 RAII 思想, 在变量产生时获取资源, 变量销毁是自动释放资源

- shared_ptr

采用引用计数方法:

所设计方法有

> .use_count(): 获取当前指针的引用计数个数
> .reset(): 减少一个当前指针的引用计数
> .get(): 获取原始指针, 不会增加一引用计数
> auto newPoint = oldPoint; 通过赋值智能指针, 引用计数会自动增加 1

```cpp
#include <memory>
int main() {
  // 智能指针获取两种方法:
  // 1. 通过构造函数获取 (参数是 new 获取的指针)
  std::shared_ptr<int> point1(new int(10));
  // 2. 通过make_shared 获取 (参数是构造函数的方法, 内部自动调用new);
  std::shared_ptr<int> point2 = std::make_shared<int>(10);
  auto point3 = point2;
  std::cout << point2.use_count() << std::endl;
  // 输出: 2
  std::cout << point2.reset() << std::endl;
  // 输出: 1
  int *p = point2.get();
  return 0;
}
```

- unique_ptr

唯一指针, 该指针同时只能由一个变量获取, 传递的话通过 std::move

```cpp
#include <memory>
int main() {
  std::unique_ptr<int> point1 = std::unique_ptr<int>(10);
  // 错误, 不能赋值
  std::unique_ptr<int> point2 = point1;
  // 可以, 传递后point1 为nullptr
  auto point3 = std::move(point1);
}
```

- weak_ptr

用于处理类间相互相互引用导致的锁

## IV. 正则表达式

头文件 \<regex\>

std::regex_match : 匹配和查找

```cpp
#include <regex>
int main() {
  std::string fnames[] = {"foo.txt", "bar.txt", "test", "a0.txt", "AAA.txt"};
  // 在 C++ 中 \ 会被作为字符串内的转义符，为使 \. 作为正则表达式传递进去生效，需要对 \ 进行二次转义，从而有 \\.
  std::regex txt_regex("[a-z]+\\.txt");
  for (const auto &fname: fnames)
    std::cout << fname << ": " << std::regex_match(fname, txt_regex) << std::endl;

  std::regex base_regex("([a-z]+)\\.txt");
  std::smatch base_match;
  for(const auto &fname: fnames) {
      if (std::regex_match(fname, base_match, base_regex)) {
        // std::smatch 的第一个元素匹配整个字符串
        // std::smatch 的第二个元素匹配了第一个括号表达式
        if (base_match.size() == 2) {
        std::string base = base_match[1].str();
        std::cout << "sub-match[0]: " << base_match[0].str() << std::endl;
        std::cout << fname << " sub-match[1]: " << base << std::endl;
      }
  }
}
```

## V. 并发编程

头文件 \<thread\>

```cpp
#include <iostream>
#include <thread>
#include <unistd.h>
using namespace std;

int main() {
    std::ios::sync_with_stdio(false);
    cin.tie(0);
    {
        cout << "作用域内" << endl;
        thread([]() { cout << "t1" << endl; }).detach();
        sleep(2);
    }
    sleep(1);
    thread t2([]() { cout << "t2" << endl; });
    cout << "main" << endl;
    t2.join();
    return 0;
}
```

- 互斥量

```cpp
#include <thread>
#include <mutex>
int sum = 0;
void func(int v) {
  std::mutex m;
  std::lock_guard<std::mutex> lg(m); // 自动 .lock
  sum += v;
  // 自动解锁 .unlock();
}
void func2(int v) {
  std::mutex m;
  std::unique_lock<std::mutex> ug(m); // 自动 .lock
  sum += v;
  ug.unlock();
  // 可以手动解锁
  ug.lock();
  sum +=v;
  // 自动解锁 .unlock();
}
```

- 期物

```cpp
#include <thread>
#include <future>
int func(int v) {
  return v++;
}
int main() {
  std::package_task<int(int)> task(func);
  std::future result = task.get_future();
  std::thread(std::move(task), 12).detack();
  result.wait();
  cout << result.get() << endl;
}
```

## VI. 模板编程

- 变长参数模板

1. 采用递归方法

```cpp
template <typename R, typename... T> R sum(R v1, T... args) {}
templaet <typename R> R sum(R v) {return v;}
```

2. 变参展开

```cpp
template <typename... T> int count(T... args) {
  return sizeof...(args);
}
```

3. 折叠表达式

| 类型       | 样式        | 展开                   |
| ---------- | ----------- | ---------------------- |
| 一元左折叠 | (...+t)     | ((t1+t2)+t3)+...tn)    |
| 一元右折叠 | (t+...)     | (t1 + ... (tn-1 + tn)) |
| 二元左折叠 | (x + ... t) | ((x+t1)+...tn)         |
| 二元右折叠 | (t+...+x)   | ((t1+t2) +...x)        |

4. 初始化列表
   略

## VII. 标准库学习

- string 学习

c++风格字符串

```c++
std::string str("hello");
```

- 构造函数:
  string(const char \*);
  string(size_t, char);
  string(const char \*,size_t);
  string(const string,size_t pos);
  string(const string,size_t pos,size_t len);
- 获取 c 风格数据接口

```c++
  str.c_str() =str.data(); // 返回c风格的字符串
```

- tuple 学习

元组

```cpp
#include <iostream>
#include <tuple>
#include <variant>
#include <memory>
using namespace std;

template <size_t n, typename... T>
variant<T...> _tuple_index(tuple<T...> t, size_t index) {
    if (index >= sizeof...(T)) {
        throw out_of_range("tuple 下标越界");
    }
    if (index == n) {
        return variant<T...>{in_place_index<n>, get<n>(t)};
    }
    return _tuple_index < n < sizeof...(T) - 1 ? n + 1 : 0 > (t, index);
}

template <typename... T>
variant<T...> tuple_index(tuple<T...> t, size_t index) {
    return _tuple_index<0>(t, index);
}

template <typename T0, typename... T>
ostream &operator<<(ostream &s, variant<T0, T...> const &v) {
    visit([&](auto x) {
        s << x;
    },
          v);
    return s;
}
int main() {
    tuple<int, string, float> s = make_tuple(1, "嘻嘻哈哈", 35.1);
    /* tuple_index(s, 1); */
    cout << tuple_index(s, 1) << endl;
    /* unique_ptr<int> p = make_unique<int>(10); */
    /* int *pp = p.get(); */
    /* cout << *p << *pp << endl; */
    /* cout << p->use_count() << endl; */
    shared_ptr<int> p = make_shared<int>(10);
    cout << p.use_count() << endl;
    return 0;
}
```

解包

```cpp
std::tuple<int,string,double> tp = std::make_tuple(12,"aaa", 3.5);

int a = tp.get<0>();
double  c = tp.get<double>();

std:tie(a, std::ignore, c) = tp;
auto [a, std::ignore, c] = tp;
```

- chrono 学习

MSVC 已经支持 C++20 的所有特性, 但其他不支持

MSVC 直接只用 format

```c++
#include <iostream>
#include <fstream>
#include <cerrno>
#include <chrono>
using namespace std;

int main() {
    chrono::time_point point1 = chrono::system_clock::now();
    cout << point1 << endl;
    cout << chrono::time_point_cast<chrono::seconds>(point1) << endl;
    cout << format("time is: {}\n", chrono::time_point_cast<chrono::seconds>(point1));
    chrono::time_point<chrono::system_clock, chrono::seconds> point2;
    auto result = chrono::parse("2022-07-11 22:34:50", point2);
    // cout << result << endl;
    cout << format("point2: {}\n", point2);
    return 0;
}

```

- GCC 知识 fmt 库替代

```c++
#include <fmt/core.h>
#include <fmt/chrono.h>
#include <chrono>
#include <iostream>
using namespace std;

int main() {
    chrono::time_point point1 = chrono::system_clock::now();
    cout << fmt::format("point1: {}\n", point1);
    cout << fmt::format("point1-minute: {}\n",
                        chrono::time_point_cast<chrono::minutes>(point1));
    fmt::print("{:%Y-%m-%d %H:%M}", point1);
    // cout << point1 << endl;
    cout << "-----" << endl;
    chrono::time_point<chrono::system_clock, chrono::seconds> point2;
    auto result = chrono::parse("2022-07-11 22:34:50", point2);
    return 0;
}
```

## VIII. boost 库学习

由 boost 社区进行开发、维护的免费、可移植 c++程序库

- asio 库学习

异步 io 库

- beast 库学习

对 asio 进行一层封装的网络编程库

:smile:
扩展阅读:
[windows 编程](windows.md)
[linux 编程](linux.md)
[扩展知识](entension.md)
