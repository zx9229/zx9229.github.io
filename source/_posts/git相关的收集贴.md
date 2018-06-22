---
title: git相关的收集贴
categories:
  - git
toc: false
date: 2018-06-22 18:51:33
tags:
---
使用git的过程中，遇见了一些问题，然后收集到此。
<!-- more -->


### 获取更多提示信息  

设置环境变量，获取更多提示信息：
```
# Windows
set GIT_CURL_VERBOSE=1
set GIT_TRACE_PACKET=2

# Unix
export GIT_CURL_VERBOSE=1
export GIT_TRACE_PACKET=2
```
参见[Unknown SSL protocol error in connection](https://stackoverflow.com/questions/20491027/unknown-ssl-protocol-error-in-connection)。
