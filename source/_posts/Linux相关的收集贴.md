---
title: Linux相关的收集贴
categories:
  - Linux
toc: false
date: 2018-06-22 21:11:52
tags:
---
摘要暂略。
<!-- more -->

### linux日志相关  
linux日志文件说明
```
/var/log/message 系统启动后的信息和错误日志，是Red Hat Linux中最常用的日志之一
/var/log/secure 与安全相关的日志信息
/var/log/maillog 与邮件相关的日志信息
/var/log/cron 与定时任务相关的日志信息
/var/log/spooler 与UUCP和news设备相关的日志信息
/var/log/boot.log 守护进程启动和停止相关的日志消息
/var/log/wtmp 该日志文件永久记录每个用户登录、注销及系统的启动、停机的事件
```
参见[linux查看系统的日志的一些实用操作 - lclc - 博客园](https://www.cnblogs.com/lcword/p/5917398.html)。  

### 查看用户登录信息  
[Linux用户登录记录日志和相关查看命令汇总](https://blog.csdn.net/jsd2honey/article/details/78404337)。

### 反向搜索执行过的命令
`Ctrl+r`: Linux的`reverse-i-search`。  
