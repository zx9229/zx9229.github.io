---
title: svn相关的收集贴
categories:
  - MyDefaultCategory
toc: false
date: 2019-07-19 11:46:38
tags:
---
摘要暂略。
<!-- more -->

#### svn解决冲突
```
[root@localhost mycode]# svn update
...(略)...
Conflict discovered in 'somepath/Makefile'.
Select: (p) postpone, (df) diff-full, (e) edit,
        (mc) mine-conflict, (tc) theirs-conflict,
        (s) show all options: s

  (e)  edit             - change merged file in an editor
  (df) diff-full        - show all changes made to merged file
  (r)  resolved         - accept merged version of file

  (dc) display-conflict - show all conflicts (ignoring merged version)
  (mc) mine-conflict    - accept my version for all conflicts (same)  # 合并内容,冲突的那一部分内容以本地为准.
  (tc) theirs-conflict  - accept their version for all conflicts (same)  # 合并内容,冲突的那一部分内容以服务器为准.

  (mf) mine-full        - accept my version of entire file (even non-conflicts)  # 完全以本地为准.
  (tf) theirs-full      - accept their version of entire file (same)  # 完全以服务器为准.

  (p)  postpone         - mark the conflict to be resolved later
  (l)  launch           - launch external tool to resolve conflict
  (s)  show all         - show this list

Select: (p) postpone, (df) diff-full, (e) edit, (r) resolved,
        (mc) mine-conflict, (tc) theirs-conflict,
        (s) show all options: tf
...(略)...
G    somepath/Makefile
...(略)...
```

#### svn命令行导出某个Revision的文件
```
C:\>svn export --help
export: Create an unversioned copy of a tree.
usage: 1. export [-r REV]   URL[@PEGREV] [PATH]
       2. export [-r REV] PATH1[@PEGREV] [PATH2]
```
例如：`svn export -r 11392 http://localhost/repos/money/trunk/test.txt C:\.`。  
