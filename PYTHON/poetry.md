# Poetry

python 环境和包管理工具

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Poetry](#poetry)
  - [1. 简单使用](#1-简单使用)

<!-- /code_chunk_output -->

## 1. 简单使用

- 安装

```bash
pip install poetry
```

```bash
# 初始化项目
poetry new demo

# 在已经初始化的目录中初始化项目
poetry init

# 添加以来
poetry add package
```

> poetry 会使用外部 python 环境, 本身并不会安装 python 解释器

```bash
# 激活 poetry 相关的环境
poetry shell
```

> poetry.lock 是一个锁文件, 用于确定项目中特定包的版本, 作为应用程序开发人员, 这个文件应该放到版本控制中, 作为第三方包开发者, 这个应该忽略在版本控制中, 以便于最终运行环境能更好的处理所有包的依赖

```shell

# 添加删除包
poetry add package --group [可选组]
poetry remove package --group [可选组]

# 安装项目依赖项
poetry install  --with [可选组]

# 这个命令会根据pyproject.toml 重新构建 poetry.lock 文件, 升级里面对应包的相应的最新版本
poetry update
```
