# C++ 编程

- [C++ 编程](#c-编程)
  - [语言层级](#语言层级)
    - [1. 编译期强化](#1-编译期强化)
      - [常量表达式](#常量表达式)
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
  - [系统层级](#系统层级)
    - [进程环境](#进程环境)
      - [程序的起始和结束](#程序的起始和结束)
      - [程序存储空间结构](#程序存储空间结构)
      - [环境表和环境变量](#环境表和环境变量)
      - [相关函数](#相关函数)
    - [进程控制](#进程控制)
      - [相关函数](#相关函数-1)

按照现代 c++编程语言的特性进行书写(c++20 及其以后)

## 语言层级

语言本身所具有的特性

### 1. 编译期强化

指在编译时期所体现出来的特性

#### 常量表达式

> constexpr

### 2. 运行期强化

程序运行时期所体现出来的特性

#### 智能指针

### 3. 模板编程

### 4. 标准库学习

#### 通用方法

#### string 学习

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
  str.c_str(); // 包含最后面的 '\0'
  str.data(); // 不包含最后面的 '\0'
  ```

#### tuple 学习

元组

### 5. boost 库学习

由 boost 社区进行开发、维护的免费、可移植 c++程序库

#### asio 库学习

异步 io 库

#### beast 库学习

对 asio 进行一层封装的网络编程库

## 系统层级

程序与系统接口进行交互编程

### 进程环境

#### 程序的起始和结束

正常终止

1. main 函数返回
2. exit 函数返回
3. 最后一个线程从其启动历程返回
4. 最后一个线程调用 pthread_exit

非正常终止

1. 调用 abort 函数
2. 接到信号

```cpp
int atexit(void (*func)(void));
```

#### 程序存储空间结构

代码段(text), 初始化数据段, 未初始化数据段, 堆, 栈

#### 环境表和环境变量

> 每个程序都收到一个环境表, 是一个 c 风格的指针数组

![环境表](../img/environ.png)

> linux 的环境变量是 name=value 形式的一个字符串

#### 相关函数

```cpp
// 1. 获取环境变量
char *getenv(const char *name); // 获取指定名称的环境变量
// 2. 添加环境变量
int putenv(chat *str); // 添加环境变量, 字符串格式 name=value
// 3. 设置环境变量
int setenv(const char *name, const char *value, int overwrite); // 设置环境变量, overwrite=1 覆盖, 0 不覆盖
// 4. 删除环境变量
int unsetenv(const char *name); // 删除环境变量,不存在也不会报错
```

### 进程控制

#### 相关函数

```cpp
// 获取进程信息
// 1. 获取进程号和父进程的进程号
int getpid(void);
int getppid(void);
// 2. 调用进程的用户id,组id
int getuid(void);
int getgid(void);

// 子进程相关
// 3. 创建子进程
pid_t fork(void); // 创建子进程, 父进程内返回创建的子进程ID, 子进程内为0
// 4. 获取子进程终止信号
pid_t wait(int *statloc);
pid_t waitpid(pid_t pid,int *statloc, int options);
```

[扩展知识](entension.md)
