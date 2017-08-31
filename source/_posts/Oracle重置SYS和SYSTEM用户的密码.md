---
title: Oracle重置SYS和SYSTEM用户的密码
date: 2017-08-31 11:14:42
tags:
---

## 用管理员用户登录操作系统, 建议用`Administrator`登录操作系统.  
假如我们使用一个普通用户登录操作系统，然后以管理员身份运行PowerShell，可能会出现权限不足的情况。  
```
Windows PowerShell
版权所有 (C) 2013 Microsoft Corporation。保留所有权利。

PS C:\Windows\system32> sqlplus /nolog

SQL*Plus: Release 11.2.0.1.0 Production on 星期四 8月 31 10:09:36 2017

Copyright (c) 1982, 2010, Oracle.  All rights reserved.

SQL> conn /as sysdba
ERROR:
ORA-01031: 权限不足


SQL> exit
PS C:\Windows\system32>
```
下面是用Administrator登录操作系统后，运行PowerShell的情况。  
```
Windows PowerShell
版权所有 (C) 2013 Microsoft Corporation。保留所有权利。

PS C:\Users\Administrator>
PS C:\Users\Administrator> sqlplus /nolog

SQL*Plus: Release 11.2.0.1.0 Production on 星期四 8月 31 09:45:04 2017

Copyright (c) 1982, 2010, Oracle.  All rights reserved.

SQL> conn /as sysdba
已连接。
SQL> alter user system identified by system_pwd;

用户已更改。

SQL> exit
从 Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options 断开
PS C:\Users\Administrator>
```
