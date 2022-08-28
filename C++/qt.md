# c++ qt 相关编程

- [c++ qt 相关编程](#c-qt-相关编程)
  - [I. qt 声明](#i-qt-声明)
  - [II. 基础用法](#ii-基础用法)
  - [III. 面向对象](#iii-面向对象)
  - [qt 数据库](#qt-数据库)

qt 是 c++ 跨平台图像框架, 动态库免费(很麻烦), 静态库商业收费

## I. qt 声明

qt 是一组框架, 除了窗口编程, 还有许多其他的组件(qt 项目可以和 msvc 项目互相转换)

组件:

- assistant: qt 帮助文档
- qtcreater: qt 代码集成开发环境
- qmake: 处理 qt 项目,生成 Makefile 的工具(类似 cmake)
- desinger: qt 设计师
- uic: qt 转换器
- rcc: qt 资源编译器
- moc: 元对象编译器

qmake 用法:

```bash
# 生成 qt 项目文件 project.pro
qmake -project
# 根据 project.pro 生成Makefile文件
qmake
# 根据 makefile 编译为可执行文件
make
```

## II. 基础用法

- qt 样例程序

```c++
#include <QApplication>
#include <QWidget>
#include <QLabel>
#include <QPushButton>

int main(int argc, char **argv) {
    QApplication app(argc, argv);
    QWidget parent;
    QLabel label("我是label窗口", &parent);
    QPushButton button("按钮", &parent);
    label.move(200, 10);
    button.move(200, 100);
    button.resize(100, 40);
    parent.resize(500, 300);
    parent.show();
    return app.exec();
}
```

qt 的父窗口:  
QDialog  
QMainWindow  
QWidget

- 信号和槽

qt 对 c++语法的扩展, 实现不同对象之间的数据交互

信号函数: 只需声明,不能写定义

```c++
class XX: public QObject {
    Q_OBJECT // 宏: 对应 moc (元对象编译器), 处理qt语法扩展
signals:
    void signal_func(...);
}
```

槽函数: 和普通成员函数没什么不同

```c++
class XX: public QObject {
    Q_OBJECT
public slots:
    void slot_func(...);
}
```

信号连接  
QObject::connect(const QObject \*sender, const char\* signal,
const QObject \*receive, const char\* method);

1. sender: 信号发送对象指针
2. signal: 信号, 可以使用 SIGNAL() 宏包裹
3. 信号的接收对象
4. 接收信号要执行的槽函数, 可以使用 SLOT() 宏包裹

## III. 面向对象

## qt 数据库
