# bash-complete

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [bash-complete](#bash-complete)
  - [I. 常用命令](#i-常用命令)
    - [complete](#complete)
    - [compgen](#compgen)
  - [II. bash-complete 编写](#ii-bash-complete-编写)
    - [1. 内置环境变量](#1-内置环境变量)
    - [2. 样例程序](#2-样例程序)

<!-- /code_chunk_output -->

bash-complete 是一种用户 Bash 的自动补全工具, 同步按下 tab 键, bash-complete 将尝试根据当前上下文提供可能的补全选项

## I. 常用命令

### complete

查看当前环境所有的 tab 补全脚本

```bash
complete -p
```

从 bash 环境中删除一个条目

```bash
complete -r [name]
```

想 bash 环境中添加一个条目

```bash
complete -F _func func
```

同过-F 函数指定条用 func 函数时简要调用的补全函数

### compgen

根据候选项进行删选

常用参数:
-W: 所拥有的候选项

常用写法

```bash
compgen -W "$@" -- ${COMP_WORDS[COMP_CWORD]}
```

## II. bash-complete 编写

### 1. 内置环境变量

> COMPREPLY: 将要出现的补全结果, 如果只有一个条目的话, 将会直接进行补全

> COMP_WORDS: 当前环境中所有参数组成的数组

> COMP_CWORD: 当前光标所在处的索引

可以通过 `${COMP_WORDS[COMP_CWORD]}` 获取当前光标处已经键入的单词内容, 可以配置 compgen 函数进行筛选

### 2. 样例程序

```bash
# shellcheck disable=SC2148
_proxy() {
    declare current_word
    current_word="${COMP_WORDS[COMP_CWORD]}"
    # shellcheck disable=SC2207
    if [[ ${#COMP_WORDS[@]} -le 2 ]]; then
        COMPREPLY=($(compgen -W "status on off" -- "$current_word"))
    fi
}

complete -F _proxy proxy
```
