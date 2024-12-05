[返回上级目录](../)

# CMAKE doc

- [CMAKE doc](#cmake-doc)
  - [说明](#说明)
  - [I. cmake_minimum_required 指令](#i-cmake_minimum_required-指令)
  - [II. project 指令](#ii-project-指令)
  - [III. message 指令](#iii-message-指令)
  - [IV. set，option 指令](#iv-setoption-指令)
  - [V. configure_file 指令](#v-configure_file-指令)
  - [VI. 生成 target](#vi-生成-target)
  - [VII. 子目录](#vii-子目录)
  - [VIII. 头文件搜索路径](#viii-头文件搜索路径)
  - [IX. 动态库指令](#ix-动态库指令)
  - [X. install 指令](#x-install-指令)
  - [XI. CMAKE 常用变量](#xi-cmake-常用变量)
  - [XII. 其他信息](#xii-其他信息)

## 说明

cmake 中的关键字不区分大小写， 变量区分
建议关键字用小写， 变量用大写
多个参数中间用空格隔开

cmake 指定编译器 -G 指令
指定 mingw 编译器
cmake -G "MinGW Makefiles" ..

## I. cmake_minimum_required 指令

```cmake
cmake_minimum_required(VERSION 3.10)
```

指定所需要的 cmake 最低版本
其中:  
版本信息会存在 PROJECT_VERSION 变量中  
主版本信息存在 PROJECT_VERSION_MAJOR 变量中  
次版本信息存在 PROJECT_VERSION_MINOR 变量中

## II. project 指令

```cmake
project(demo VERSION 1.2 LANGUAGES CXX)
```

project(projectName [VERSION 1.2] [LANGUAGES CXX]): 指定项目名称及其相应信息, 一个项目有一个 project  
VERSION、LANGUAGES 两个均为可选项

## III. message 指令

```cmake
message([STATUS] message)

# STATUS 前缀为--的信息
# SEND_ERROR 产生错误，跳过生成过程
# FATAL_ERROR 产生错误，终止运行
```

## IV. set，option 指令

```cmake
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/bin)
option(DATE_ENABLE "enable date" OFF)
```

set(variable value): 设置变量的值，既可以是内置变量，也可以是自定义变量  
option(variable "帮助信息" ON/OFF): 设置变量开关, 可以在后面用于 if 条件判断

## V. configure_file 指令

```cmake
configure_file(version.in version.h)
```

configure_file(source_file, output_file): 会把原文件中的内容处理后生成到输出文件中

1. @variable@或${variable}: 会替换为 cmake 变量的值
2. #cmakedefine VAR ...: 会替换为 #define VAR ...

## VI. 生成 target

```cmake
add_executable(demo main.cpp)
add_library(demo1 STATIC main1.cpp)
add_library(demo2 SHARED main2.cpp)
```

生成目标文件  
add_executable: 可执行文件  
add_library: STATIC 静态链接库文件  
add_library: SHARED 动态链接库文件

## VII. 子目录

```cmake
aux_source_directory(dir VARIABLE)
add_subdirectory(subdir [name])
```

add_subdirecotry: 添加子目录到 cmake 当中, 子目录的 CMakeLists.txt(因此该文件必须有)

## VIII. 头文件搜索路径

```cmake
include_directories(${CMAKE_SOURCE_DIR}/include)
target_include_directories(demo [PUBLIC] ${CMAKE_SOURCE_DIR}/include)
```

include_directories: 为所有 target 添加头文件所搜路径  
target_include_directories: 进位指定 target 添加头文件搜索路径

## IX. 动态库指令

```cmake
set_target_properties(lib_name PROPERTIES OUTPUT_NAME lib_name)
target_link_libraries(demo fmt)
```

set_target_properties: 设定链接库搜索路径  
target_link_libraries: 为指定目标添加链接时动态库, 必须放在生成 target 后面

## X. install 指令

```cmake
install(TARGETS demo DESTINATION bin)
install(FILES demo DESTINATION doc)
install(PROGRAMS demo DESTINATION bin)
install(DIRECTORY demo DESTINATION src)
```

TARGETS: 目标文件  
FILES: doc 等非可执行文件  
PROGRAMS: 非目标可执行文件, 如 shell 脚本  
DIRECTORY: 目录

默认的安装位置是/usr/local 下的相对目录, 可以指定绝对路径

## XI. CMAKE 常用变量

```cmake
# PROJECT_SOURCE_DIR 项目源码路径
# PROJECT_BINARY_DIR cmake执行路径

# EXECUTABLE_OUTPUT_PATH 最终生成可执行文件的路径
set(EXECUTABLE_OUTPUT_PATH  ${PROJECT_SOURCE_DIR}/bin)
# LIBRARY_OUTPUT_PATH 最终生成链接库文件路径
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)

# CMAKE_EXE_LINKER_FLAGS 全静态链接编译
set(CMAKE_EXE_LINKER_FLAGS "-static -static-libstdc++")
# 文件安装路径
set(CMAKE_INSTALL_PREFIX)
# 生成compile_commands.json 文件,包含编译单元所执行的指令
# 引用第三方库时vim所识别必须的文件
set(CMAKE_EXPORT_COMPILE_COMMANDS on)
```

| 名称                          | 范围             | 作用                                                           |
| ----------------------------- | ---------------- | -------------------------------------------------------------- |
| EXECUTABLE_OUTPUT_PATH        | dir              | 设置最终生成可执行文件路径                                     |
| LIBRARY_OUTPUT_PATH           | dir              | 最终生成链接库文件路径                                         |
|                               |                  |
| CMAKE_EXPORT_COMPILE_COMMANDS | on\|off          | 是否生成 compile.json 文件                                     |
| CMAKE_BUILD_TYPE              | Debug \| Release | 设置可执行文件的模式,debug 或者 release 模式, 和是否按 F5 无关 |
| PROJECT_SOURCE_DIR            | dir              | 项目根路径                                                     |
| PROJECT_CURRENT_SOURCE_DIR    | dir              | 当前所在 CMakeLists.txt 文件的路径                             |
| PROJECT_BINARY_DIR            | dir              | cmake 执行的路径 ()                                            |

## XII. 其他信息

```cmake
# 通用跨平台编译器选项
if (MSVC) # 微软msvc编译器
    add_compile_options("/std:c++20") # 添加编译器选项
    add_compile_options("/source-charset:utf-8")
    add_compile_options("/execution-charset:gbk")
elseif (MINGW) # windows g++编译器
    add_compile_options(-std=c++20 -finput-charset=utf-8 -fexec-charset=gbk)
elseif (UNIX) # linux, macos 编译器
    add_compile_options(-std=c++20)
endif()
```

[CMakeLists.txt](./CMakeLists.txt)

[返回上级目录](../)
