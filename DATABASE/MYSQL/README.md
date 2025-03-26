# MYSQL doc

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [MYSQL doc](#mysql-doc)
  - [I. 基础知识](#i-基础知识)
    - [1. 数据引擎](#1-数据引擎)
    - [2. 字符集内容](#2-字符集内容)
    - [3. 密码加密方式](#3-密码加密方式)
  - [II. 数据库级](#ii-数据库级)
    - [1. 数据库操作](#1-数据库操作)
    - [2. 用户管理](#2-用户管理)
  - [III. 表级](#iii-表级)
    - [1. 表结构的编辑](#1-表结构的编辑)
    - [2. 内容的编辑](#2-内容的编辑)
  - [IV. 权限管理](#iv-权限管理)
  - [V. 数据库优化](#v-数据库优化)
  - [VI. 索引类型](#vi-索引类型)
  - [VII. EXPLAIN 结果说明](#vii-explain-结果说明)

<!-- /code_chunk_output -->

> 数据库初级使用部分, 用于数据库增删改查的使用

## I. 基础知识

### 1. 数据引擎

> mysql8 默认存储引擎是 InnDB: 支持事务, 行锁, 宕机重启能自动恢复数据
>
> mysql5.5 之前是 MyISAM 引擎: 不支持事务

- 使用 InnDB 数据引擎即可

### 2. 字符集内容

> mysql8 默认的字符集为 utf8mb4; 是一种比较完整的字符集
>
> mysql5.7 不是 utf8mb4, 因此创建表的时候应该加上字符集

### 3. 密码加密方式

> mysql8.0 之后密码为非 mysql_native_password, 所以简单密码的时候会导致连接失败
>
> 可以修改密码加密方式为 mysql_native_password

## II. 数据库级

### 1. 数据库操作

```mysql
# 1. 查看数据库
show databases;
show create database dbname; # 查看某一个数据库的详细信息

# 2. 创建数据库
create database dbname;
use dbname; # 切换到数据库中
```

### 2. 用户管理

mysql.user 这个表是有 host,name 共同组成了一个主键

```mysql
# 1. 创建用户
create user 'curve'@'%' identify with mysql_native_password by '123456';

# 2. 更新用户信息
# 更新mysql.user这个表即可

# 3. 删除用户
drop user 'curve'@'%';

# 4. 更改密码
alter user 'curve'@'%' identify with mysql_native_password by '123456';

# 5. 锁定账户
alter user 'curve'@'%' account lock;
# 6. 解锁账户
alter user 'curve'@'%' account unlock;

# 7. 查看用户
select host,user,account_locked from mysql.user;
```

## III. 表级

### 1. 表结构的编辑

```mysql
# 1. 创建表
create table `tbname`(`id` int)engine=InnoDB default charset=utf8mb4;
# 2. 删除表
drop table `tbname`;
# 3. 修改表
alter table `tbname` add column/drop column/modify column/ `column_name` varchar(255) not null default "";
```

### 2. 内容的编辑

```mysql
# 1. 插入记录
insert into `tbname`(id,name) values(1,'curve');

# 2. 删除记录
delete from `tbname` where id = 12;

# 3. 更新记录
update `tbname` set id = 12 where id = 1;
# 多个表的联合更新操作
update `tbname1`, `tbname2` set `tbname1`.name = `tbname2`.name where `tbname1`.id = `tbname2`.id;

# 4. 查询操作
select * from `tbname` where 条件 order by id group by name;
```

- mysql 多表联合查询中心思想: 小表驱动大表

---

> 数据库高级部分, 用于数据库管理

## IV. 权限管理

权限分为数据库权限, 表权限, 列权限

mysql.db, mysql.table_prive, mysql.table_prive

```mysql
# 1. 查看用户权限
show grants for 'curve'@'%';

# 2. 赋予用户权限
grant username on *.* to 'curve'@'%';

# 3. 回收权限
revoke username on *.* from 'curve'@'%';

##
# 赋予用户的权限默认是只能自己使用的, 如果想让用户有grant 的权限 , 需要添加参数;
```

## V. 数据库优化

数据库执行流程: 连接层-> 服务层(构建树和优化查询) -> 数据库引擎 -> 数据

数据库优化过程

1. 开机慢查询日志
2. 使用 explain 进行数据库语句分析 添加**索引**
3. show profile cpu,disk io for query 1; 查看
4. 数据库参数调优

> 索引: 索引是把该列单独组合成一组数据, 一般是 b+tree 的数据结构, 是一种排序过的数据,能够加快数据查询速度
>
> 命名规范: idx\_表名\_小驼峰的列明组合

> 索引匹配规则:
>
> 1. 最佳左前缀匹配
> 2. 索引列上不能有函数和类型转换
> 3. 范围之后全失效(between, and, in)
> 4. like 百分写最右
> 5. 忽略空值和 or
> 6. 不等于 <>, != 也会失效

## VI. 索引类型

> 聚簇索引: 主键索引( 唯一性索引) 和数据关联起来的
>
> 非聚簇索引: 普通索引, 会单独维护一个数据结构, 最低层包含了数据的 id , 最后是需要进行回表( 通过 id 去找到数据)

- 适合创建索引的情况:

  - 在 where 条件中
  - 在 group by, order by 条件红
  - 数据列的散列值比较高

- 唯一索引不能重复, 但是可以有 null

```mysql
# 1. 创建索引
create [unique] index idx_tbname_name(索引名) (`name`) on `table_name`;
# 2. 删除索引
drop index idx_tbname_name;
```

## VII. EXPLAIN 结果说明

- id: 数据执行的优先级, 越大优先级越高, 相等的话自上而下
- table: 数据执行所在的表
- type: system>const>eq_ref>ref>range>inex>all
- posibile_key: 可能用到的索引
- key: 实际用到的索引
- key_len: 实际使用索引个数的长度, 相同缩影情况下, 值越大越好
- row: 预估所需要查询的行数
- extra: using where,index/index condition; filesort(文件内排序)/ temproary( 创建临时表)
