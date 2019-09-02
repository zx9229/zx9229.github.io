---
title: MySQL-Installer-Archived-Versions相关
categories:
  - SQL
  - MySQL
toc: false
date: 2019-08-31 17:34:39
tags:
---
略
<!-- more -->

[MySQL :: Download MySQL Installer (Archived Versions)](https://downloads.mysql.com/archives/installer/)。  
[mysql-installer-web-community-8.0.16.0.msi](https://downloads.mysql.com/archives/get/file/mysql-installer-web-community-8.0.16.0.msi)。  
[MySql 5.8 解压版安装步骤](https://blog.csdn.net/E_xiake/article/details/84951002)。  

#### 安装

* 总结
解压`mysql-8.0.16-winx64.zip`并使其能匹配到`D:\program_files_zx\mysql-8.0.16-winx64_zip\bin\mysql.exe`。  
创建`D:\program_files_zx\mysql-8.0.16-winx64_zip\my.ini`并填入下面的内容：
```ini
[mysqld]
# set basedir to your installation path
basedir=D:/program_files_zx/mysql-8.0.16-winx64_zip
# set datadir to the location of your data directory
datadir=D:/program_files_zx/mysql-8.0.16-winx64_zip/data
# https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html
# https://dev.mysql.com/doc/refman/5.7/en/load-data-local.html
# loose-local-infile = 1
```
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe --initialize --console --user=mysql`并记下`root`的临时密码。  
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe --console`用于首次启动服务端进程。  
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqladmin.exe -u root shutdown -p`用于关闭服务端进程，需输入密码。  
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe`用于启动服务端进程。  
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysql -u root -p`用于启动客户端进程，需输入密码。  
执行SQL语句`ALTER USER 'root'@'localhost' IDENTIFIED BY 'toor';`可以修改root密码到toor。  
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe --install`用于安装服务。  
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe --remove`用于删除服务。  

0. 相关链接
[Installing MySQL on Microsoft Windows](https://dev.mysql.com/doc/refman/8.0/en/windows-installation.html)。  
[Installing MySQL on Microsoft Windows Using a noinstall ZIP Archive](https://dev.mysql.com/doc/refman/8.0/en/windows-install-archive.html)。  

1. Extracting the Install Archive
解压安装归档。  

2. Creating an Option File
创建一个配置文件。  
总结：
假定我们的目录和程序可以匹配到`D:\program_files_zx\mysql-8.0.16-winx64_zip\bin\mysql.exe`，那么`BASEDIR`是`D:\program_files_zx\mysql-8.0.16-winx64_zip`，创建`BASEDIR\my.ini`并写入以下内容：
```ini
[mysqld]
# set basedir to your installation path
basedir=D:/program_files_zx/mysql-8.0.16-winx64_zip
# set datadir to the location of your data directory
datadir=D:/program_files_zx/mysql-8.0.16-winx64_zip/data
```
更多相关知识如下所述：  
[Creating an Option File](https://dev.mysql.com/doc/refman/8.0/en/windows-create-option-file.html)。  
[Creating an Option File](https://dev.mysql.com/doc/refman/8.0/en/option-files.html)。  
安装目录或数据目录的位置与默认位置不同。  
您需要调整服务器设置，例如内存、缓存、InnoDB配置信息、等。  

|File Name                       |Purpose       |
|:------------------------------:|:------------:|
|%WINDIR%\my.ini, %WINDIR%\my.cnf|Global options|
|C:\my.ini, C:\my.cnf            |Global options|
|BASEDIR\my.ini, BASEDIR\my.cnf  |Global options|
|defaults-extra-file             |The file specified with --defaults-extra-file, if any                        |
|%APPDATA%\MySQL\\.mylogin.cnf   |Login path options (clients only)                                            |
|DATADIR\mysqld-auto.cnf         |System variables persisted with SET PERSIST or SET PERSIST_ONLY (server only)|

其中`BASEDIR`表示MySQL的基本安装目录(BASEDIR represents the MySQL base installation directory.)。  
建议仅使用`my.ini`配置文件。  

3. Selecting a MySQL Server Type
选择MySQL服务器类型。  
这里我个人选择了`mysqld`。  

4. Initializing the Data Directory
初始化数据目录。  
总结：  
进入`BASEDIR`，执行`.\bin\mysqld.exe --initialize --console --user=mysql`。  
更多详细信息：  
初始化数据目录的命令不会覆盖任何现有的mysql模式表，因此在任何情况下都可以安全运行。  
帮助命令`mysqld.exe --verbose --help`。  
[Initializing the Data Directory](https://dev.mysql.com/doc/refman/8.0/en/data-directory-initialization.html)。  
[Starting and Stopping MySQL Automatically](https://dev.mysql.com/doc/refman/8.0/en/automatic-start.html)。  
[Starting MySQL as a Windows Service](https://dev.mysql.com/doc/refman/8.0/en/windows-start-service.html)。  

5. Starting the Server for the First Time
首次启动服务器。  
启动命令`.\bin\mysqld.exe --console`。  

6. Starting MySQL from the Windows Command Line
从Windows命令行启动MySQL。  
启动`.\bin\mysqld.exe`。  
关闭`.\bin\mysqladmin.exe -u root shutdown`。  

7. Customizing the PATH for MySQL Tools
将MySQL的工具程序路径添加到PATH中。  

8. Starting MySQL as a Windows Service
将MySQL作为Windows服务启动。  
安装服务(自动启动)`.\bin\mysqld.exe --install`。  
安装服务(手动启动)`.\bin\mysqld.exe --install-manual`。  
删除服务(　　　　)`.\bin\mysqld.exe --remove`。  
启动服务`sc  start  服务名`。  
启动服务`net start  服务名`。  
关闭服务`sc  stop   服务名`。  
关闭服务`net stop   服务名`。  
删除服务`sc  delete 服务名`。  

9. Testing The MySQL Installation
测试MySQL安装。  
