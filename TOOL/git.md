# git doc

- [git doc](#git-doc)
  - [I. 提交和撤销](#i-提交和撤销)
  - [II. 分支操作](#ii-分支操作)
  - [III. 日志部分](#iii-日志部分)
  - [IV. 远端仓库交互](#iv-远端仓库交互)
  - [V. 标签操作](#v-标签操作)
  - [VI. 修改内容比较](#vi-修改内容比较)
  - [VII. git 配置操作](#vii-git-配置操作)

简介: git 是一个分布式版本关系工具.用于构建项目代码

## I. 提交和撤销

- 提交操作

```bash
# 把工作区的内容放到暂存区
git add filename
# 把暂存区的内容提交
git commit -m ""
# 直接把工作区提交
git commit -am ""
```

- 撤销操作

把暂存区的拉回到工作区

```bash
# 相对于暂存区来说,撤销工作区相对暂存区的更改.
git checkout -- filename

#清空暂存区的更改
git reset HEAD filename

# 删除暂存区的文件 (git add 是无法删除已经添加过的文件的)
git rm --cached filename
```

版本回退

```bash
# 往前回退n次commit
git reset --hard HEAD~n

# 回退到指定次commit(借助reflog可以回退到任意位置
git reset --hard sha1:
```

- 暂存操作

当使用多个分支同时开发工作时, 暂存操作是必不可少的

```bash
# 展示存在的临时现场
git stash list
# 临时保存现场
git stash [save stash]
# 回退最后一次stash内容, 并从stash列表中删除
git stash pop

# 还原指定现场
git stash apply
git stash drop stash{}#删除指定现场
```

## II. 分支操作

- 基本操作

git branch -avv: 查看本和和远端所有分支信息

```bash
# 创建分支
git branch dev
# -d 删除分支, -D 强制删除(如果有commit没有提交是不让删除的)
git branch -d dev
# 分支重命名
git branch -m dev fix
# 切换分支
git checkout branch
# 合并分支
git merge dev:合并分支
# 放弃合并
git merge --abort
```

- 分支游离

可以默认是创建了一个默认名字的分支.可以用 git branch 看到

用于游离到曾经的版本,进行修改或者进行查看.修改的话不会影响现在的分支,因此不是修改人员是很难发现修改的,所以一般是在曾经的版本中创建一个新的分支

```bash
#返回曾经的分支,修改的话必须提交
git checkout sha1

#在sha1节点创建新的分支
git branch name sha1
```

## III. 日志部分

```bash
# 查看所有提交(commit)
git log
#        -数字  :显示指定的提交次数
#       --prety=online

# 查看所有git才做的日志, 只有本地有
git reglog
```

## IV. 远端仓库交互

- 获取最新代码

命令: pull = fetch+merge  
 所以如果不能快速合并的话,可以先 fetch,然后合并再提交

```bash
git clone https://  or ssh:  从远端服务器克隆仓库到本地仓库
git pull  https://    :把服务器的仓库拉到工作区
git fecch https://    : 把服务的仓库更新到本地仓库中
git push https://    :把修改后的内容更新到服务器仓库中.
```

对于多个源进行工作时的交换,体现了 git 的分布式.

```bash
# 显示远程仓库
git remote
git remote add origin https:// #

# 推送并关联分支
git push -u local remote
```

**推荐: 删除,添加远端分支**

```bash
# 把本地分支推送到远端分支
git push origin src:dest
# 删除的话src不写即可
git pull origin dest:src
```

## V. 标签操作

```bash
# 1. 查看所有tag
git tag
git show v1.1 # 查看标签v1.1 的详细信息
# 2. 打标签
git tag v1.1 # 轻量标签
git tag -a v1.1 -m "标签说明"

# 3. 提交标签
git push origin --tags # 推送所有标签
git push origin v2.0 # 推送指定标签
# 4. 删除标签
git tag -d v1.1
git push origin --delete tag v2.0 # 删除远程标签
```

git blame 追责

```bash
git blame filename
```

## VI. 修改内容比较

使用 linux 命令的 diff 和 git 的 diff 命令

linux 的 diff 比较的是文件

```bash
diff a.txt b.txt
diff -u a.txt b.txt
```

git 的 diff 比较的工作区,暂存区和对象区

```bash
git diff #比较暂存区和工作区的差异
git diff sha1 比较版本区和工作区差异
git diff --cached sha1#比较暂存区和对象区
```

## VII. git 配置操作

```bash
# 显示git项目的状态
git status
# 配置git的用户名和密码
git config --system/global/local user.name/user.email
```

```
--system   :给计算机一次性设置
--global   :给当前用户一次性设置
--local    :本地设置,只涉及到本项目
```
