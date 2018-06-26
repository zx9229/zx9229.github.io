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
HKEY_CURRENT_USER\Software\ Microsoft\Windows\Windows Error Reporting\DontShowUI
```
