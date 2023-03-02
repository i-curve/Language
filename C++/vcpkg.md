# vcpkg 工具的安装使用

vcpkg 是微软出的一个用于 c++项目依赖管理的工具, 上面有许多方便使用的库, 是掌握 c++开发必须会使用的一个工具

## I. 安装

vcpkg github[项目所在目录](https://github.com/microsoft/vcpkg.git)

```bash
# 克隆项目
git clone --depth=1 https://github.com/microsoft/vcpkg.git
## 注意此项目在编译完成后不能进行删除, windows一般放在 c 盘分目录, linux 可以选择放在 opt 目录下


# 运行编译,生成 vcpkg 可执行文件

## windows
.\bootstrap-vcpkg.bat

## linux
.\bootstrap-vcpkg.sh
ln -s 克隆目录/vcpkg /usr/bin
```

## II. 工具使用

- 终端整合

```sh
# 集成到终端
vcpkg integrate powershell
vcpkg integrate bash
```

- 常用命令

```bash
# 列出安装的所有包
vcpkg list

# 查找相关的包
vcpkg search xxx

# 包安装
vcpkg install xxx
## windows 下默认安装32位包, 如果下载64为需要 xxx:x64-windows

# 包删除
vcpkg remove xxx
```

其他更多常用命令请参考手册

## III. vscode,vs,clion 中集成

- vs 中进行整合, 最最方便简洁的

```powershell

vcpkg integrate install
```

- vscode, clion 中进行整合

需要添加 cmake 变量:
CMAKE_TOOLCHAIN_FILE={vcpkg 安装路径}/scripts/buildsystems/vcpkg.cmake

可以在 vscode 中设置 (setting.json) 中添加参数:

```json
  "cmake.configureSettings": {
    "CMAKE_TOOLCHAIN_FILE": "{vcpkg安装路径}/scripts/buildsystems/vcpkg.cmake"
  }
```

clion 中在文件 -> 设置 -> 构建,执行,部署 -> cmake 里面的选项中添加

```sh
-DCMAKE_TOOLCHAIN_FILE={vcpkg安装路径}\scripts\buildsystems\vcpkg.cmake
```

然后即可在 cmake 中使用

如 fmt 包使用:

```cmake
find_package(fmt CONFIG REQUIRED)

add_executable(main main.cpp)
target_link_libraries(main fmt::fmt)
```

> 注意: 在 CMakeLists.txt 文件中通过 set 设置 CMAKE_TOOLCHAIN_FILE 变量暂时没有发现起作用.
