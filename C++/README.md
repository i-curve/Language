# C++ 编程

- [C++ 编程](#c-编程)
  - [1. 编译期强化](#1-编译期强化)
    - [常量表达式](#常量表达式)
    - [原始字符串](#原始字符串)
  - [2. 运行期强化](#2-运行期强化)
    - [智能指针](#智能指针)
    - [3. 模板编程](#3-模板编程)
  - [4. 标准库学习](#4-标准库学习)
    - [通用方法](#通用方法)
    - [string 学习](#string-学习)
    - [tuple 学习](#tuple-学习)
  - [5. boost 库学习](#5-boost-库学习)
    - [asio 库学习](#asio-库学习)
    - [beast 库学习](#beast-库学习)

如果能重来，绝对不再学 C,C++

按照现代 c++编程语言的特性进行书写(c++20 及其以后)

语言本身所具有的特性

## 1. 编译期强化

指在编译时期所体现出来的特性

### 常量表达式

> constexpr

### 原始字符串

里面的所有内容都会当做原始字符, 没有转义

```c++
const char* str = R"("Hello, world!")";
```

## 2. 运行期强化

程序运行时期所体现出来的特性

### 智能指针

### 3. 模板编程

## 4. 标准库学习

### 通用方法

### string 学习

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

### tuple 学习

元组

## 5. boost 库学习

由 boost 社区进行开发、维护的免费、可移植 c++程序库

### asio 库学习

异步 io 库

### beast 库学习

对 asio 进行一层封装的网络编程库

:smile:
扩展阅读:
[windows 编程](windows.md)
[linux 编程](linux.md)
[扩展知识](entension.md)
