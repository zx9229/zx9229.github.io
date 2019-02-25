---
title: MySQL相关记录
date: 2017-10-25 19:34:24
categories:
- SQL
tags:
toc: false
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
[MySQL导出数据库、数据库表结构、存储过程及函数【用】](https://www.cnblogs.com/qlqwjy/p/8325823.html)。
```
mysqldump.exe --host=127.0.0.1 --port=3306 --user=root --password=toor --result-file=./sql.sql  --databases dbName
mysql.exe     --host=127.0.0.1 --port=3306 --user=root --password=toor             < ./sql.sql
```
①同时导出结构以及数据时可同时省略-d和-t
②同时 不 导出结构和数据可使用-ntd
③只导出存储过程和函数可使用-R -ntd
④`导出所有(结构&数据&存储过程&函数&事件&触发器)`使用-R -E(相当于①，省略了-d -t;触发器默认导出)
⑤只导出结构&函数&事件&触发器使用 -R -E -d

#### 导出某数据库的某个表的建表语句和相应数据
`-d, --no-data       No row information.`
```
mysqldump.exe --host=127.0.0.1 --port=3306 --user=root --password=toor --result-file=./sql.sql  --databases dbName
mysqldump.exe      -h127.0.0.1      -P3306      -uroot          -ptoor             -r./sql.sql  dbName 某表
```
#### 导入
```
mysql.exe --host=127.0.0.1 --port=3306 --user=root --password=toor           < ./sql.sql
mysql.exe      -h127.0.0.1      -P3306      -uroot          -ptoor -DdbName  < ./sql.sql
```

#### 分析命令
`Explain`。

#### processlist
`show processlist`。

#### 修改密码
```
老做法: SET PASSWORD FOR <user> = PASSWORD('<plaintext_password>')    不建议了.
新做法: SET PASSWORD FOR <user> = '<plaintext_password>'
```
比如修改root的密码为toor可以`SET PASSWORD FOR root@localhost = 'toor'`。


* 用DELIMITER重定义MySQL的delimiter
[Defining Stored Programs](https://dev.mysql.com/doc/refman/8.0/en/stored-programs-defining.html)。  
本例还展示了循环操作(LOOP/WHILE)的一个写法。  
```SQL
DELIMITER $$
DROP PROCEDURE IF EXISTS `proTest`;
$$
CREATE PROCEDURE `proTest`(
    OUT o_ret_code INT,
    OUT o_ret_mesg VARCHAR(32)
)
label: BEGIN

DECLARE v_done INT DEFAULT 0;
DECLARE v_id   INT;
DECLARE v_name VARCHAR(32);
DECLARE v_age  INT;

DECLARE cur_req CURSOR FOR
    SELECT `id`, `name`, `age` FROM t_src;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

DROP TABLE IF EXISTS t_src, t_dst;
CREATE TEMPORARY TABLE t_src(`id` INT NOT NULL AUTO_INCREMENT, `name` VARCHAR(32), `age` INT, PRIMARY KEY (`id`) );
CREATE TEMPORARY TABLE t_dst(`id` INT NOT NULL AUTO_INCREMENT, `name` VARCHAR(32), `age` INT, PRIMARY KEY (`id`) );

INSERT INTO t_src (`id`,`name`,`age`) VALUES (3,'zhang3',33), (4,'li4',44), (5,'wang5',55);
-- INSERT INTO t_dst (`id`,`name`,`age`) VALUES                             (5,'wang5',55);

START TRANSACTION;

SET o_ret_code = 0, o_ret_mesg = 'SUCCESS';

OPEN cur_req;

loop_cycle1: LOOP
    FETCH cur_req INTO v_id, v_name, v_age;

    IF v_done <> 0 THEN
        LEAVE loop_cycle1;
    END IF;

    IF EXISTS (SELECT 1 FROM t_dst WHERE id=v_id) THEN
        SET o_ret_code = -1, o_ret_mesg = CONCAT("id(",v_id,") is exists");
        ROLLBACK;
        LEAVE label;
    END IF;

    INSERT INTO t_dst(`id`,`name`,`age`) SELECT v_id, v_name, v_age;
END LOOP;

COMMIT;

SELECT COUNT(*) INTO o_ret_code FROM t_dst;
SET o_ret_mesg = "COUNT_VALUE";

END;
$$
DELIMITER ;
```
执行`proTest`的命令为`CALL proTest(@r1,@r2);`和`SELECT @r1, @r2;`。

## MySQL Workbench  
```
执行当前行    : Ctrl+Enter
执行所有/选中 : Ctrl+Shift+Enter
```
