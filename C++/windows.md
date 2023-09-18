# c++ windows 相关编程

- [c++ windows 相关编程](#c-windows-相关编程)
  - [I. 程序入口程序](#i-程序入口程序)
  - [II. 链接库](#ii-链接库)
  - [III. 内联汇编](#iii-内联汇编)
  - [IV. Win32 程序](#iv-win32-程序)
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

## IV. Win32 程序

- 消息管理

windows 消息分为:

1.  窗口消息
2.  命令消息
3.  控件通知消息
4.  用户定义消息

消息队列:

系统消息队列: 系统共享
线程消息队列: 每一个 gui 线程在调用 gdi 函数后会创建一个线程消息队列

发送消息:

1. PostMessage: 把消息发送到指定窗口所在消息队列中然后立即返回. 消息可能不被处理
2. PostThreadMessage: 把消息放到指定线程消息队列中然后立即返回.
3. SendMessage: 直接把窗口放到窗口过程处理, 处理后才返回, 如果不被处理, 发送消息的线程将一直被阻塞状态

SendMessage

SendInput (取代 keybd_event)

获取消息:

BOOL GetMessage(LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax);: 主要是从指定的窗口 hWnd 中取出 wMsgFilterMin 和 wMsgFilterMax 参数给出的消息范围内的消息,消息取出后就从消息队列中删除该消息。GetMessage 从消息队列中取不到消息，则线程就会被挂起，直到取出消息来返回。
BOOL PeekMessage(LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax, UINT wRemoveMsg):只是从消息队列中查询消息，如果有消息，则立刻返回 true；没有则返回 false。如果有消息，PeekMessage 中 wRemoveMsg 参数中设置的是 PM_REMOVE 则在取出消息并将消息从队列中删除，若设置是 PM_NOREMOVE 消息就不会从消息队列中取出。
BOOL WaitMessage():当一个线程的消息队列中没有消息存在时，waitMessage 函数会使该线程中断并处于等待状态，同时把控制权交给其它线程，直到被中断那个线程的消息队列中有了新的消息为止。

```cpp
#include <windows.h>

void MouseLeftDown() { // 鼠标左键按下
    INPUT Input = {0};
    Input.type = INPUT_MOUSE;
    Input.mi.dwFlags = MOUSEEVENTF_LEFTDOWN;
    SendInput(1, &Input, sizeof(INPUT));
}

void MouseLeftUp() { // 鼠标左键放开
    INPUT Input = {0};
    Input.type = INPUT_MOUSE;
    Input.mi.dwFlags = MOUSEEVENTF_LEFTUP;
    SendInput(1, &Input, sizeof(INPUT));
}

void down(int vk) {
    INPUT input = {0};
    input.type = INPUT_KEYBOARD;
    input.ki.wVk = vk;
    SendInput(1, &input, sizeof(INPUT));
}
void up(int vk) {
    INPUT input = {0};
    input.type = INPUT_KEYBOARD;
    input.ki.dwFlags = KEYEVENTF_KEYUP;
    SendInput(1, &input, sizeof(INPUT));
}

void press(int vk) {
    INPUT input[2] = {0, 0};
    input[0].type = INPUT_KEYBOARD;
    input[0].ki.wVk = vk;
    input[1].type = INPUT_KEYBOARD;
    input[1].ki.wVk = vk;
    input[1].ki.dwFlags = KEYEVENTF_KEYUP;
    SendInput(2, input, sizeof(INPUT));
}

int main(){
    // 控制qq聊天窗口并发送消息
    auto hWnd = FindWindow(nullptr, L"QQ");
    ShowWindow(hWnd, SW_SHOWNORMAL);
    RECT window = {0};
    GetWindowRect(hWnd, &window);
    SetCursorPos(window.left + 80, window.top + 400);
    Sleep(200);
    MouseLeftDown();
    MouseLeftUp();
    SetFocus(hWnd);
    Sleep(200);
    press(VK_RETURN);
    Sleep(200);
    for (char x : "AAA; this is a new message.;&^$#") {
        // press(VkKeyScan(x));
        SendMessageA(hWnd, WM_IME_CHAR, c, 0);
    }
    press(VK_RETURN);
}
```

```cpp
    //  2. qq窗口发送消息
    HWND hWnd = FindWindow(nullptr, L"抢我女人全干倒");
    if (hWnd == nullptr) {
        cout << "窗口打开失败\n";
        return 0;
    }
    string message = "this is a message.";
    for (auto &c : message) {
        SendMessageA(hWnd, WM_IME_CHAR, c, 0);
    }
    Sleep(200);
    SendMessage(hWnd, WM_KEYDOWN, VK_RETURN, 0);
    cout << GetLastError() << endl;
```

```c++
#include <windows.h>
#include <atlstr.h>

class OutputMsg {
private:
    CString msg;

public:
    template <typename... T>
    CString Format(CString formatPar, T... args) {
        msg.Format(formatPar, args...);
        return msg;
    }
};

static OutputMsg DeMsg;

int main() {
    // 程序句柄
    auto hWnd = FindWindowEx(nullptr, nullptr, nullptr, L"Option Settings");
    OutputDebugString(DeMsg.Format(L"程序句柄为: Ox%x\n", hWnd));
    // tabTree 句柄
    auto hWndTree = FindWindowEx(hWnd, nullptr, L"SysTabControl32", nullptr);
    OutputDebugString(DeMsg.Format(L"tab tree句柄为: Ox%x\n", hWndTree));
    // 对话框句柄
    auto hWndClass = FindWindowEx(hWndTree, nullptr, L"#32770", nullptr);
    OutputDebugString(DeMsg.Format(L"对话框句柄为: Ox%x\n", hWndClass));
    while (hWndClass) {
        hWndClass = FindWindowEx(hWndTree, hWndClass, L"#32770", nullptr);
        OutputDebugString(DeMsg.Format(L"对话框句柄为: Ox%x\n", hWndClass));
        break;
    }
    // setting 句柄
    auto hWndRender = FindWindowEx(hWndClass, nullptr, nullptr, L"Rendering settings");
    OutputDebugString(DeMsg.Format(L"render句柄为: Ox%x\n", hWndRender));
    // 控件句柄
    auto hWndGDI = FindWindowEx(hWndClass, nullptr, L"Button", L"GDI");
    OutputDebugString(DeMsg.Format(L"控件句柄为: 0x%x\n", hWndGDI));
    // 法一
    SendMessage(hWndGDI, WM_LBUTTONDOWN, 0, 0);
    SendMessage(hWndGDI, WM_LBUTTONUP, 0, 0);
    // 法二
    RECT rect{0};
    GetWindowRect(hWnd, &rect);
    SetCursorPos(rect.left + 50, rect.top + 330);
    INPUT input[2] = {0, 0};
    input[0].type = INPUT_MOUSE;
    input[0].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;
    input[1].type = INPUT_MOUSE;
    input[1].mi.dwFlags = MOUSEEVENTF_LEFTUP;
    SendInput(2, input, sizeof(INPUT));
    return 0;
}
```

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
