---
title: git的一些命令备忘
categories:
  - git
toc: false
date: 2018-07-09 23:04:13
tags:
---
摘要暂略。
<!-- more -->

* 查看帮助  
```
git --help
git commit --help
git checkout --help
git <command> --help
```
* 查看当前状态  
`git status`

* 查看版本库上的文件  
`git ls-files`

* 查看版本库上(某目录下)的文件  
`git ls-files 某目录`

* 查看提交信息
`git log`

* 查看(某目录/某文件的)提交信息  
`git log 某目录`  
`git log 某文件`

* 查看某版本号时某文件的全部内容  
`git show REVISION:./path/to/file`  
举例：  
假设某文件为`test_file`，其路径为`./dir/test_file`，很早就把它提交到git上，很久没有改动过它了。我最近进行了一次提交(SHA-1: db22a3632a79c0b235530d025924e657809eb0ab)，我想查看这一版本时候的`test_file`的全部内容：`git show db22a3:./dir/test_file`

* 查看某版本号对某文件做了哪些修改  
`git show REVISION ./path/to/file`  
举例：  
假设某文件为`test_file`，其路径为`./dir/test_file`，我最近进行了一次提交(SHA-1: db22a3632a79c0b235530d025924e657809eb0ab)，这次提交对`test_file`和一些其他文件一并进行了修改，我想看一下这次提交对`test_file`做了哪些修改`git show db22a3 ./dir/test_file`

* 对某文件执行Revert操作  
`git checkout 文件名`  
以下随手摘录同时未经确认：  
一种是readme.txt自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；
一种是readme.txt已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态。
总之，就是让这个文件回到最近一次git commit或git add时的状态。

* 鼠标操作TortoiseGit对某文件执行Revert操作  
`git checkout HEAD </path/to/your/file>`

* 恢复单个文件到指定版本  
`git checkout <sha1-of-a-commit> </path/to/your/file>`  
备注：它好像对应的是帮助文档中的`git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>…`。

* 查看所有分支  
`git branch  -a`  
`git branch --all`

