### JS中操作dom

&nbsp;
***
[1. 获取DOM节点](#1)
[2. 亲属访问](#2)
[3. 节点创建](#3)
[4. 加入、删除](#4)
[5. 修改](#5)

<span id="1">1. 获取DOM节点</span>
```js
// 查询id属性,反对第一个查到的值
document.getElementById("idName") 
// 查询标签
document.getElementsByTagName("tagName")
// 查询class属性,返回的是一个集合
document.getElementsByClassName("nameName")
// 查询class属性
document.getElementsByName("className")
// css选择器,直返会查询到的第一个
document.querySelector("#name")
```

<span id="2">2. 亲属访问</span>

```js
parentNode //父节点
parentElement //父元素

childNode // 子节点
children  //子元素
```

<span id="3">3. 节点创建</span>

```js
// 元素节点
document.createElement(tagName) 
// 文本节点
document.createTextNode(data)
```
<span id="4">4. 加入、删除</span>
```js
// 增加
appendChild()
innerHTML
innerText
// 删除
removeChild
```

<span id="5">5. 修改</span>
```js
// 修改节点
replaceChild(newChild, oldChild)
// 修改样式
style.xxx = sss
// 修改文本
innerHTML
innerText
```
