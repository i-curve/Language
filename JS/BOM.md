# JS BOM doc

- [JS BOM doc](#js-bom-doc)
  - [I. 事件概述](#i-事件概述)

简介: javascript bom 规范

## I. 事件概述

事件三要素: 事件源, 事件类型, 绑定函数

- 事件类型

1. 鼠标事件

onclick, ondbclick

2. 键盘事件

onkeydown, onkeyup  
对于绑定按键, 一般采用 keyup 的方法

3. html 事件

onload, onsubmit, onunload

- 绑定函数

```js
var btn1 = document.getElementById("button")[0];
// 法一(旧):
// 本方法
btn1.onclink = function () {
  console.log("方法一 按钮点击了");
};
// 法二(新):
btn1.addEventListener("click", false, function () {
  console.log("方法二 按钮点击了");
});
```

移除事件

```js
function clickHandle() {
  console.log("按钮点击了");
}
// 绑定事件
btn1.addEventListener("click", clickHandle);
// 移除事件
btn1.removeEventListener("click", clickHandle);
```

方法一只能绑定单个事件, 方法二可以连续绑定多个事件  
移除事件只能采用方法二的形式, 并且不能使用匿名函数

注意: 旧方法事件绑定事件前有 on, 新方法事件字符串里面没有 on
