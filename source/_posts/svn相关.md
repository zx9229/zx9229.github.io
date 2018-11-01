---
title: svn相关
categories:
  - MyDefaultCategory
toc: false
date: 2018-10-31 15:48:50
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
