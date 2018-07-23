---
title: Windows相关的收集贴
categories:
  - Windows
toc: false
date: 2018-06-25 20:19:29
tags:
---
摘要暂略。
<!-- more -->

### Windows下远程执行脚本的程序  
```
远程机器为Windows => powershell.exe(powershell脚本)
远程机器为Linux   => plink.exe     (     shell脚本)
```

### 设置Windows让程序崩溃时不弹窗就直接退出  
修改下面的注册表项，将其由0修改成1：
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\Windows Error Reporting\DontShowUI
```
也可以执行如下命令查询和修改
```
REG QUERY "HKEY_CURRENT_USER\Software\Microsoft\Windows\Windows Error Reporting" /v DontShowUI
REG ADD   "HKEY_CURRENT_USER\Software\Microsoft\Windows\Windows Error Reporting" /v DontShowUI /t REG_DWORD /d 1
```

### putty修改默认字体大小
`putty`的默认设置(`Default Settings`)字体是`Courier New`，还是不错的，不过大小默认是10，太小了，我们把它改成12应该就舒服了。
```
REG QUERY "HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\Default%20Settings" /v FontHeight
REG ADD   "HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\Default%20Settings" /v FontHeight /t REG_DWORD /d 12
```
