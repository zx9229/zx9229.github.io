---
title: 安装Go并用VSCode配置Go开发环境
date: 2017-11-19 20:58:18
tags:
---

安装Go。配置GOPATH。使用代理安装Go的插件。  

<!-- more -->

## 安装Go  
Go的官网：[The Go Programming Language](https://golang.org/)  
在Windows下，我们可以下载最新版的安装包(此时是"go1.9.2.windows-amd64.msi")并安装它。  
它会一般会默认安装到"C:\Go\"下。同时会自动创建系统变量"GOROOT"，指向"C:\Go\"。  

## 创建GOPATH系统变量  
手动创建GOPATH系统变量，并指定一个目录，比如"C:\Go_myGOPATH\"之类的。GOPATH可以配置多个目录。  

## 为VSCode配置Go开发环境  
思路：用VSCode打开一个后缀为go的文件，使用VSCode推荐的配置。  

### 安装Go插件  
创建一个后缀为go的文件(比如test.go)并用VSCode打开。此时它会自动推荐一些插件。  
如无意外，它会推荐一个插件。插件的名字是"Go"，发布者(publisher)是"lukehoban"，简介(shortDesc)是"Rich Go language support for Visual Studio Code"。  
你可以进入这个插件的网页[Go - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=lukehoban.Go)，在"Overview"可以看到这个插件依赖了哪些工具做了哪些事。我在这里摘取了它的内容：  
```
Completion Lists (using gocode)
Signature Help (using gogetdoc or godef+godoc)
Snippets
Quick Info (using gogetdoc or godef+godoc)
Goto Definition (using gogetdoc or godef+godoc)
Find References (using guru)
Find implementations (using guru)
References CodeLens
File outline (using go-outline)
Workspace symbol search (using go-symbols)
Rename (using gorename. Note: For Undo after rename to work in Windows you need to have diff tool in your path)
Build-on-save (using go build and go test)
Lint-on-save (using golint or gometalinter)
Format on save as well as format manually (using goreturns or goimports or gofmt)
Generate unit tests skeleton (using gotests)
Add Imports (using gopkgs)
Add/Remove Tags on struct fields (using gomodifytags)
Semantic/Syntactic error reporting as you type (using gotype-live)
Run Tests under the cursor, in current file, in current package, in the whole workspace (using go test)
Show code coverage
Generate method stubs for interfaces (using impl)
[partially implemented] Debugging (using delve)
```
也就是说，在安装了这个插件之后，你还需要安装括号中的那些个程序，才能完整的使用这个插件。  

### 安装插件的依赖程序(用VSCode自动安装)  
VSCode会在顶部提示一些信息，你可以"Install All"解决。

### 安装插件的依赖程序(手动安装)  
预备知识：  
用"go get --help"可以查看详细帮助信息。其中：  
-u表示强制使用网络去更新包和它的依赖包。  
-v表示启用详细的进度和调试输出。  

#### 安装gopkgs.exe  
用VSCode打开.go文件时，会提示：  
The "gopkgs" command is not available. Use "go get -v github.com/uudashr/gopkgs/cmd/gopkgs" to install.  
使用命令`go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs`以安装它。  

#### 安装dlv.exe  
在VSCode下按F5启动调试时，会提示：  
Failed to continue: "Cannot find Delve debugger. Install from https://github.com/derekparker/delve & ensure it is in your "GOPATH/bin" or "PATH"."  
查看它在github上面的"README.md"文件，可以知道，使用命令`go get -u -v github.com/derekparker/delve/cmd/dlv`以安装它。  

#### 安装goreturns.exe  
在VSCode中按"Alt+Shift+F"(自动格式化代码)时，会提示：  
The "goreturns" command is not available. Use "go get -v sourcegraph.com/sqs/goreturns" to install.  
使用命令`go get -u -v sourcegraph.com/sqs/goreturns`以安装它。  

#### 安装godef.exe  
在VSCode中按"F12"(转到定义)时，会提示：  
The "godef" command is not available. Use "go get -v github.com/rogpeppe/godef" to install.  
执行命令`go get -u -v github.com/rogpeppe/godef`以安装它。  

#### 安装guru.exe  
在VSCode中按"Shift+F12"(查找所有引用)时，会提示：  
The "guru" command is not available. Use "go get -v golang.org/x/tools/cmd/guru" to install.  
执行命令`go get -u -v golang.org/x/tools/cmd/guru`以安装它。  

#### gorename.exe  
在VSCode中用"F2"(重命名符号)时，会提示：  
The "gorename" command is not available. Use "go get -v golang.org/x/tools/cmd/gorename" to install.  
执行命令`go get -u -v golang.org/x/tools/cmd/gorename`以安装它。  

#### 安装gocode.exe  
The "gocode" command is not available. Use "go get -v github.com/nsf/gocode" to install.  
执行命令`go get -u -v github.com/nsf/gocode`以安装它。  

#### 安装go-outline.exe  
The "go-outline" command is not available. Use "go get -v github.com/ramya-rao-a/go-outline" to install.
执行命令`go get -u -v github.com/ramya-rao-a/go-outline`以安装它。  

## 用代理方法安装软件  
有些软件需要使用代理，才能安装成功，下面是一种代理的方式。  
### 预备知识(Windows相关)  
本例中，"某环境变量名"是"MY_ENV_NAME"，"某个值"是"This is a value"。  
1. 所有的在cmd命令行下对环境变量的修改只对当前窗口有效，不是永久性的修改。也就是说当关闭此cmd命令行窗口后，将不再起作用。  
2. 在cmd下查看某环境变量("set MY_ENV_NAME")。  
3. 在cmd下设置/修改某环境变量到某个值("set MY_ENV_NAME=This is a value")。  
4. 在cmd下删除某环境变量("set MY_ENV_NAME=")。  
### 预备知识(git相关)  
git是可以允许代理服务器的。假定我们的HTTP(S)代理服务的IP端口为"127.0.0.1:1080"。  
1. 查看git的代理相关设置("git config --get-regexp .*proxy")。  
2. 设置git的代理相关设置("git config --global  http.proxy http://127.0.0.1:1080")。  
3. 设置git的代理相关设置("git config --global https.proxy http://127.0.0.1:1080")。  
4. 取消git的代理相关设置("git config --global --unset  http.proxy")。  
5. 取消git的代理相关设置("git config --global --unset https.proxy")。  
### 使用代理安装软件的步骤  
安装goreturns的命令(`go get -u -v sourcegraph.com/sqs/goreturns`)，使用代理安装的步骤如下：  
0. 我假定你的机器安装了Lantern(蓝灯)。查看它的"HTTP(S)代理服务器"的地址，我的是"127.0.0.1:30888"。  
1. 打开cmd。所有的操作都在本cmd下。敏感操作都是先改过去，再改回来。  
2. 查看Windows的"http_proxy"环境变量名(`set http_proxy`)。  
3. 设置Windows的"http_proxy"环境变量名(`set http_proxy=http://127.0.0.1:30888`)。  
4. 查看Windows的"http_proxy"环境变量名，以确认设置。  
5. 查看git的代理相关设置(`git config --get-regexp .*proxy`)。  
6. 设置git的代理相关设置(`git config --global  http.proxy http://127.0.0.1:30888`)。  
7. 设置git的代理相关设置(`git config --global https.proxy http://127.0.0.1:30888`)。  
8. 查看git的代理相关设置(`git config --get-regexp .*proxy`)，以确认设置。  
8. 执行命令(`go get -u -v sourcegraph.com/sqs/goreturns`)。  
9.  删除git的代理相关设置(`git config --global --unset  http.proxy`)。  
10. 删除git的代理相关设置(`git config --global --unset https.proxy`)。  
11. 删除Windows的"http_proxy"环境变量名(`set http_proxy=`)。  
备注：代理部分参考了[go get 获得 golang.org 的项目](https://www.cnblogs.com/ghj1976/p/5087049.html)。  
