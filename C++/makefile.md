# makefile使用说明

说明:make类似于一个软件源代码到可使用的程序的管理软件,完全由创建的人自己书写,有自己的语法,主要调用系统的程序.
### 命令
make  #直接进行编译  
 -f:# 指定文件
make clean #删除可执行文件和中间文件
make install #把编译好的程序进行安装

### makefile文件语法

初级使用  
target:dependency
    command

目标:依赖
    命令     #必须tab分割

如果没有依赖的话,则在编译的时候不会运行,可以作为参数进行单独调用,例如clean

.PHONY clean
    - rm *.o    #清空编译后产生的文件  
  
  
- makefile文件会把第一个target作为最终的生成文件,然后依次检查依赖,执行命令.
- 完全可以自己构建install,uninstall,等完善软件使用.

**makefile中的特殊变量**  
|符号|含义|
|-|-|
|$@|代指目标|
|$^|代指所有依赖|
|$<|代指第一个依赖|
*** 
高级使用  
include makefile  #依赖其他  makefile文件

定义变量  
object = a.cpp b.cpp  
调用时:$(object)

自动推导
对于.o文件,能够自动识别并添加相应文件的.cpp文件
并且 cc -c .cpp也会被推导出来

[推荐参考地址](https://seisman.github.io/how-to-write-makefile/introduction.html)