# css

- [css](#css)
  - [I. 基础内容](#i-基础内容)
  - [II. 样式内容](#ii-样式内容)
  - [css3 学习](#css3-学习)
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

- 关系选择器

| 分隔符 | 说明         |
| ------ | ------------ |
| ,      | 用于并列     |
| 空格   | 包含选择符   |
| \>     | 子紧挨选择符 |
| \+     | 相邻选择符   |
| ~      | 兄弟选择符   |

- 属性选择器

| 分隔符        | 说明                                 |
| ------------- | ------------------------------------ |
| E[att]        | 具有 att 属性的选择器                |
| E[att="val"]  | 具有 att 属性且值为 val 的选择器     |
| E[att~="val"] | 具有 att 属性且值包含 val 的选择器   |
| E[att^="val"] | 具有 att 属性且值以 val 开头的选择器 |
| E[att$="val"] | 具有 att 属性且值以 val 结尾的选择器 |
| E[att*="val"] | 具有 att 属性且包含 val 的选择器     |

- 伪类选择器有:

:hover 鼠标悬停时
:active
:focus 鼠标聚焦时

## II. 样式内容

- 盒子模型

默认盒子属于 content-box, 此时 padding, border, margin 全部挂在了 width 和 height 的外面.
此时可以设置 border-box, 此时只有 margin 挂在了 width 和 height 外面

- 边框

```scss
border: 1px solid transparent;
// border-width  border-style border-color
```

边框风格有: none hidden dashed solid dotted

- 背景

```scss
background: background-color background-image background-repeat
  background-attachment background-position background-size;
```

- 字体

```scss
font: font-style;
```

- 线的 style 值有:

1. solid: 实线
2. double: 双重线
3. dashed: 虚线
4. dotted: 点状线
5. wavy: 波浪线

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

## css3 学习

- 流式布局

- 过度(transition)

> transition: 要过度的属性 花费时间 运动曲线 何时开始;

谁做过度给谁加.如果有多个属性可以利用逗号隔开.
不写属性代表全部属性

```css
div {
  transition: width 0.5s ease 1s;
}
```

- 变换(transform)

translate(): 平移
scale(): 缩放
rotate(): 旋转
skew()

- 动画(animation)

通过控制关键帧实现复杂动画效果

animation-play-state: paused|running; 动画暂停属性

```css
#box {
  animation: myname 10s infinite 1s;
}
@keyframe myname {
  35% {
    margin-left: -2100px;
  }
  70% {
    margin-left: 4200px;
  }
  100% {
  }
}
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
