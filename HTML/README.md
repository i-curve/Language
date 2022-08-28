# HTML5 doc

> 简介: html 标签及使用规范

## 标签

```html
<!-- -->
注释
<!DOCTYPE html>
<a></a>
<abbr></abbr> 隐含字体
<audio></audio>
<base /> header中的基准样式 <big></big> 大一号字体
<button></button>
<code></code>
<datalist></datalist>
<dd></dd>
<del></del>
<em></em> <i></i>斜体
<div></div>
<font></font>
<hr />
<img />
<label>
  <link />
  <textarea></textarea>
  <title></title>
  <u></u> 下划线
  <video></video>
  <ifream></ifream>

  表格:
  <table>
    <caption>
      标题
    </caption>
    <tr>
      <th>列名</th>
    </tr>
    <tr>
      <td>数据</td>
    </tr>
  </table>

  选项:
  <select>
    <option></option>
  </select>
</label>
```

- 表单元素类型

  > text,password,button
  > email,url,number,range,date,time

- a 标签作用

1. 超链接

```
<a href="https://baidu.com">message</a>
target="_black" 会在新的窗口中打开链接,默认本窗口
name: 锚,跳转到页面内固定的id命名位置
```

## 音频操作

```
// 1.音频
<audio src="" control="controls">
您的播放器不支持改类型文件
</audio>
<video src="" control="controls">
您的浏览器不支持该类型的文件
</video>
```

## 规范

> 1. 标签不区分大小写
> 2. 元素可以省略结束标签
> 3. 允许省略属性的属性值
> 4. 允许属性不适用引号
