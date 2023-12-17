# Go 语言

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Go 语言](#go-语言)
  - [I. 简介](#i-简介)
  - [II. 基础语法](#ii-基础语法)
  - [III. 语言深入](#iii-语言深入)
    - [1. 协程和 channel](#1-协程和-channel)
  - [IV. 泛型编程](#iv-泛型编程)
  - [V. 反射](#v-反射)

<!-- /code_chunk_output -->

gc 具有内存清理、并发和异步、性能好、简洁特点

## I. 简介

- go 语言层面是类 c 风格, 但是底层汇编和二进制层面采用 plan9 汇编语法, 因此二进制层面和 c 语言是完全不同的, 因此代码分析不能采用传统的方法

- go 具有指针,但指针删去了运算操作增加了一定的智能化, 在需要的地方会自动传递指针或者值

- go 的内存分配策略编译器会根据情况自动选择用堆内存和栈内存, 因此是不能过于武断的下结论的

- go 是允许函数多返回值, 实现的方式是把返回值和参数一同入栈

## II. 基础语法

- 注释

单行注释: //

多行注释: /\* \*/

- 数据类型

种类(类似 c++): int, string, bool, float, complex, rune, slice, array, struct, interface, map, func, pointer, interface, channel

- 变量定义

```go
// 法一: 仅定义
var n1,n2,n3 string
// 法二: 定义并初始化
var name 类型 = 36
var name = 12
name := "嘻嘻哈哈"
// 法三: 批量定义
var (
  n1 = "1"
  n2 = 12
)
```

go 内变量定义后不使用会报错
全部变量不能使用 name:="haha"方式声明

- 常量

加一个 const 不能修改，声明的时候必须加值

```go
const age int = 98

const age = 98
```

iota 用于枚举, 累曾(从 0 开始)

- 输入输出

采用 fmt 包进行输入输出

输入函数：

fmt.Scan :等待输入所有值
fmt.Scanln ：等待回车，不必输入全部的值
fmt.Scanf ：和 c 一样

```go
var a,b int
count,err = fmt.Scan(&a,&b) //输入信息
// count：输入个数
// err：错误类型
```

输出函数:

fmt.Println()
fmt.Printf()
result:=fmt.Sprintf("字符串",age)

```go
count := 12
fmt.Println("xixihaha", 12) // 输出
fmt.Printf("%s", count) // 格式化输出

result := fmt.Sprintf("字符串%d",age) // 字符串格式化
```

- 条件语句

switch 语句:

```go
switch age{
​	case a:
​		fmt.Println("a")
​	case b:
​	default:
}
```

switch 的后面不用加 break, 并且也不必用{}包裹
if 语句

- 循环语句

```go
// 法一: 传统for循环
for i:=1; i<10; i+=3 {
    fmt.Println("kaishi")
}
// 法二: 遍历数组, map
mp := make(map[string]interface{}, 0)
for k,v := range mp { // 遍历map
}
ar := make([]string, 0)
for index,v := range ar { // 遍历数组
}
// 法三: 处理信号
for { // 是一个死循环, 一般处理channel
    select {
        case <- a:
        case <- b:
        default:
        break;
    }
}
```

continue,和 break 关键字和 c 语言一样

## III. 语言深入

### 1. 协程和 channel

通过 go 关键字执行的函数

## IV. 泛型编程

## V. 反射

[参考文章](https://draveness.me/golang/docs/part2-foundation/ch04-basic/golang-reflect/)
