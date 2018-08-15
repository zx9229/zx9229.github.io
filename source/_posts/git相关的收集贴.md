---
title: git相关的收集贴
categories:
  - git
toc: false
date: 2018-06-22 18:51:33
tags:
---
使用git的过程中，遇见了一些问题，然后收集到此。
<!-- more -->


### 获取更多提示信息  

设置环境变量，获取更多提示信息：
```
# Windows
set GIT_CURL_VERBOSE=1
set GIT_TRACE_PACKET=2

# Unix
export GIT_CURL_VERBOSE=1
export GIT_TRACE_PACKET=2
```
参见[Unknown SSL protocol error in connection](https://stackoverflow.com/questions/20491027/unknown-ssl-protocol-error-in-connection)。

### GIT_DISCOVERY_ACROSS_FILESYSTEM not set
```
[test@localhost ~]$ git add -f config.json
fatal: Not a git repository (or any parent up to mount point /home)
Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
[test@localhost ~]$
```
原因：你`git init`的目录(`.git`文件夹所在的目录)和"(要add的那个文件)所在的目录"不在同一个挂载点上。  
解决：`设置一个环境变量 GIT_DISCOVERY_ACROSS_FILESYSTEM=1 即可`。  

### 取消已经暂存的文件
[Git - 撤消操作](https://git-scm.com/book/zh/v2/Git-基础-撤消操作)。  
`git status 命令提示了你`怎么撤销操作：
```
[test@localhost ~]$ git add .
[test@localhost ~]$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#	new file:   config.json
#	new file:   temp.log
#
[test@localhost ~]$ git rm --cached temp.log
rm 'temp.log'
[test@localhost ~]$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#	new file:   config.json
#
[test@localhost ~]$
```
