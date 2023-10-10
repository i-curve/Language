[...返回上一级](../)

# JS 变量基础和类型转换

- [JS 变量基础和类型转换](#js-变量基础和类型转换)
  - [I. 变量类型](#i-变量类型)
  - [II. 函数](#ii-函数)
  - [III. 预编译过程](#iii-预编译过程)
  - [IV. 对象](#iv-对象)
  - [V. ES6 语法](#v-es6-语法)
  - [VI.正则表达式](#vi正则表达式)
  - [VII.异常](#vii异常)
  - [扩展知识](#扩展知识)
    - [事件循环](#事件循环)
  - [浏览器的渲染原理](#浏览器的渲染原理)
  - [属性描述符](#属性描述符)
  - [跨域](#跨域)

简介: javascript 的 es 标准

## I. 变量类型

- 数据类型

1. 基础类型

> number,string,boolean,undefined,null, symbo(es6)

2. 引用类型

> object,function,array

3. 可以通过 typeof 查看数据的类型, 返回的类型是 string

> typeof(null) 得值是 'object', 这是历史遗留问题, 用户代指空对象

4. if 条件用判断为 false 的值有

> 0, "", false, undefined, null, NaN

NaN 和任何值都不相等,包括自己本身, 只能用 isNaN()函数去判断
null == undefined: 为 true

- 类型转换

隐式类型转换

> 1. \+ 符号会趋向于把类型转换为 string
> 2. \- \* / % 符号会趋向于把类型转换为 number
> 3. if 里面会把最终表达式转换为 boolean 类型
> 4. 包装类: '123'.length , '123' 是 string 类型对象, 此处包装成了 String()对象
> 5. undefined 转成 number 后为 NaN, null 转 number 后为 0
> 6. 字符串和其他任意类型相加隐式转换为字符串拼接, 其他任意类型隐式转换为转为 number

显示类型转换

> Number(), String(), Boolean(): 强制把类型转换为相应的类型
>
> ~~undefined~~, ~~null~~: 没有该对应的转换

## II. 函数

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

## III. 预编译过程

简介: 是指 js 语法检测完, 程序执行之前所存在的步骤

执行的步骤: (先进行语法检测)

> 1. 查找所有变量的定义
> 2. 实参复制给形参
> 3. 寻找所有的函数

> AO: active object 活动性对象, 执行上下文
>
> GO: global object 全局对象

## IV. 对象

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

原型和原型链

对象原型链上的值可以取出来, 但是不能修改, 只能够显示的进行修改

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

## V. ES6 语法

- 1. const,let

这两种变量声明没有变量提升

- 2. 剩余参数

```javascript
function (a, b, ...keys) {
  // keys 是一个数组, 会把剩余的参数放在里面
}
```

- 3. 对象扩展

如果键和值名字一样情况下可以只写名字

- 4. 类扩展

```javascript
class Animal {
  constructor() {} // 构造函数
  sayName() {}
}
class Dog extends Animal {
  // 继承
  constructor() {
    super(); // 调用敷方法的构造函数
  }
}
```

- 5. 模块

export 和 import 使用

## VI.正则表达式

```js
// 定义
var reg = /规则/;
// 方法
reg.exec(str); // 查找位置
reg.text(str); // 判断是否存在

// js 中数组可变长度, 可以不同的数值类型
```

## VII.异常

```js

// js 中只有 Error 错误
// 抛出异常
throw new Error("MESSAGE")
// 捕获异常
catch(e){
document.write("错误信息:"+e.message+"<br>")
}
```

## 扩展知识

### 事件循环

事件循环(w3c)又叫消息循环(chrome 实现命名)

单线程是异步产生的原因, 事件循环是异步的实现方式, 浏览器会把 js 代码分成一个个的任务,并放入到队列中

根据 w3c 标准, 每一种任务都有一个类型, 同种类型的任务在一个消息队列中, 不同的类型可以在不同的队列中, 具体由浏览器自己实现.  
微队列、交互队列、延迟队列。其中 Promise 是在微队列中, 优先级最高, 只有高优先级的队列内没有内容时才会执行低优先级内的任务

## 浏览器的渲染原理

浏览器收到网站访问时, 通过通络线程获取网站 html, 然后生成一个渲染任务放到渲染消息队列中, 进入渲染过程

解析 html, 当遇到 css 代码时, 会把 css 内容放到另一个线程中去下载并生成 cssom 对象, 当遇到 js 代码时, 会进入阻塞状态, 因为 js 可能会改变当前 dom 树内容之后, 生成一个 dom 树和 cssom 树

遍历 dom 树, 计算出每个节点的全部样式, 得到计算样式(computed style), 之后进行布局, 生成布局树

## 属性描述符

对象的属性描述内容, 可以描述一个属性是否重写, 是否可以遍历

configurable: 当且仅当该属性的 configurable 键值为 true 时，该属性的描述符才能够被改变，同时该属性也能从对应的对象上被删除。
enumerable: 当且仅当该属性的 enumerable 键值为 true 时，该属性才会出现在对象的枚举属性中。
value: 该属性对应的值。可以是任何有效的 JavaScript 值（数值，对象，函数等）。
writable: 当且仅当该属性的 writable 键值为 true 时，属性的值，也就是上面的 value，才能被赋值运算符改变。

属性描述符 value,writable 不能和 get,set 同时使用

```javascript
class UIgoods {
  constructor(g) {
    Object.defineProperty(this, "a", {
      value: g,
      writable: false,
      get: function () {},
      set: function (val) {
        throw new Error("属性data不能赋值");
      },
    });
  }
}
// 获取对象的属性描述符
Object.getOwnPropertyDescriptor(obj, "foo");
```

禁止扩展: Object.preventExtensions 如果你想禁止一个对象添加新属性并且保留已有属性，可以使用
密封: 使用 Object.seal 可以创建一个“密封”的对象。
冻结: 使用 Object.freeze 可以创建一个冻结对象。

## 跨域

浏览器同源策略: 浏览器会对非同源 ajax 请求进行严格限制, 对标签,img,js,css 进行部分限制

> 同源: 相同协议, 相同主机, 相同端口

- cors

简单请求(simple request): 对于简单请求浏览器只会验证 Access-Controler-Allor-Origin 源是否存在

1. 请求方式为 GET,POST
2. 不能修改浏览器默认请求头
3. Content-Type 为: text/plain, application/x-www-form-urlencoded, multipart/form-data

> 预检请求(preflight request):

对于预检请求, 浏览器会同时验证 Access-Control-Allor-Origin, Access-Control-Allow-Headers, Access-Control-Allow-Methods. Access-Control-Allow-Max-Age: 设定多少有效期内不用进行验证同源

因为浏览器的 OPTIONS 请求不对添加认证信息, 所以对于需要使用 cookie 的情况需要添加 credentials 凭证, 并且认证源不支持\*  
服务端: Access-Control-Allow-Credentials: true  
客户端:

```js
// XMLHttpRequest:
var xhr = new XMLHttpRequest();
xhl.withCredentials = true;

// fetch
fetch(url, {
  credentials: "include",
});
```

- jsonp

```js
function request(url) {
  return new Promise((resolve, reject) => {
    const cbName =
      "__callback" + "_" + Math.random().toString(32).substring(2) + Date.now();
    window[cbName] = function (res) {
      delete window[cbName];
      script.remove();
      resolve(res);
    };
    const script = document.createElement("script");
    script.src = url;
    document.body.appendChild(script);
  });
}
```
