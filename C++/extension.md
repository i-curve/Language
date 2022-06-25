# 扩展

- [扩展](#扩展)
  - [一般规范](#一般规范)
  - [运算符优先级](#运算符优先级)
  - [指针扩展](#指针扩展)
  - [命名空间扩展](#命名空间扩展)
  - [new 运算符](#new-运算符)

c++有关的扩展知识

## 一般规范

在头文件中进行变量，函数和类的声明,在其他文件是对类和函数进行实现。

1. 头文件声明时要加上#ifndef #endif
2. 对类方法进行实现要加上作用域解析运算符。
3. 内联函数，直接在声明处定义，外面的话可以加上 incline。
4. 使用 new 的内存便于节省内存空间,但是必须添加析构函数.
5. 只要类方法不修改成员变量，就应该写为 const 方法。

```c++
//构造函数,析构函数
Stock(int a,int b);~Stock();
//运算符重载
void operator*(const Stock)const;
//友元
friend void fun(Stock);
//输出重定向
ostream & operator<<(ostream &os,Stock);
```

```
c++学习途径:动态内存分配
1.动态内存分配
2.复制构造函数:有新对象生成
3.赋值构造函数:对象值的传递
4.静态成员
5.&运算符
```

```c++
//c++学习途径:继承
1.继承的三种方法:public,protected,private
2.类的多态
3.由多态引申出来的虚函数,
4.抽象继承与纯虚函数.
5.构造函数中的成员初始化列表和非构造函数中的
```

```c++
//类的多态
类的多态是指在基类和派生类中,可能存在同样一种方法,但是他们却有不同的实现方式,此时需要在基类和派生类中分别进行定义,这就是多态.
//虚函数
为了在使用指针是也能正确执行目的类的方法,出现了虚函数.
//抽象类及其纯虚函数
抽象类包含了纯虚函数,或者有纯虚函数成员的类,抽象类不能实例化.
```

## 运算符优先级

第一层级(作用域::>..)：() , [] , .(类) , ->(类) ;
第二层级(单目运算符):\*指针,!非,~,;
第三层级(算术运算符>移位):\*,/,+,-;
第四层级(比较>位运算符>逻辑运算符);
第五层级(赋值运算符>,表达式);

## 指针扩展

const 和指针声明常量

```c++
int age=15;
const int *p= age; // 指针是常量
int * const p = age; // 值是常量
/*
语法错误会在声明定义的时候进行检测，如果声明时候成功了，后面就仅仅限量的局部的含义范围。
*/
// 多级指针时会出现符合语法的修改权限错误问题。
```

```c++
//定义：
double* fun(double a,double b);
double* (*p)(double a,double b);//其中p是一个指向fun函数的指针
double* (*p[3])(double a,double b);//p是一个大小为3的值fun函数指针的数组
double* (*(*p)[3])(double a,double b);//p是一个指向
```

## 命名空间扩展

命名空间限制了名字的使用范围，增加了约束。防止命名冲突问题。

用法:

1. 作用域解析运算符 \(::\)

例: 标准库 iostream 的 cout 使用

```c++
std::cout << "Hello World!" << std::endl;
```

2. 命名空间编译和声明

- 声明

```c++
using namespace std;
cout << "Hello World!" << endl;
asio::io_content io_content;
```

- 编译

```c++
namespace asio = boost::asio; // 空间
using tcp = asio::ip::tcp;
```

## new 运算符

c++中 new 是申请动态内存的字，还有一个定位 new 运算符

new 申请的动态内动使用 delete 回收，定位 new 使用的内存不能使用 delete，报错（因为不是动态内存的地址）

```cpp
// 申请单个地址
int *p1 = new int; => int *p1 = new(sizeof(int));
// 申请多个地址
int *p2 = new int[size]; => int *p2 = new(size*sizeof(int));

#赋值时加上{}

回收
#单个地址
delete p1
#数组
delete
```

```cpp
// 定位new运算符
加上<new>头文件
申明时在new后面加上(地址指针)
如：

char buffer[20]
int *p = new (buffer) int[5];
```