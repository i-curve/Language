# css

- [css](#css)
  - [I. 基础内容](#i-基础内容)
  - [II. 样式内容](#ii-样式内容)
  - [scss 语法学习](#scss-语法学习)
  - [下载](#下载)

## I. 基础内容

- 字体:

浏览器中默认字体大小是 16px, 行高 22px 或 23px;
em 单位表示的是一个字体的大小, rem 表示的是 html 的 font-size 大小

- 选择器类型有:

1. \* 通配符选择器, 权重为 0
2. 标签,伪元素选择器, 权重为 1
3. 类, 伪类选择器, 权重为 10
4. id 选择器 权重为 100
5. 内联样式 权重为 1000
6. !important 权重无穷大

- 组合选择器

| 分隔符 | 说明                 |
| ------ | -------------------- |
| ,      | 用于并列             |
| 空格   | 嵌套选择器           |
| \>     | 父子紧挨选择器       |
| \+     | 同一个级别兄弟选择器 |

- 伪类选择器有:

:hover 鼠标悬停时
:active
:focus 鼠标聚焦时

## II. 样式内容

- 边框

```scss
border: 1px solid transparent;
// border-width  border-style border-color
```

边框风格有: none hidden dashed solid dotted

- 文本截断三大件

```scss
white-space: nowrap; // 不换行
overflow-x: hidden; // 溢出隐藏
text-overflow: ellipsis; // 文本溢出显示省略号
```

多行截断(无法添加省略号)

```scss
overflow-y: hidden;
```

## scss 语法学习

1. 嵌套
2. 引用本身

```scss
.title {
  image {
    // 嵌套语法

    &-nav {
      // & 引用字符本身
    }
  }
}
```

3. 变量使用
4. 插入
5. 变量计算

```scss
$commoWidth: 30px; // 变量的声明
$commonHeight: 50px;
$attr: border;
.title {
  width: $commoWidth; // 变量使用
  height: $commonHeight;
  #{$attr}-color: blue; // 使用插值
}
```

6. 导入其他文件

```scss
@import "../common.scss";
```

## 下载

项目通用 css 配置下载

[common-css](./common.css)

中文参考手册
[css 参考手册](./css.chm)
