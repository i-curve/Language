# bash 编程

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [bash 编程](#bash-编程)
  - [说明](#说明)
  - [I. 变量、数组及其运算](#i-变量-数组及其运算)
    - [1. 变量和数组](#1-变量和数组)
    - [2. 数学运算](#2-数学运算)
    - [3. 变量替换](#3-变量替换)
    - [4. 变量获取](#4-变量获取)
      - [1. `${varname:-word}`](#1-varname-word)
      - [2. `${varname:=word}`](#2-varnameword)
      - [3. `${varname:+word}`](#3-varnameword)
      - [4. `${varname:?message}`](#4-varnamemessage)
  - [II. 程序控制语句](#ii-程序控制语句)
    - [1. if 条件判断](#1-if-条件判断)
    - [2. switch 语句](#2-switch-语句)
    - [3. for 循环](#3-for-循环)
    - [4. 函数](#4-函数)
  - [III. 基本命令](#iii-基本命令)
  - [IV. 文本三剑客](#iv-文本三剑客)
    - [1. grep 文本过滤命令](#1-grep-文本过滤命令)
    - [2. sed 流文本编辑命令](#2-sed-流文本编辑命令)
    - [3. awk 文本格式化命令](#3-awk-文本格式化命令)
  - [V. mysql 相关操作](#v-mysql-相关操作)
  - [VI. 安全相关命令](#vi-安全相关命令)
  - [VII. 提高](#vii-提高)

<!-- /code_chunk_output -->

## 说明

shell 更多的侧重是 shell 命令的使用,语法部分都是比较简单的

## I. 变量、数组及其运算

### 1. 变量和数组

```bash
a=12   # 本地变量
local a=12 # 局部变量
export a=12 # 系统变量
arr=(Tmn Bob Curve) # 数组
```

shell 默认创建本地变量  
​$?: 上一个程序执行返回状态(exit code)  
shell 的数组默认下标从 0 开始, awk 从 1 开始

### 2. 数学运算

```bash
res=$((3+4))
res=`expr 5 + 3`
let res=5+3
res=$(echo "scale=0;7/2" | bc)
```

expr 符号两边有空格  
只有 bc 可以进行浮点数计算, 其他的计算都会报错  
bc 的 scale 代表最终结果的浮点数精度, 默认为 0 表示整数

### 3. 变量替换

普通字符串使用  
均支持正则表达式

```bash
## :获取字符串长度
${#variable}

## 从前向后匹配, 删除匹配到的字符。
## #  :非贪婪模式
## ## :贪婪模式
${variable#msg}
${variable##msg}

## 从后向前匹配，删除匹配到的字符串。
## %  :非贪婪模式,
## %% :贪婪模式
${variable%msg}
${variable%%msg}

## 字符串替换, 两个斜杠代表全部替换
${variable/msg/afk}
${variable//msg/afk}
```

数组的使用  
数组总两个特殊符号:  
@,\* : 代表所有数组

```bash
## 获取数组长度
${#arr[@]}

## 数组切片, 范围是 [start, end]
${#arr[@]:1:2}
```

### 4. 变量获取

`${varname-}` 变量如果不存在则为空(后面的值)
`${varname+}` 变量如果存在则为空(后面的值)

#### 1. `${varname:-word}`

语法的含义为如果 varname 存在且不为空, 则返回它的值否则返回 word. 目的是返回一个默认值

#### 2. `${varname:=word}`

语法的含义为如果 varname 存在且不为空, 则返回他得值, 否则把他设置为 word 并返回 word. 目的是设置变量默认值

#### 3. `${varname:+word}`

语法含义为如果 varname 存在且不为空, 则返回 word, 否则返回空. 目的是测试变量是否存在

#### 4. `${varname:?message}`

语法含义如果 varname 存在且不为空, 则返回他得值, 否则打印 varnmae: message, 并中断脚本执行. 目的是防止变量未定义

## II. 程序控制语句

### 1. if 条件判断

```bash
if [[ "$a" -eq "12" ]];then
    echo "a == 12";
elif [[ "$a" -eq "13" ]];then
    echo "a==13";
else
    echo "a is error";
fi
```

if 语句理解:  
if 条件;then 中的条件是指程序的返回状态码,既$?-exit 0 的值;  
test 条件: 指的是命令的输出值, 即 echo 的值

$(command)、\`expr command\`: 获取到的均为程序的输出值

### 2. switch 语句

```bash
case "$a" in
    1)
        echo "a is 1"
        ;;
    2)
        echo "a is 2"
        ;;
    *)
        echo "a is error"
        ;;
esac
```

其中每个条件后面的;;代表 break 语句,必须有, \*代表 default 匹配所有

### 3. for 循环

```bash
# 1. 普通遍历
for ((i=0;i<10;i++));do
    echo $i
done
# 输出1到5
for item in {1..5}; do echo $item;done
# 2. 遍历数组
for i in ${arr[@]};do
    echo $i
done
# 3. 遍历文件内单词
for word in $(cat file);do
    echo $word
done
# 4. 按行遍历
while IFS= read -r line; do
    echo $line;
done < file
```

### 4. 函数

```bash
function func_name() {
    echo "hello world"
    exit 0
}
```

shell 声明函数可以有 _function_ 关键字, 此时后面不必加(),也可以去掉关键字 _function_, 此时必须加()

shell 的参数通过 \$1,\$2,\$3...来获取、 返回值通过 echo "msg"来获取、return code 表示函数的执行状态， 默认是 0 代表执行成功

## III. 基本命令

- tr 命令: 字符串替换

格式: tr [option] set1 set2  
option  
-d : 用于删除字符串  
-s : 用于去重  
-c : 处理没有匹配到的字符串

将字符串 set1 范围内的字符转换为 set2 中的字符

```bash
tr 'asdf' 'qwer' #: 根据a->q,s->w,d->e,f->r进行替换
tr -d "asdf"     #: 删除asdf
tr -s ' '        #: 去重空格
tr -dc 'asdf'    #: 删除所有的非asdf字符
```

- wc 命令: 文件统计

格式: wc [option] filename  
option  
-l : 统计行数  
-w : 统计单词数  
-c : 统计字符数

- cut 命令: 选取工具

格式 cut [option] [field] [filename]  
option  
-d -f: 分隔符, 取第 n 个字段  
-c: 按照字符下标去取

- read: 读取输入

格式: read [option] a b  
option  
-s: 隐藏  
-p: “要显示的文字”  
-t: 倒计时  
-n: 长度  
-r：一行包括特殊符

- sort 命令:文本排序工具

格式: sort [option] 文件  
option  
-n: 数值排序  
-f: 忽略大小写  
-b: 忽略前面空格  
-t: 分割符 -k: 选取位置  
-r: 翻转  
-u: 去重

- find 命令: 文件查找

格式: find path [option]  
option  
-name: 只查找匹配到名字的文件  
-iname: 不区分大小写的文件名  
-type: 只查找匹配到类型的文件  
-mtime: 查找最近修改时间(天)  
-mmin: 最近修改时间(分钟)  
-mindepth: 最小路径  
-maxdepth: 最大路径  
-prune: 忽略子目录

## IV. 文本三剑客

文本三剑客：grep, sed, awk

### 1. grep 文本过滤命令

格式: grep [option] pattern 文件  
option:  
-i: 忽略大小写  
-v: 反向显示  
-o: 只显示匹配到的内容  
-E: 扩展正则

-n: 显示行号  
-q: 静默显示  
-c: 显示匹配几行

-A: 后面几行  
-B: 前面几行  
-C: 前后几行

```bash
grep -i "hello" file #: 忽略大小写, 查找 hello
```

### 2. sed 流文本编辑命令

格式: sed [option] 'command' 文件  
option:  
-i: 修改文件  
-n: 只显示修改的内容  
command:  
-p: 打印  
-i:行前插入  
-a:行后追加  
-d: 删除  
-c:整行替换  
-s: 替换

```bash
sed -n '1,3p' file #: 显示第一行到第三行
sed -i '1,3d' file #: 删除第一行到第三行
```

sed 7 中行 pattern:  
10command: 只处理第 10 行  
10,20command: 只处理 10-20 行内容  
10,+5: 只处理 10-(10+5)行内容  
/express/command: 只处理正则表达式匹配到的行  
/express1/,/express2/command: 只处理正则表达式匹配到的行区间
10,/express/command: 只处理 10-正则匹配到行的区间
/express/,10command: 只处理正则匹配到行到 10 行的区间

### 3. awk 文本格式化命令

格式: awk 'BEGIN { } // {} END { }' 文件名

```bash
# 1.
awk 'BEGIN {FS=":"}
{ arr[$1]++ }
END { for (ip in arr) { print ip,arr[ip]}}' nowcoder.txt

# 2.
awk ' {vs=vs+$5;rs+=$6} END {
print "MEM TOTAL";
printf "VSZ_SUM:%.1fM,RSS_SUM:%.3fM\n",vs/1024,rs/1024
}'
```

awk 内置变量  
FS: 文件分隔符  
RS: 行分割符  
NF: 字符段个数  
NR: 行号

$0: 当前行  
\$1~\$n: 当前行的第 n 个字段

字符串函数:  
length(variable): 获取字符, 数组长度  
split(variable, arr, n): 将 variable 分割为 n 个字符串, 并将结果存入 arr  
substr(variable, start, length): 获取 variable 中从 start 开始的 length 个字符  
index(variable, str): 获取 variable 中第一个匹配 str 的位置  
match(variable, /str/): 匹配 str 并返回匹配的下标(正则表达式)  
tolower(variable): 将 variable 转换为小写  
toupper(variable): 将 variable 转换为大写  
sub(/str/, str, variable): 替换 variable 中的 str 字符串为 str  
gsub(/str/, str, variable): 替换 variable 中的 str 字符串为 str, 并返回替换的个数

## V. mysql 相关操作

格式: mysql -uroot -hlocalhost -ppassword -Pport -Ddatabase [option]
-e "mysql 命令"  
option  
-D: 数据库名字
-N: 去掉表格字段名  
-B: 去掉 | 分隔符

```bash
# 1. 普通数据库执行
mysql -uroot -hlocalhost -p -P3306 -Dexpress -e "show tables;"
```

```txt
+-------------------+
| Tables_in_express |
+-------------------+
| employee          |
| user              |
+-------------------+
```

```bash
# 2. -N 去掉表格字段名
mysql -uroot -hlocalhost -p -P3306 -Dexpress -e "select * from user;" -N
```

```txt
+---+----------+--------------------------------------------------------------+---------+
| 1 |    admin |                                                       123456 |    NULL |
| 2 |   admins | $2a$10$wdVs4RJ3qKaDBF1nqcOGr..jc1u7/GT68ZYO/LT/xvJZZ5ulQAndm |    NULL |
| 3 | zhangsan |                                                       123456 | mybatis |
+---+----------+--------------------------------------------------------------+---------+
```

```bash
# 3. -N -B 去掉表格字段名和|分隔符
mysql -uroot -hlocalhost -p -P3306 -Dexpress -e "select * from user;" -N -B
```

```txt
1       admin   123456  NULL
2       admins  $2a$10$wdVs4RJ3qKaDBF1nqcOGr..jc1u7/GT68ZYO/LT/xvJZZ5ulQAndm    NULL
3       zhangsan        123456  mybatis
```

最终得出来的结果可以直接通过命令进行处理

## VI. 安全相关命令

- uwf: 简单防火墙

ufw 默认放行所有出流量, 禁用入流量

```shell
# 开启
ufw enable
# 关闭
ufw disable
# 查看状态
ufw status [verbose | numbered]

# 允许端口
ufw allow 22
# 允许22 tcp
ufw allow 22/tcp

# 允许特定ip连接到 22端口, tcp协议, 全写法
ufw allow from 192.168.1.2 to any port 22 proto tcp

# 删掉协议
ufw delete allow xxx(上面添加的命令)
```

- iptables: 防火墙操作相关命令

格式: iptables [-t table] -I command chain 规则 -j Action

table: filter,nat,raw,mangle

command:  
-I: 插入  
-D: 删除  
-A: 追加

规则:  
-s:源 ip -d:目的 ip -i:入口网卡 -o: 出口网卡  
--sport:源端口 --dport:目标端口  
-p:协议

Action:  
ACCEPT:接受  
DROP:拒绝  
REJECT:扔掉

查看命令:  
-n:以点分十进制显示  
-v:显示详细信息  
-L [chain [rulenum]]:显示链中内容  
--line-number: 显示规则的编号, 用于删除规则链

```bash
iptables -nvL --line-number  # 查看当前防火墙的规则

iptables -t filter -I INPUT -s 192.168.1.2 -j DROP # 禁止 192.168.1.2 的主机流量进来
iptables -D INPUT 1 # 删除 INPUT 链的第一条规则

# 禁止别的 pc ping 同自己
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP # 停止 icmp-request 的入口流量
iptables -I OUTPUT -p icmp --icmp-type [0|echo-reply] -j DROP # 停止 icmp-reply 的出口流量

# 禁止自己 ping 别的主机
iptables -A INPUT -p icmp --icmp-type echo-reply -J DROP # 禁用 echo-reply 的入口流量
iptables -I OUTPUT -p icmp --icmp-type [8|echo-request] -j DROP # 禁用 echo-request 的出口流量
```

iptables 的四表五链

四表: filter(默认过滤表),nat,raw,mongle  
五链: prerouting,**Input,Forward,Output**(常用), postrouting

扩展 icmp 消息类型:  
echo-reply: 0
echo-request: 8

## VII. 提高

[bash-complete](./COMPLETE.md)
