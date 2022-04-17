[返回上级目录](../)

# CMAKE 文档

- [CMAKE 文档](#cmake-文档)
  - [**1.** 通用 CMAKE 内容](#1-通用-cmake-内容)
  - [**2.** CMAKE 动态链接库内容](#2-cmake-动态链接库内容)
  - [**3.** CMAKE 常用变量](#3-cmake-常用变量)
  - [**4.** 其他 CMAKE 命令](#4-其他-cmake-命令)
  - [**4.** 样例](#4-样例)

## **1.** 通用 CMAKE 内容

通用 cmake 跨平台的基本内容

```cmake
# 指定 CMAKE 的版本, 使用3.0及其以上版本
cmake_minimum_required(VERSION 3.0)

# 指定生成可执行程序的名字
project(cmake)

# 通用跨平台编译器选项
if (MSVC) # 微软msvc编译器
    add_compile_options("/std:c++20") # 添加编译器选项
    add_compile_options("/source-charset:utf-8")
    add_compile_options("/execution-charset:gbk")
elseif (MINGW) # windows g++编译器
    add_compile_options(-std=c++2a -finput-charset=utf-8 -fexec-charset=gbk)
elseif (UNIX) # linux, macos 编译器
    add_compile_options(-std=c++20)
endif()

# 生成可以行程序
add_executable(cmake main.cpp)

```

## **2.** CMAKE 动态链接库内容

```cmake
# 生成链接库文件
add_library(libname ${SOURCE})
```

## **3.** CMAKE 常用变量

cmake 常用的一些变量

```cmake
# EXECUTABLE_OUTPUT_PATH 最终生成可执行文件的路径
# PROJECT_SOURCE_DIR 项目源码路径
# PROJECT_BINARY_DIR cmake执行路径
set(EXECUTABLE_OUTPUT_PATH  ${PROJECT_SOURCE_DIR}/bin)

# CMAKE_EXE_LINKER_FLAGS 全静态链接编译
set(CMAKE_EXE_LINKER_FLAGS "-static -static-libstdc++")

```

## **4.** 其他 CMAKE 命令

```cmake
# 指定头文件路径
include_directories(include)

# 包含改文件夹下所有的文件
aux_source_directory(src SOURCE)
# 添加子目录
add_subdirecotry(subdirectory_path subdirectory_name)
```

## **4.** 样例

[CMakeLists.txt](./CMakeLists.txt)

[返回上级目录](../)
