---
title: 一些有用的Linux命令
date: 2017-07-13 21:21:29
tags:
---
有些Linux命令，虽然不太常用，但是值得记录下来备用。  

<!-- more -->

## (用sed)进行字符串替换  
### 命令  
```
sed    's/old_string/new_string/g' filename  # 将文件里的old_string全部替换为new_string,预览性质。
sed -i 's/old_string/new_string/g' filename  # 使用了"-i"选项就是真的修改filename了。
```
### 例子  
我们有大量的链接库，其命名规范为`Ui_NAME.dll`，比如"Ui.dll"、"Ui_fun1.dll"、"Ui_data1_to_data2.dll"。其在Linux下的命名为`libUi_NAME.so`。某配置文件configure.ini配有大量链接库的名字，其字符串格式为`value="./Ui_NAME.dll"`, 现在要将其批量替换为`value="./libUi_NAME.so"`，要怎么写替换命令。  
分析：  
sed的替换命令是支持正则表达式的，我们先写正则表达式匹配Windows下的字符串`value="./Ui_NAME.dll"`，为`value="\./Ui.*\.dll"`，我们为其分组成`(value="\./)(Ui.*\.)(dll)(")`，我们要在$1和$2之间插入"lib"，将$3替换成"so"，保留$4，如果你使用nodepad++的话，可以用正则表达式的选项将`(value="\./)(Ui.*\.)(dll)(")`替换成`$1lib$2so$4`进行测试，发现它是符合要求的。  
现在要将正则表达式整合到sed命令中去，需要将正则表达式中的元字符(在这里是小括号)和sed命令中的正斜杠进行转义，同时将`$1`替换成`\1`，然后就变成了
```
sed 's/\(value="\.\/\)\(Ui.*\.\)\(dll\)\("\)/\1lib\2so\4/g'  configure.ini
```
### 备注  
对于sed在字符串替换中的几个特殊标识符`&`和`\1`至`\9`，参见`man sed`中`s/regexpp/replacement/`部分的说明。  

## 递归查找某目录下的(包含某字符串的)所有文件，只输出文件名  
### 命令  
```
find . -type f -iname "*.h" -or -iname "*.cpp" | xargs grep -il "字符串"
grep -ril "字符串" --include="*.cpp" --include="*.h"
```
### 备注  
可以在`man find`里面搜索`-not`和`-and`和`-or`以了解这几个操作符。  

## 递归查找某目录下的(不包含某字符串的)所有文件，只输出文件名  
### 命令  
```
find . -type f ! -iname "*.h" -and ! -iname "*.cpp" | xargs grep -il "字符串"
```
### 备注
可以用"!"对"-iname '*.h'"等参数进行取反。  

