---
title: MySQL弱智记录
date: 2017-10-25 19:34:24
tags:
---

MySQL的一些最基本的信息

<!-- more -->

## MySQL  
### 查看所有用户  
```
SELECT Host,User FROM mysql.user;
```
### 查看所有数据库  
注: 对于MySQL而言, "database数据库"和"schema模式"是同一件事.
```
SHOW DATABASES;
SHOW SCHEMAS;
```
### 创建数据库名  
```
CREATE DATABASE 数据库名;
```
### 切换当前数据库  
```
USE 数据库名;
```
### 显示当前数据库的所有表名
```
SHOW TABLES;
```
## MySQL Workbench  
```
执行当前行    : Ctrl+Enter
执行所有/选中 : Ctrl+Shift+Enter
```
