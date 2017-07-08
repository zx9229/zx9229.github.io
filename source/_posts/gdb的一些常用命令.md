---
title: gdb的一些常用命令
date: 2017-07-08 20:31:53
tags:
---
在使用gdb调试程序的过程中，有些命令是会被频繁使用的。  
对于我频繁用到的一些命令，在下面进行了举例说明。  

<!-- more -->

## 查看源代码

### 命令
```
(gdb) list                    输出从上次调用list命令开始往后的10行程序代码。
(gdb) list [file:]lineno      输出文件file的lineno行附近的10行程序代码。
(gdb) list [file:]line1,line2 输出文件file的line1到line2之间的程序代码。
(gdb) list [file:]function    输出文件file的函数function前后的10行程序代码。
```

### gdb给出的解释(输入"help all"后, 你可能找会到它的解释)
```
list -- List specified function or line
list -- 列出指定的函数或行。
```
### 例子
例：某程序有 main.cpp,my.h,my.cpp 共3个文件。
代码里有一个类MY，该类有个成员函数void MY::init()。
现在程序运行到main.cpp中了。
我想查看my.cpp中的MY::init函数，我要怎么做？
(gdb) list my.cpp:1  将list命令的默认文件切换到my.cpp中。
(gdb) list MY::init  查看默认文件里面的MY::init函数。

## 设置断点

### 命令
```
(gdb) break [file:]lineno     在文件file的第lineno行设置断点。
(gdb) break [file:]function   在文件file的函数function处(函数体里面的第一行代码所在的行号)设置断点。
```

### gdb给出的解释
```
break -- Set breakpoint at specified line or function
break -- 在指定的行或函数设置断点。
```

### 例子
例：某程序有 main.cpp,my.h,my.cpp 共3个文件。
代码里有一个类MY，该类有个成员函数void MY::init()。
现在程序运行到main.cpp中了。
我想在my.cpp中的MY::init函数处设置断点，我要怎么做？
(gdb) list my.cpp:1   将list命令的默认文件切换到my.cpp中，此时break命令的默认文件也变成my.cpp了。
(gdb) break MY::init  在默认文件的里面的MY::init函数处设置断点。

## 查看所有断点

### 命令
```
(gdb) info breakpoints(可缩写为"info b")
```

### gdb给出的解释
```
info breakpoints -- Status of user-settable breakpoints
info breakpoints -- 用户可设置的断点的状态。
```

## 下一步(相当于"F10")

### 命令
```
(gdb) next(可缩写为"n")
```

### gdb给出的解释
```
next -- Step program
next -- 步进程序。
```

## 进入函数(相当于"F11")

### 命令
```
(gdb) step(可缩写为"s")
```

### gdb给出的解释
```
step -- Step program until it reaches a different source line
step -- 步进程序，直到它到达了不同的源代码行。
```

## 跳出函数(相当于"Shift+F11")

### 命令
```
(gdb) finish
```

### gdb给出的解释
```
finish -- Execute until selected stack frame returns
finish -- 执行直到所选的堆栈帧返回。
```

## 开始运行(相当于启动调试时按"F5")

### 命令
```
(gdb) run(可缩写为"r")
```

### gdb给出的解释
```
run -- Start debugged program
run -- 开始被调试的程序。
```

## 继续运行(相当于调试过程中按"F5")

### 命令
```
(gdb) continue(可缩写为"c")
```

### gdb给出的解释
```
continue -- Continue program being debugged
continue -- 继续被调试的程序。
```

## 查看调用堆栈

### 命令
```
(gdb) backtrace(可缩写为"bt") 或 info stack
```

### gdb给出的解释
```
backtrace -- Print backtrace of all stack frames
backtrace -- 打印所有堆栈帧的追溯。
info stack -- Backtrace of the stack
info stack -- 堆栈的追溯。
```

## 调到编号为NUM的栈帧

### 命令
```
(gdb) frame <NUM>(可缩写为"f <NUM>")
```

### gdb给出的解释
```
frame -- Select and print a stack frame
frame -- 选择并打印某个栈帧。
```

## 跳出循环

### 命令
```
(gdb) until 循环之后的lineno
```

### gdb给出的解释
```
until -- Execute until the program reaches a source line greater than the current
until -- 设定一个比当前行号大的行，程序执行到该行时会被暂停住。
```

## 设置要调试的程序

### 命令
```
(gdb) file <FILE>
```

### gdb给出的解释
```
file -- Use FILE as program to be debugged
file -- 使用FILE作为程序进行调试
```

## 给gdb添加源码搜索路径

### 命令
```
(gdb) directory <DIR>(可缩写为"dir <DIR>")
```

### gdb给出的解释
```
directory -- Add directory DIR to beginning of search path for source files
directory -- 将目录DIR添加到源文件的搜索路径的开头/搜索(源文件的)路径的开头。
```

## 查看gdb的源码搜索路径

### 命令
```
(gdb) show directories(可缩写为"show dir")
```

### gdb给出的解释
```
show directories -- Current search path for finding source files
show directories -- (查找源文件的)当前搜索路径。
```

## 查看变量的值

### 命令
```
(gdb) print <EXP>
```

### gdb给出的解释
```
print -- Print value of expression EXP
print -- 显示变量或表达式的值。
```

## 显示当前工作目录

### 命令
```
(gdb) pwd
```

### gdb给出的解释
```
pwd -- Print working directory
pwd -- 显示工作目录。
```

## 查看某表达式的数据类型

### 命令
```
(gdb) whatis <EXP>
```

### gdb给出的解释
```
whatis -- Print data type of expression EXP
whatis -- 打印表达式EXP的数据类型。
```

## 显示一个类/数据结构的定义

### 命令
```
(gdb) ptype <TYPE>
```

### gdb给出的解释
```
ptype -- Print definition of type TYPE
ptype -- 显示类型TYPE的定义。
```
