---
title: MySQL弱智记录
date: 2017-10-25 19:34:24
categories:
- MyDefaultCategory
tags:
toc: true
---

MySQL的一些最基本的信息

<!-- more -->

## MySQL  

#### 查看所有用户  
```
SELECT Host,User FROM mysql.user;
```
#### 查看所有数据库  
注: 对于MySQL而言, "database数据库"和"schema模式"是同一件事.
```
SHOW DATABASES;
SHOW SCHEMAS;
```
#### 创建数据库名  
```
CREATE DATABASE 数据库名;
```
#### 切换当前数据库  
```
USE 数据库名;
```
#### 显示当前数据库的所有表名
```
SHOW TABLES;
```
#### 查看建表语句  
```
SHOW CREATE TABLE schemas_name.table_name;
```
#### 将A表的数据upsert到B表中  
```
REPLACE INTO schemas_name.table_B (SELECT * FROM schemas_name.table_A);
REPLACE INTO schemas_name.table_B (field_1,field_2,field_3) SELECT field_1,field_2,field_3 FROM schemas_name.table_A WHERE field_1=VALUE1;
```
#### 自动创建新表B,并将表A中的数据插入到表B中  
```
CREATE TABLE schemas_name.table_B AS SELECT * FROM schemas_name.table_A;
```
#### 查询EVENTS
```
SELECT * FROM mysql.event;
SELECT * FROM information_schema.events;
```
#### 开启外部访问权限
```
SELECT *          FROM mysql.user;
SELECT host, user FROM mysql.user;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '某用户的(新)密码' WITH GRANT OPTION;
```
然后你可能会看到如下警告，大意是不赞成这样做，未来会把这个操作移除：
```
1 warning(s): 1287 Using GRANT for creating new user is deprecated and will be removed in future release. Create new user with CREATE USER statement.
1 warning(s): 1287 Using GRANT statement to modify existing user's properties other than privileges is deprecated and will be removed in future release. Use ALTER USER statement for this operation.
```

#### 备份和恢复
```
mysqldump.exe --host=127.0.0.1 --port=3306 --user=root --password=toor --result-file=./sql.sql  --databases dbName
mysql.exe     --host=127.0.0.1 --port=3306 --user=root --password=toor             < ./sql.sql
```

## MySQL Workbench  
```
执行当前行    : Ctrl+Enter
执行所有/选中 : Ctrl+Shift+Enter
```
