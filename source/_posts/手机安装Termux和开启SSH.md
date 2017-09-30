---
title: 手机安装Termux和开启SSH
date: 2017-09-28 23:10:33
tags:
---
手机安装Termux，以及为linux环境开启SSH。

<!-- more -->

# 手机安装Termux  
Termux官网：`https://termux.com/`  
可以在"GET IT ON F-Droid"上下载到安装包。  
将".apk"文件传到Android手机上，然后安装。  

# 开启SSH

## 官方帮助文档  
[Termux Help](https://termux.com/help.html)  
[Using SSH](https://termux.com/ssh.html)  

## 安装openssh  
在手机上执行`sshd`命令，不出意外的话，该程序尚未安装。然后Termux会提示你执行一个命令以安装它。  
该命令为`pkg install openssh`。执行该命令，安装openssh。  

## 开启 SSH server  
在手机上执行`sshd`命令。  

## 查看sshd使用的端口  
在手机上执行命令`netstat -ntlp`，可以看到sshd监听了8022端口。  

## 查看手机的IP地址  
执行`ifconfig`命令。  

## 查看当前登录终端的用户名  
执行`whoami`命令。  

## 生成一对公钥和私钥  
```
cd ~/.ssh/    # 切到该目录
ls -alh       # 发现该目录是空的,或者有authorized_keys文件,但该文件的大小为0.
ssh-keygen    # 生成公私钥
ls -alh       # 发现生成了id_rsa和id_rsa.pub文件
```
说明：在手机上执行`ssh-keygen`命令，接下来的问题一律回车默认(包括Enter passphrase)，最后在"~/.ssh/"下会多出id_rsa和id_rsa.pub文件。  

## 将公钥导入信任主机列表  
```
cd ~/.ssh/
cat id_rsa.pub >>　authorized_keys
```

## 取出来生成的私钥  
有各种方式取出来它。  

### 方法1:用scp将文件发送到某Linux主机上  
```
scp -P 端口号 -r  ~/.ssh/id_rsa  用户名@IP地址:~/目录
```

### 方法2:用ftp将文件发送到某FTP服务器  
1. 搭建一个迷你FTP服务器。可以搜索"20CN Mini Ftp 服务器"并下载这个绿色单文件FTP服务器软件，然后搭建FTP服务器。  
2. 书写一个shell脚本(script.sh)，放到FTP服务器的根目录。执行脚本会将本地的id_rsa文件上传到服务器上。一个示例如下。  
```
# shell脚本需要以LF作为换行符,切勿以CRLF作为换行符.
ftp -n <<EOF
open 192.168.1.101 21
user anonymous password
binary
lcd ~/.ssh
cd  /
put id_rsa
close
quit
EOF
```
3. 用wget从FTP服务器上下载script.sh到本地。  
```
wget ftp://用户名:密码@IP地址:端口/文件的路径
wget ftp://ftp_user:ftp_pwd@127.0.0.1:21/dir1/dir2/filename
```
4. 执行`ftp`命令，不出意外的话，Termux会提示你执行`pkg install inetutils`命令以安装该软件。根据提示安装它。  
5. 以`bash script.sh`命令执行script.sh脚本，不出意外的话，会成功上传id_rsa文件到FTP服务器。  
6. 进入FTP服务器的根目录，成功得到私钥文件。  

## 将私钥配置到Xshell里或putty里  

## 在手机上安装Termius软件以方便的敲命令  
备注：Termius的旧名字是Server Auditor。  
