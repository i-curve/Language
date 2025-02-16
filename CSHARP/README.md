# Csharp doc

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Csharp doc](#csharp-doc)
  - [I. 基本语法](#i-基本语法)
  - [II. 高级用法](#ii-高级用法)
    - [1. 异常](#1-异常)
    - [2. 容器](#2-容器)
    - [3. Linq 语法](#3-linq-语法)
    - [4. 异步](#4-异步)
  - [III. 反射](#iii-反射)

<!-- /code_chunk_output -->

c\# 是一门面向对象, 运行在 .net framework 或 .net core 平台的编程语言, 包管理工具 NuGet

.net 统一的开发者平台

安全、稳定、简单、优雅的编程语言

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
可以将一个类拆分成很多个部分, 最终的类是由这些部分组合到一起形成的,如何 maui 里面页面部分是有 xaml 代码在编译时生成的, 和后面逻辑控制代码一起组成页面

- 运算符重载

```csharp
public static X operator+(X x) {
  return X;
}
```

## II. 高级用法

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

### 3. Linq 语法

Linq 是一种对一组数据进行处理操作的语法, IEnumerable 是一个接口, 可以通过 LINQ 语法对 IEnumerable 进行操作, 可以对数据进行过滤, 排序, 分组等操作, 提供了对组数据的扩展语法

- cs 委托

本质是一个函数变量, 可以把一个函数赋值给这个变量, 然后进行调用

```csharp
// 定以一个委托变量
delegate int aaa(int a, int b);
// 此时 aaa 就可以接受这种类型参数和返回值的函数

// 进行调用
// 1. 类似正常的函数调用方式
aaa(12, 13);
// 2. 通过委托调用
aaa.Invoke(12, 13);
```

- 匿名函数

```csharp
aaa a = (int a, int b) => {
  return a + b;
}

// 如果函数体只有一行, 可以省略大括号和return语句
aaa a = (int a, int b) => a + b;
// 如果左侧的变量类型已定, 那么匿名函数中的变量类型可以省略
aaa a = (a, b) => a + b;
```

- Linq 居有的内容

Where: 对数组进行过滤
Select: 对数组进行映射
Any: 判断数组中是否存在满足条件的元素
All: 判断数组中是否全部满足条件

FirstOrDefault: 获取数组中第一个满足条件的元素, 如果没有满足条件的元素, 则返回对应类型的默认值或者第二个参数设置的值
First: 获取数组中第一个满足条件的元素, 如果没有满足条件的元素, 则抛出异常
Single: 获取数组中唯一一个满足条件的元素, 如果没有满足条件或者多个满足条件的元素, 抛出异常
SingleOrDefault: 获取数组中唯一一个满足条件的元素, 如果没有满足条件, 则返回对应类型的默认值或者第二个参数设置的值, 如果有多个满足条件的就抛出异常

Orderby: 对数组进行排序升序
OrderbyDescending: 对数组进行排序降序
ThenBy: 对数组进行排序升序, 如果第一个排序条件相同, 则按照第二个排序条件进行排序
ThenByDescending: 对数组进行排序降序, 如果第一个排序条件相同, 则按照第二个排序条件进行排序

GroupBy: 对数组进行分组, 返回的数据为一个元素都是一个 IGrouping 类型, 包含了键 Key 和改分组的数组

### 4. 异步

c# 中的异步编程, 是指在函数中调用一个耗时操作, 而不阻塞线程, 而在函数返回时, 继续执行后续操作

异步居有传染性, 一旦一个方法内调用了某一个异步方法, 那么异步调用就会不断传递

- 异步编程

```csharp
// 新线程中去执行某一个方法
await Task.Run(() => {})
```

异步中执行的函数并不会在新的线程中去执行, 除非你明确指定在新线程中执行

- 异步中等待采用 await Task.Delay(毫秒方法)

Thread.Sleep(毫秒): 该方式会阻塞线程, 在异步中不要去用

```csharp
// 等待1秒
await Task.Delay(1000);
```

## III. 反射

{% raw %}

c# 中的反射是以.dll 文件为组成单位(程序集,Assembly), 在获取到程序集之后就可以或许程序集里面的类,并进而进行操作

程序集中的类对应 Type 类型  
构造函数对应类型 ConstructorInfo  
类中的方法对应类型 MethodInfo(Method)  
字段对应 FieldInfo(Field)  
属性对应 PropertyInfo(Property)

**note**: c#中字段和属性是两种不同的性质, 需要区别对待

c#中可以通过传递 BindingFlags.[Default|Public|NonPublic] 等属性来获取私有成员等一些列内容

```c#
// 通过文件获取程序
Assembly.Load() // 通过文件名, 不带后缀
Assembly.LoadFile() // 全路径
Assembly.LoadFrom() // 文件名

// 获取当前程序的程序集
Assembly assembly = Assembly.GetExecutingAssembly();
```

获取 Assembly 中的类

```c#
// 遍历所有的类
foreach(Type classTyle in assembly.GetTypes()) {
    Console.WriteLine($"class name: {classType.Name}");
}
// 获取某个特定的类型, 需要通过命名空间.名字进行获取
Type userType = assembly.GetType('Assembly.User');
```

操作类中的字段 Field

```c#
Console.WriteLine("before change user:");
User user = new User(1, "i-curve", 15);
Console.WriteLine(user);
FieldInfo? userId = userClass.GetField("id");
userId.SetValue(user, 2);
FieldInfo? messageField = userClass.GetField("message", BindingFlags.Instance | BindingFlags.NonPublic);
messageField.SetValue(user, "a new message");
Console.WriteLine("after change user:");
Console.WriteLine(user);
```

操作类中方法 Method,Property

```c#
foreach (MethodInfo method in
         userClass.GetMethods(BindingFlags.Instance | BindingFlags.Public))
{
    Console.WriteLine($"methods of user class have: {method.Name}");
}
foreach (PropertyInfo property in userClass.GetProperties())
{
    Console.WriteLine($"property: {property.Name}");
}
```

操作类中属性 Property

c# 中的反射是真泛型, 是可以获取泛型信息的反射, 在真正使用时是需要通过 MakeGeneric...() 给泛型赋值真正的类型信息后才可以使用的

```c#
MethodInfo printType = userClass.GetMethod("PrintType").MakeGenericMethod(typeof(int));
printType.Invoke(user, new object[] { 12 });
```

user 信息:

```c#
namespace AssemblyDemo;

public class User(int id, string username, int age)
{
    public int id = id;
    public string username = username;
    public int age = age;
    protected bool pro = false;
    private string message = "this is a default message field";

    public override string ToString()
    {
        return $"{{id: {id}, username: {username}, age: {age}, pro: {pro}, message: {message}}}";
    }

    public void PrintHello()
    {
        Console.WriteLine("hello world!");
    }

    public void PrintType<T>(T data)
    {
        Console.WriteLine($"the data is: {data}");
    }
}
```

{% endraw %}
