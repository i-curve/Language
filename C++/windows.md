# c++ windows 相关编程

- [c++ windows 相关编程](#c-windows-相关编程)
  - [I. 程序入口程序](#i-程序入口程序)
  - [II. 链接库](#ii-链接库)
  - [III. 内联汇编](#iii-内联汇编)
  - [IV. 控制台编程](#iv-控制台编程)
  - [V. 窗口编程](#v-窗口编程)
  - [VI. MFC 编程](#vi-mfc-编程)
  - [VII. 乱码问题](#vii-乱码问题)

程序与 windows 系统接口进行交互编程

## I. 程序入口程序

windows 程序分为控制台程序(console), 和窗口程序

控制台程序默认入口函数为 main (入口点 mainCTRStartup)。  
窗口程序的默认入口函数为 WinMain (入口点 WinMainCRTStartup)

程序入口点可以修改既选择 main 函数为主的窗口程序, 通常可以用在 qt 项目内(main 入口函数)

- 通过预编译指令修改

```c++
#gragma comment(linker, "/subsystem:windows /entry:mainCRTStartup")

#pragma comment(linker, "/subsystem:console /entry:WinMainCRTStartup")
```

## II. 链接库

> 程序的链接库库可以扩展到编写的程序中, 一种是可以集成到编译后的 exe 程序总, 另一种是在程序运行的时候动态加载, 调链接库的内容

使用链接库均需要额外的头文件

- 静态连接库: xxx.lib

组成部分: xxx.lib, xxx.h

生成方法:

1. 修改项目生成目标为静态库
2. 运行项目
3. 得到.lib 和.h 文件
4. 打包发布

```c++
//testlib.h
#pragma once
int sum(int, int);
// testlib.cpp
int sum(int a, int b) {
    return a + b;
}
```

vs2022 项目设置:

![静态库](../img/static-lib-exportpng.png)

调用方法:

1. 贴上头文件
2. 引入项目

```c++
#include <iostream>
// 1. 贴上头文件
#include "../testlib/testlib.h"
// 2. 引入库目录
#pragma comment(lib, "testlib.lib")

int main() {
    std::cout << "Hello World!\n";
    cout << sum(3, 4) << endl;
    return 0;
}
```

vs2022 项目配置:

![](../img/static-lib-import.png)

- 动态链接库: xxx.dll

组成部分: xxx.dll, xxx.lib

动态链接库分为两种调用方法: 隐式调用和显示调用

生成方法:

```c++
// testdll.h
int sub(int,int);

// testdll.cpp
int sub(int a,int b) {
    return a - b;
}

// 模块定义文件: Source.def
LIBRARY testdll
EXPORTS
sub
```

项目调成动态库

隐式调用:

```c++
// main.cpp
#include <iostream>
#include "../testdll/testdll.h"
using namespace std;
#pragma comment(lib, "testdll.lib")
int main() {
    cout << sub(4, 3) << endl;
    return 0;
}
```

备注: **隐式调用仍旧需要 dll 文件**

需要添加库路径

显示调用:

**dll 文件需要放到和可执行程序同一个目录或者项目下**

```c++
// 只需要.dll文件
#include <iostream>
#include <windows.h>
using namespace std;
using SUB = int(int, int);
int main() {
    HMODULE hmod = LoadLibraryA("testdll.dll");
    if (!hmod) {
        cout << "动态库加载失败\n";
        return 0;
    }
    SUB *sub = (SUB *)GetProcAddress(hmod, "sub");
    if (sub == nullptr) {
        cout << "方法加载失败!\n";
        return 2;
    }
    cout << sub(4, 3) << endl;
    return 0;
}
```

- 扩展内容:

文件生成: .dll => .def => .lib

```powershell
# 打开vs终端, 并进入目录
## 查看生成的 dll 是否有效(查看导出函数):
dumpbin /exports testdll.dll

## dll => def (minGW 提供的工具)
gendef test.dll

## def => lib
lib /def:test.def /machine:X64 /out:test.lib
```

## III. 内联汇编

MSVC 只能进行 32 位程序内联汇编

- \_\_asm 指定内联汇编语句;

```c++
// 内联汇编调用 MessageBoxA 函数
char msg[] = "hello world";
char title[] = "title";
// 从右向左push 参数
__asm {
    push 0;
    lea eax, title;
    push eax;
    lea eax, msg;
    push eax;
    push 0;
    call MessageBoxA;
}
```

- 函数内联汇编

\_\_declspec(naked) 修饰的函数, 内部编译器不会添加汇编代码, 需要手动指定

```c++
void __declspec(naked) Test() {
    __asm {
        push 0;
        push 0;
        push 0;
        push 0;
        call MessageBoxA;
        ret;
    }
}
```

## IV. 控制台编程

- 进程控制

## V. 窗口编程

## VI. MFC 编程

## VII. 乱码问题

- 乱码缘由

win32 api 由于历史遗留导致了许许多都的问题, 乱码就是其中之一.

win32 api 有两个版本, A 版本(对应多字节)和 W 版本(对应 unicode).

导致乱码的问题有:

1. 控制台环境
2. 系统语言环境(系统选择地区以及是否勾选 utf8 选项)
3. 窗口环境
4. 多字节和 unicode 转换

- 控制台乱码

通过设置控制台语言环境解决

```c++
/// <summary>
/// setlocale 设置程序选择运行环境(控制台程序)
/// </summary>
/// <returns></returns>
setlocale(LC_ALL, "en_US.UTF-8");
// 可用的选项有
// English_United States.utf8
// English_United States.gbk
// Chinese_China.utf8
// Chinese_China.gbk
// chs
```

- 窗口乱码

窗口乱码一般和多字节与 unicode 字符转换有关

```c++
#include <atlstr.h>

/// <summary>
/// unicode 字符到多字节转换
/// </summary>
/// <param name="srcstrW"></param>
/// <returns></returns>
string CStringW2string(CString srcstrW) {
    int dBufSize = WideCharToMultiByte(CP_OEMCP, 0, srcstrW, -1, NULL, 0, NULL, FALSE);
    char *pBuf = new char[dBufSize + 1];
    memset(pBuf, 0, dBufSize + 1);
    WideCharToMultiByte(CP_OEMCP, 0, srcstrW, -1, pBuf, dBufSize, NULL, FALSE);
    pBuf[dBufSize] = '\0';
    string tmpstr = pBuf;
    delete pBuf;
    pBuf = NULL;
    return tmpstr;
}

/// <summary>
/// char2CStringW 多字节到unicode转换
/// </summary>
/// <param name="pstr"></param>
/// <returns></returns>
CStringW char2CStringW(const char *pstr) {
    int dBufSize = MultiByteToWideChar(CP_UTF8, 0, pstr, -1, NULL, 0);
    WCHAR *pBuf = new WCHAR[dBufSize + 1];
    memset(pBuf, 0, dBufSize + 1);
    MultiByteToWideChar(CP_UTF8, 0, pstr, -1, pBuf, dBufSize);
    pBuf[dBufSize] = '\0';
    CStringW tmpstrW = pBuf;
    delete pBuf;
    return tmpstrW;
}

```

**通过 CStringA, CStringW 进行字符转换, 不能跨电脑, 不好使**
**通过 CA2W, CW2A 不好使**

- 程序程序编写规范

控制台程序

1. 采用 setlocale() 函数进行具体 pc 具体编译

窗口程序

1. 程序采用 unicode 规范
2. 通过多字节和 unicode 转换函数进行处理

[推荐阅读文章 http://www.fmddlmyy.cn/text7.html](http://www.fmddlmyy.cn/text7.html)
