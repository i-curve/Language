# pyinstall 打包

## Summary

pyinstall 是打包 python 程序为可执行文件的工具, 全平台。 需要各自平台各自安装(本平台打包的只能在本平台运行)。

打包命令:

```bash
pyinstall -F/D main.py
```

一个流程、一个本质、两种方法、两个问题.

## I. 一个流程

总共 5 个步骤:

1. 布置开发环境
2. 程序开发测试
3. 模块的导入和导出
4. 布置线上环境
5. 打包

如果最终要编译成可执行文件, 最好一开始就用重新不知一个干净的开发环境(推荐使用 anaconda 布置环境), 便于对环境的管理, 并且减少一些不必要的依赖。

模块导入导出用法：

```bash
# 导出
pip freeze > requirements.txt
# 导入
pip install -r requirements.txt
```

## II. 一个本质

打包本质是根据 filename.spce 配置文件进行打包的, 但是当使用 filename.py 文件的时候会自动生成相应的 spec 文件, 但当使用.spec 文件的话, 就会根据 spec 文件去进行打包了

```bash
pyinstall -F main.py
# 1. 先自动生成 main.spec 配置文件
# 2. 根据 main.spec 进行打包
#

pyinstall -F main.spec
```

## III. 两种方法

- 多文件打包

```bash
pyinstall -D main.py -n executable -i logo
```

根据 main.py 打包成 executable 可执行文件, 可执行文件的图标使用 logo.ico

- 单文件打包

```bash
pyinstall -F main.py -n executable -i logo
```

会把 -D 的多文件打包结果进行压缩成一个可执行文件, 此文件运行时会生成一个临时目录解包所有文件, 再执行

## IV. 两个问题

- 文件路径问题

单文件打包的程序由于会在一个临时解压目录中运行, 因此使用文件相对路径就会失效

解决方法:

```python
import os
import sys

BASE_DIR = os.path.dirname(os.path.realpath(sys.argv[0]))
```

用 BASE_DIR 拼接路径可以解决

- 模块导入问题

**多打包几次, 就有可能成功**

pyinstall 会自动解决静态方法(from, import)导入的依赖, 因此不必关心

动态导入的模块需要手动在 spec 文件中指定
