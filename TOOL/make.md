[...返回上级目录](/)

# Makefile 学习

- [Makefile 学习](#makefile-学习)
  - [1. 书写规则](#1-书写规则)
  - [2. 书写命令](#2-书写命令)
  - [3. 变量使用](#3-变量使用)
  - [4. 函数使用](#4-函数使用)
  - [5. make 常用规则](#5-make-常用规则)

make 类似于一个软件源代码到可使用的程序的管理软件,完全由创建的人自己书写,有自己的语法,主要调用系统的程序.
makefile 文件会把第一个 target 作为最终的生成文件,然后依次检查依赖,执行命令.
完全可以自己构建 install,uninstall,等完善软件使用.

## 1. 书写规则

- 规则

```Makefile
目标: 依赖文件
    执行命令
#注释
# 如果没有依赖文件的话, 就不会执行
```

- 伪目标: 没有依赖文件的目标, 只有在 make 显示调用的时候才会执行

```Makefile
.PHONY: 目标
目标:
    命令
```

- 多目标

```Makefile
# 使用自动化变量$@ 操作
a b: text.cpp
    g++ -o $@ $<
```

- 子目录

```Makefile
# 使用$(MAKE) 命令代
# 进入子目录执行make命令
subdir:
    cd subdir && $(MAKE)
```

## 2. 书写命令

```Makefile
# 1. @:  命令行前的@能够隐藏执行的命令
.PHONY: clean
clean:
    @rm -rf *.o
# 2. -:  忽略执行的命令
.PHONY: install
install:
    -make install
# 3. 命令包: define 开头 endef 结尾
# 定义
define run-clean
    @rm -rf *.o
    @rm -rf *.exe
endef
# 4. 默认执行的命令
.DEFAULT_GOAL := mytarget
# 执行
$(run-clean)
```

## 3. 变量使用

```Makefile
# 变量的几种形式
# 1. 变量名(a) = 值: 赋值, 会进行全局查找赋值
a = file.cpp

# 2. 变量名 := 值: 赋值, 只会对前面出现过的进行赋值, 如果没出现过, 就为空
a := file.cpp

# 3. 变量名 ?= 值: 如果变量不存在就赋值
a ?= file.cpp:

# 4. 变量名 += 值: 追加赋值
a = file.cpp
a += two.cpp  # a = file.cpp two.cpp
```

## 4. 函数使用

```Makefile
# 函数的几种形
# 1. 常用字符串函数
# strip: 去除字符串两边的空格
$(strip " a  ")
# filter: 去除字符串中的某些字符
$(filter "a","a b c")

# 2. 常用文件函数
# dir: 取目录
# notdir: 取文件
$(dir $(file))

# 3. if 函数
# 条件语句
$(if $(a), $(b), $(c))

# 4. foreach 函数
# foreach 函数可以遍历数组, 或者是一个文件夹
$(foreach n,$(a),echo $n)

# 5. call 函数
# 调用其他函数的函数, 用于解决复杂参数的问题
$(call func, a, b, c)

# 6. shell 函数
# 既调用命令行命令, 性能会比较差
$(shell cat a.cpp)
```

## 5. make 常用规则

通用表示符

| id  | 符号 | 说明                                                            |
| --- | ---- | --------------------------------------------------------------- |
| 1   | $@   | 当前目标                                                        |
| 2   | $<   | 当前源文件的第一个文件, 如果是\*.o 的形式, 就会一个一个的取出来 |
| 3   | $^   | 当前目标的依赖文件集合                                          |
| 4   | $%   | 当前目标的源文件集合                                            |

[推荐参考地址](https://seisman.github.io/how-to-write-makefile/introduction.html)
[...返回上级目录](../)
