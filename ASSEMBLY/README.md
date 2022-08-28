# assembly 学习

主要说明 x86 架构 32 程序的汇编

- [assembly 学习](#assembly-学习)
  - [I. 8 个通用寄存器](#i-8-个通用寄存器)
  - [II. 7 种 cpu 寻址方式](#ii-7-种-cpu-寻址方式)
  - [III. 基础指令](#iii-基础指令)
  - [IV. eflag 寄存器和 jcc 指令](#iv-eflag-寄存器和-jcc-指令)
  - [V. 高级指令](#v-高级指令)
  - [VI. 64 位程序指令](#vi-64-位程序指令)

## I. 8 个通用寄存器

eax,ebx,ecx,edx,esi,edi,esp,ebp

eip: cpu 之执行指令的位置

ebp,esp: 程序的栈空间的栈低地址和栈顶地址(栈空间为从高地址向低地址扩充)

内存数据存储形式:  
大端序: 按照直观内存书写方式(小地址到大地址)为数据高字节在低地址, 低字节在在高地址(先从小地址写起么)  
小端序: 按照数据从高地址到低地址书写方式数据高地址在内存高地址,数据低地址在内存低地址  
程序内存的存储方式一般为小端序, 网络数据的传输方式为大端序

## II. 7 种 cpu 寻址方式

- 1. 立即数寻址

  直接操作立即数: mov eax, 0x1; (0x1 即为立即数)

- 2. 寄存器寻址

     操作寄存器的值: eax

- 3. 直接寻址

     直接用立即数当地址: mov eax, dword ptr [0x0f34d04]; (0x0f34d04 即为立即数)

- 4. 寄存器间接寻址

     把寄存器的值当地址,寻址: mov ebx, dword ptr [eax]; (eax 即为寄存器)

- 5. 寄存器相对寻址

     寄存器的值加上偏移: mov ebx, dword ptr [eax+0x4];

- 6. 相对基址变址寻址

     mov eax, dword ptr [ebx+ecx+0x8];

- 7. 带比例存储器寻址

## III. 基础指令

push, pop, pushad, popad, mov
call,ret,retn

lea eax, str1;
lea 指令: 用于把 str1 的地址放到 eax 寄存器

函数调用约定: 函数的参数是从右向左通过 push 进行传递

32 位程序有 3 中函数调用约定: \_\_cdcall, \_\_stdcall, \_\_fastcall
\_\_cdcall: 函数调用执行完(retn), 会调用 add 0x[参数大小];去进行平栈
\_\_stdcall: 函数调用完执行的 ret 后面会加上参数空间的大小, 所以后面不会再进行平栈了
\_\_fastcall: 前两个参数会放到寄存器里面  
64 位程序删掉了函数调用约定, 全部采用类似 fastcall 的调用方式

## IV. eflag 寄存器和 jcc 指令

jmp 指令: 无条件跳转指令
cmp 比较执行: 是指会把两个数相减, 并设置 ZF 寄存器的值

| eflag 指令 | OF         | SF         | ZF         | AF         | PF             | CF         |
| ---------- | ---------- | ---------- | ---------- | ---------- | -------------- | ---------- |
| 描述       | 溢出寄存器 | 符号寄存器 | 零位寄存器 | 辅助寄存器 | 奇偶校验寄存器 | 进位寄存器 |
| jcc 指令   | JO/JNO     | JS/JNS     | JE/JNE     |            | JP/JNP         | JB/JNB     |

## V. 高级指令

逻辑运算:
and, or, xor, not

算术运算:
add,sub,mul,imul,div,idiv,inc,dec

mul,div: 无符号运算
imul,idiv: 有符号运算

## VI. 64 位程序指令

1.  64 位程序的所有寄存器以 r 开头, 如 rax
    rax,rbx,rcx,rdx,rsp,rbp,rsi,rbi,rip

2.  64 为程序多了 R8~R15 8 个通用寄存器

3.  64 位程序删除了 3 中函数调用约定, 只剩下了一种类似\_\_fastcall 的函数调用
    前 4 个参数方到 rcx,rdx,r8,r9 寄存器中, 剩下参数通过 push 放到栈内
