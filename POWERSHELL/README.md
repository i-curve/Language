# powershell

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [powershell](#powershell)
  - [I. 基础](#i-基础)
    - [执行策略](#执行策略)
    - [变量类型](#变量类型)
    - [比较](#比较)
    - [逻辑运算](#逻辑运算)
  - [高级](#高级)
    - [文件和目录命令](#文件和目录命令)
    - [网络命令](#网络命令)
    - [进程和服务命令](#进程和服务命令)
    - [安全命令](#安全命令)
    - [进阶命令](#进阶命令)

<!-- /code_chunk_output -->

powershell 7 之后是根据 dotnet core 开发的, 具有跨平台功能. powershell 脚本里面不区分大小写, 包括变量和关键字

注释以 #开头

## I. 基础

### 执行策略

查看执行策略`Get-ExecutionPolicy`  
设置执行策略`Set-ExecutionPolicy xxx`

执行策略种类:

- Restricted: 所有脚本都不能执行
- AllSigned: 所有脚本都需要签名才能运行(win10 默认)
- RemoteSigned: 本地脚本可以直接运行, 网络下载的脚本需要签名
- Unrestricted: 所有脚本都能运行, 但是网络脚本会有警告
- Bypass: 所有脚本都能运行, 且没有警告

另外还有两个特殊的:

- Default: 默认 Restricted
- Undefined: 作用域的执行策略

### 变量类型

字符串

```powershell
"Hello, wordld!"
```

整形,浮点

boolean

```powershell
$true, $false
```

数组

```powershell
@("apple", "banana", "orange")
```

哈希表

```powershell
@{"name"="john"; "age"=30, "isMarried"=$false}
```

对象

### 比较

- eq: 判断相等
- nq: 判断不相等
- gt: 大于
- ge: 大于等于
- lt: 小于
- le: 小于等于
  -like 正则表达式匹配

单个值和多个值进行比较, 返回的是 boolean 值  
多个值和单个值进行比较, 返回符合条件
的值

### 逻辑运算

条件判断

```powershell
if ($age -gt 18) {
    Write-Host "your age is $age, and > 18"
} elseif ($age -lt 60) {
    Write-Host "your age < 60"
} else {
    Write-Host "---"
}
```

循环

```powershell
$array = @("apple", "banana", "orange")
foreach ($item in $array) {
Write-Host $item
}
$hash = @{"name"="John"; "age"=30; "isMarried"=$false}
foreach ($key in $hash.Keys) {
Write-Host "$key: $($hash[$key])"
}
```

```powershell
$i = 0
while ($i -lt 5) {
Write-Host $i
$i++
}
```

函数

```powershell
function Greet($name) {
Write-Host "Hello, $name!"
}
```

## 高级

powershell 的 cmelet 是以`动词-名词`的规范进行命名的  
常见的动词有:
`Get`, `Set`, `Start`, `Stop`, `Restart`, `Wait`
常见的名词有:
`Process`, `Service`, `Item`

### 文件和目录命令

```powershell
# Set-Location：切换当前目录。
Set-Location C:\Windows

# Get-ChildItem：获取目录中的文件和子目录的列表。
Get-ChildItem C:\Windows

# New-Item：创建新文件或目录。
New-Item -ItemType Directory -Path C:\Temp
New-Item -ItemType File -Path C:\Temp\test.txt

# Copy-Item：复制文件或目录。
Copy-Item C:\Temp\test.txt C:\Windows
Copy-Item C:\Temp\*.* C:\Windows

# Move-Item：移动文件或目录。
Move-Item C:\Temp\test.txt C:\Windows
Move-Item C:\Temp\*.* C:\Windows

# Remove-Item：删除文件或目录。
Remove-Item C:\Temp\test.txt
Remove-Item C:\Temp -Recurse
```

### 网络命令

Test-Connection：测试网络连接。

```powershell
Test-Connection http://google.com
```

Test-NetConnection：测试网络连接。

```powershell
Test-NetConnection http://google.com -Port 80
```

Get-NetIPAddress：获取网络接口的 IP 地址。

```powershell
Get-NetIPAddress
```

Get-NetAdapter：获取网络接口的信息。

```powershell
Get-NetAdapter
```

### 进程和服务命令

Stop-Process：停止指定的进程。

```powershell
Stop-Process -Name notepad
```

Restart-Service：重启指定的服务。

```powershell
Restart-Service -Name Spooler
```

Set-Service：设置指定服务的启动类型。

```powershell
Set-Service -Name Spooler -StartupType Automatic
```

Get-EventLog：获取事件日志的信息。

```powershell
Get-EventLog -LogName Application -Newest 10
```

### 安全命令

Get-Acl：获取文件或目录的访问控制列表。

```powershell
Get-Acl C:\Windows
```

Set-Acl：设置文件或目录的访问控制列表。

```powershell
Set-Acl C:\Windows -AclObject $acl
```

### 进阶命令

Select-Object：选择对象的属性。

```powershell
Get-Process | Select-Object Name, CPU, Memory
```

Where-Object：根据条件筛选对象。

```powershell
Get-Process | Where-Object CPU -gt 50
```

ForEach-Object：对每个对象执行操作。

```powershell
Get-ChildItem | ForEach-Object { $_.FullName }
```

Invoke-Command：在远程计算机上执行命令。

```powershell
Invoke-Command -ComputerName Server01 -ScriptBlock { Get-Process }
```
