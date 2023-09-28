# Csharp doc

c\# 是一门面向对象, 运行在 .net framework 或 .net core 平台的编程语言, 包管理工具 NuGet

.net 统一的开发者平台

安全、稳定、简单、优雅的编程语言

- [Csharp doc](#csharp-doc)
  - [I. 基本语法](#i-基本语法)
  - [高级用法](#高级用法)
    - [1. 异常](#1-异常)
    - [2. 容器](#2-容器)

## I. 基本语法

c# 和 java 不同的是文件不可以不同于类名  
任何 c#的第一条语句都是 using system;

- 常量

静态常量 const: 编译时确定

动态常量 readonly: 可以在构造函数内使用

- 注释

```csharp
// 单行注释
/* 多行注释
*/
/// 文档注释
```

- 数据类型

| 类型     | 说明                |
| -------- | ------------------- |
| 整形     | byte,short,int,long |
| 浮点型   | float,double        |
| 十进制型 | decimal             |
| 布尔类型 | bool                |
| 字符类型 | string,char         |
| 空类型   | null                |

decimal 不是基本类型, 精度要比 double 高, 数字要后缀 M, 不能浮点类型互转

- 数组使用

数组声明需要使用 new 关键字  
声明数组时, 可以使用 {} 进行初始化

```csharp
int[] ints = new int[4];
int[] ints1 = new int[]{1,2,3,4};
int[] ints2;
```

- 控制语句

if, switch, for, while

> switch 中的 case 语句块需要用 {} 隔绝变量声明

- 函数

c#中函数名采用大驼峰方式命名

```csharp
public string Add() {
  this.num++;
}
```

> 参数修饰符:
> 参数修饰符需要在函数声明和函数调用时均加上
>
> 1. 无修饰符: 表示参数将会按值进行传递
> 2. out:参数将由函数进行赋值, 按引用进行传递, 如果函数没有赋值将出现编译错误
> 3. ref:由调用者赋初始值, 可以由函数内修改
> 4. params: 变长参数

可变参数

```csharp
public int sum(params int[] nums) {
  int ans=0;
    foreach(int v in nums) {
        ans+=v;
    }
    return ans;
}
```

- class

判断类 a 是否继承于类 b

```csharp
a is b
```

属性一般声明:

```csharp
class Person{
    // vs2022 使用小技巧, 输入prop双击tab
    public int Age {get{}; set{}};
}
```

> 访问修饰符
> public: 共有的, 所有类都可以访问
> private: 私有的, 只有自身可以访问
> protected: 保护的, 自己和继承的类可以访问
> internal: 内部的, 仅限于本项目可以访问
> protected internal: 内部保护访问

partal 关键字:
可以将一个类拆分成很多个部分, 最终的类是由这些部分组合到一起形成的

- 运算符重载

```csharp
public static X operator+(X x) {
  return X;
}
```

## 高级用法

### 1. 异常

### 2. 容器

- ArrayList

c# 中 ArrayList 底层使用 Object 类型对数据, 因此可以存放所有类型数据, 但是不安全, 效率低下

```csharp
ArrayList al = new ArrayList();
al.Add(123);
al.Add("哈哈");
al.Insert(1, false);
al.remove(123);
```

- List 集合

```csharp
List l = new List<int>();
```

- Dictionary 字典

```csharp
Dictionary<int, string> dict = new Dictionary<int, string>();
dict.Add(1,"a");
```
