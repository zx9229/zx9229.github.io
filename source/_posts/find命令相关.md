---
title: find命令相关
date: 2017-07-25 09:37:09
tags:
---

<!-- more -->

查找，同时忽略掉无权限的目录(其实是不显示无权限的错误消息)
```
find / -iname "*redis*" 2>&1 | grep -v "Permission denied"
find / -iname "*redis*" 2>/dev/null
```
