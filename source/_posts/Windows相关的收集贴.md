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

### openssh-portable 或 Win32-OpenSSH
[Installing SFTP/SSH Server on Windows using OpenSSH :: WinSCP](https://winscp.net/eng/docs/guide_windows_openssh_server#configuring_ssh_server)。  
[PowerShell/Win32-OpenSSH: Win32 port of OpenSSH](https://github.com/PowerShell/Win32-OpenSSH)。  
[PowerShell/openssh-portable: Portable OpenSSH](https://github.com/PowerShell/openssh-portable)。

### freeSSHd
[freeSSHd and freeFTPd - open source SSH and SFTP servers for Windows](http://www.freesshd.com/)。  
可以创建用户，让用户仅有sftp权限。非常好用。  

### 查看文件的MD5
```
certutil -hashfile -? 
certutil -hashfile 文件名 MD5
certutil -hashfile 文件名 SHA256
```

### 命令行查看程序打开的文件
它貌似不能搜索单个文件，只能显示所有文件。
```
OPENFILES /Local ON
OPENFILES /Query /FO LIST /V
```

### 限制远程桌面服务用户只能进行一个远程会话
[限制用户只能进行一个会话](https://technet.microsoft.com/zh-cn/library/cc754762.aspx)。  
[Restrict Users to a Single Session](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754762(v=ws.11))。  

### Beyond Compare 4 重置试用时间
```
REG QUERY  "HKEY_CURRENT_USER\Software\Scooter Software\Beyond Compare 4" /v CacheId
REG DELETE "HKEY_CURRENT_USER\Software\Scooter Software\Beyond Compare 4" /v CacheId
```

### 为Win10添加"在此处打开命令窗口"
在Win07下`Shift+鼠标右键`可以"在此处打开命令窗口"。  
在Win10下`Shift+鼠标右键`可以"在此处打开Powershell窗口"。  
成功执行下面的命令后，会为鼠标右键添加一个"open cmd here"选项。
```
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx\command" /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%V\""
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx"         /ve /t REG_SZ /d "open cmd here"
```

### Win10V1809默认英文输入法
`设置`>`时间和语言`>`语言`>`拼写、键入和键盘设置`>`输入`>`高级键盘设置`：  
`替代默认输入法`：`英语(美国)-美式键盘`。  
`切换输入法`：`允许我为每个应用窗口使用不同的输入法`。  
