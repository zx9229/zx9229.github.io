---
title: find命令相关
date: 2017-07-25 09:37:09
tags:
---

<!-- more -->

## 查找，同时忽略掉无权限的目录(其实是不显示无权限的错误消息)
```
find / -iname "*redis*" 2>&1 | grep -v "Permission denied"
find / -iname "*redis*" 2>/dev/null
```

## 查找在某个时间段之内被修改的文件  
方法：用touch生成两个文件，命名为newFile和oldFile。然后用`-newer`和`! -newer`选项即可成功。  
```
touch  -d    "2017-08-01 08:30:00" oldFile
touch --date="2017-08-15 08:30:00" newFile
find .    -newer oldFile            ! -newer newFile
find . \( -newer oldFile \) -and \( ! -newer newFile \)
```
`ls -l`显示的时间为"修改时间"。你可以`man ls`然后查看和尝试`-t`(sort by modification time)选项。  
```
-anewer file
       File was last accessed more recently than file was modified.
       文件的最后访问时间比file的修改时间要新。
-cnewer file
       File’s status was last changed more recently than file was modified.
       文件的状态的最后修改时间比file的修改时间要新。
-newer file
       File was modified more recently than file.
       文件的修改时间比file的修改时间要新(file_time<File_time)。
```
可以在man find的`OPERATORS`部分，找到`( expr )`,`! expr`,`-not`,`-a`,`-and`,`-o`,`-or`等运算符。  
