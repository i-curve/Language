# 变量：

bash中所有变量统统是做字符型。

无浮点型，除非用外部工具

默认创建本地变量，可以用export 变为环境变量,local创建局部变量。
```bash
a=12   #这是本地变量
local a=12 #这是局部变量
export a=12 #这是系统变量
```

特殊变量：shell内置的特殊变量。

​	$?: 上一个变量的执行状态信息 0：成功  1-255：失败

# 运算： 

1. let a="3+3" 
2. a=`echo "3+3"|bc`

bc是一个强大的数值运算工具



# 常用指令:

文本三剑客：

​	grep：过滤，行。-i 忽略大小写。-o仅显示字符串本身q，v。

​	sed：文本编辑器

​	gawk：格式化文本

正则表达式

​	基本(BRE)：

​	扩展(ERE)：去掉了{}，+，？符号之前的\，是以前认知 中的正则表达式  
使用正则表达式时注意加上双引号。\\<\\>是单词的分割

read: 变量输入

```
read [option] a b
-s: 隐藏 
-p: “要显示的文字”  
-t: 倒计时 
-n: 长度 
-r：一行包括特殊符
```

grep: 过滤

```
grep [option] 文件
-i: 忽略大小写
-v: 反向显示
-o: 只显示匹配到的内容
-e: 扩展正则

-A: 后面几行
-B: 前面几行
-C: 前后几行
 
-n: 显示行号
-q: 静默显示
-c: 显示匹配几行
```

wc: 显示文件信息

```
wc [option] 文件
-l: 显示行   
-w:显示单词  
-c:显示字母
```

cut: 选取工具

```
-d: 分割符 
-f: 取第几个空间
-c: 按照字符个数
-nb: 按照字节分割，n为包括多字节
```

tr: 文本替换工具

```
tr [option] 文件
a b: 把a替换成b
-s' ': 去重
-d:删除
```

sed: 文本编辑工具

```
sed [option] 指令 文件名
option: 
-i: 修改文件
-n: 只显示修改的内容
指令:
-s: 替换
-d: 删除 
-i:行前插入
-a:行后追加
-c:整行替换

's/apple/dog/g'  :s替换，apple匹配，dog替换结果，g全局

```

sort:文本排序工具

```
sort [option] 文件
-n: 数值排序
-f: 忽略大小写
-b: 忽略前面空格
-t: 分割符 -k: 选取位置  
-r: 翻转
-u: 去重
```

uniq:-c

iptables: 防火墙

```
iptables [-t table] command chain 规则 -j Action
table: 
filter,mat,raw,mangle
commad:
-I: 插入
-D: 删除
-A: 追加
规则:
-s:源ip   -d:目的ip   -i:网卡
--sport:源端口   --dport:目标端口
-p:协议
Action:
ACCEPT:接受
DROP:拒绝
REJECT:扔掉
查看命令:
-L [chain [rulenum]]:显示链中内容
-v:显示详细信息
-n:以点分十进制显示
```

notes:iptables的四表五链

- 四表:  filter(默认过滤表),nat,raw,mongle
- 五链: prerouting,**Input,Forward,Output**(常用), prerouting

