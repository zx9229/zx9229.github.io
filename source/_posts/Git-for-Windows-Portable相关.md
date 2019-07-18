---
title: Git-for-Windows-Portable相关
categories:
  - git
toc: false
date: 2019-07-18 23:37:13
tags:
---
略。
<!-- more -->
貌似，执行`git-cmd.exe`之后，可以简单的输入`git`或`gitk`以调用`git.exe`或`gitk.exe`。  
假如我们想进入`C:\my_test\`目录。可以`git-bash.exe --cd=C:\my_test\.`。  

* 为系统环境变量添加`Git_PortableGit`系统变量
假如我们将`PortableGit\git-bash.exe`匹配到路径`C:\Program_Files_zx\PortableGit\git-bash.exe`，可以：
```
SETX /M  Git_PortableGit  "C:\Program_Files_zx\PortableGit"
```

* 为鼠标右键添加一个"open git_bash_zx here"选项(可重复执行)
```
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\git_bash_zx\command" /ve /t REG_SZ /d "\"%Git_PortableGit%\git-bash.exe\" \"--cd=%v.\""
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\git_bash_zx"         /ve /t REG_SZ /d "open git_bash_zx here"
```

* 为鼠标右键添加一个"open git_cmd_zx here"选项(可重复执行)
```
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\git_cmd_zx\command" /ve /t REG_SZ /d "\"%Git_PortableGit%\git-cmd.exe\""
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\git_cmd_zx"         /ve /t REG_SZ /d "open git_cmd_zx here"
```

* 为鼠标右键添加一个"open cmd_zx here"选项(可重复执行)
```
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx\command" /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%V\""
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx"         /ve /t REG_SZ /d "open cmd_zx here"
```

* 临时记录
```
git config --global user.email "zx@zx.com"
git config --global user.name  "zx"
git config --global --get core.autocrlf
git config --global       core.autocrlf input  # 不太建议
git config --global       core.autocrlf false  # 强烈建议
```
