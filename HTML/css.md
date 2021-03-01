# css内容学习

1. 选择器
```
基本选择器
* 通配符选择器
标签选择器
. 匹配 class
# 匹配 id
```
```
组合选择器
, 隔开,用于并列
  空格隔开, 嵌套选择器
>  父子紧挨选择器
+  同一个级别
```

2. 修饰
```
margin:   每个组件的外边距
padding:  每个组件的内边距.

background:  背景
font:   字体
```

**CSS初始化样式**
```css
/*
 * css 公共样式初始化
 */
html {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 62.5%;
}

body {
    margin: 0;
}

* {
    box-sizing: border-box;
}
.content-box {
	box-sizing: content-box;
	-moz-box-sizing: content-box;
    -webkit-box-sizing: content-box;
    -ms-box-sizing: content-box;
    -o-box-sizing: content-box;
}
a {
    text-decoration: none;
    color: #333;
}

ul {
    margin: 0;
    padding: 0;
    list-style: none;
}

h1,h2,h3,h4,h5,h6,p{
    margin: 0;
    font-weight: normal;
}

img {
    width: 100%;
}

textarea, input {
    outline: none;
}
.clearfix::after{
    content: "";
    display: block;
    clear: both;
}
```