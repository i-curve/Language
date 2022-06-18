**命名空间限制了名字的使用范围，增加了约束。防止命名冲突问题。**

命名空间的使用  
1.使用作用域解析运算符(::)

> 如 name 命名空间的变量 s，则使用 name::s

2.使用 using 编译和 using 声明

```cpp
// using 声明
using name::s;
using 声明指在当前作用于内引入该变量，如果有多个会报错
// using 编译
using namespace std;
using // 编译会把命名空间中的所有都会变入到当前作用域内，如果重复会覆盖，不会报错
```

**new 运算符**

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
