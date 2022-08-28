# JS DOM doc

- [JS DOM doc](#js-dom-doc)
  - [I. 获取 DOM 节点](#i-获取-dom-节点)
  - [II. dom 节点操作](#ii-dom-节点操作)

简介: javascript 的 dom 规范

## I. 获取 DOM 节点

```js
// 查询id属性,反对第一个查到的值
var id1 = document.getElementById("idName");
// 查询name属性
var nn1 = document.getElementsByName("name");
// 查询标签
var tn1 = document.getElementsByTagName("tagName");
// 查询class属性,返回的是一个集合
var cn1 = document.getElementsByClassName("nameName");
// css选择器,直返会查询到的第一个
var qs1 = document.querySelector("#name");
```

dom 节点就是 html 里面的内容

```js
id1.innerHTML = '<a href="http://example.com" target="_blank">Example.com</a>';
nn1.innerText = "hello world";
```

innerHTML 和 innerText 区别:  
innerHTML 里面的内容会被当做是 html 标签内容, 因此会对里面的 html 标签进行解析  
innerText 里面的内容会被当做纯文本字符, 不会进行 html 标签解析

- 节点间的关系

```js
// 父节点唯一
parentNode; //父节点
parentElement; //父元素

// 子节点是个数组
childNode; // 子节点
children; //子元素
```

## II. dom 节点操作

- 基本操作

// 待修改

```js
// 元素节点
var d1 = document.createElement(tagName);
// 文本节点
var d2 = document.createTextNode(data);
// 增加
document.appendChild(d1);

// 删除
document.removeChild(d1);
```

- 修改操作

```js
// 修改内部标签
dom1.innerHTML = "";
// 修改内部文本
dom1.innerText = "";

// 修改类名
dom1.className = "dom1";
// 修改style里面的属性
dom1.style.display = "none";

// 标签内其他属性直接用.name 即可
// dom1.[属性名]
```
