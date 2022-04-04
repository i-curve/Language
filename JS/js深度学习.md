[...返回上一级](../)

# JS 变量基础和类型转换

> 简介:

## 变量类型

1. 基础类型

> number,string,boolean,undefined,null, symbo(es6)

2. 引用类型

> object,function,array

3. 可以通过 typeof 查看数据的类型, 返回的类型是 string

> typeof(null) 得值是 'object', 这是历史遗留问题, 用户代指空对象

4. if 条件用判断为 false 的值有

> 0, "", false, undefined, null, NaN

- NaN 和任何值都不相等,包括自己本身, 只能用 isNaN()函数去判断
- null == undefined: 为 true

## 类型转换

- 隐式类型转换

> 1. \+ 符号会趋向于把类型转换为 string
> 2. \- \* / 符号会趋向于把类型转换为 number
> 3. if 里面会把最终界面转换为 boolean 类型
> 4. 包装类: '123'.length , '123' 是 string 类型对象, 此处包装成了 String()对象

- 显示类型转换

> Number(), String(), Boolean(): 强制把类型转换为相应的类型
>
> ~~undefined~~, ~~null~~: 没有改对应的转换

## 函数

- 箭头函数特性

> this 指向定义时候就确定, 不能该变
>
> 不能使用 new 构造对象
>
> 没有 prototype
>
> 没有 arguments

- 立即执行函数

在定义的时候就执行, 防止变量污染

两种定义方式:

> ( function(){} ){};
>
> ( function(){}() );

---

函数定义:

```js
function test(a, b, c) {
  console.log(test.length); // 形参个数
  console.log(arguments); // 实参数组
}
```

- 函数名字

> 函数名字可以让函数递归的时候使用

- arguments

> 函数实参对象, 可以通过[] 取出实参
>
> test.length: 形参的个数
>
> 函数的实参和形参都有的话会是一个一对一的引用关系

- 闭包: 函数执行完成后, 但是函数的 ao 并没有彻底释放, 形成闭包. 和对象实例化一致

> 函数返回内部的函数并保存的过程, 一定会形成闭包

## 预编译过程

简介: 是指 js 语法检测完, 程序执行之前所存在的步骤

执行的步骤:

> 1. 查找所有变量的定义
> 2. 实参复制给形参
> 3. 寻找所有的函数

> AO: active object 活动性对象, 执行上下文
>
> GO: global object 全局对象

## 对象

对象的三种声明方式:

> 1.{}: 对象字面量
>
> 2.new function(){}
>
> 3.Object.create()

- 函数本身会成为所形成队形的构造函数 constractor

new 一个对象实质:

> 函数最初会声明一个包含 constractor, proto 的对象,并把 this 指向这个对象, 在函数的最终会返回这个对象
>
> 当返回引用队形的话, 就会修改这个 this 返回值

原型和袁兴亮

对象原型脸上的值可以取出来, 但是不能修改, 智能够显示的进行修改

- call,apply

  > function.call({}, 参数)
  >
  > 两者均可以修改函数内 this 的指向, 唯一区别是 apply 的第二个参数是一个数组

- callee,caller

  > 函数内部 arguments 对象的两个属性
  >
  > callee: 返回执行函数的本身
  >
  > caller: 返回调用该函数的函数

**圣杯模式**: 通过声明一个临时对象解决函数的继承原谅连问题

```
### 3.正则表达式

```

// 定义
var reg = /规则/
// 方法
reg.exec(str)// 查找位置
reg.text(str)// 判断是否存在

// js 中数组可变长度, 可以不同的数值类型

```

### 5.异常
```

// js 中只有 Error 错误
// 抛出异常
throw new Error("MESSAGE")
// 捕获异常
catch(e){
document.write("错误信息:"+e.message+"<br>")
}

```

```
