---
title: cxx临时收集贴
categories:
  - C/C++
toc: false
date: 2019-07-09 18:52:53
tags:
---
略。
<!-- more -->

* C++的1句话读取文件内容到字符串
```
static void filename2content(const std::string& filename, std::string& content)
{
    std::copy(std::istreambuf_iterator<char>(std::ifstream(filename).rdbuf()), std::istreambuf_iterator<char>(), std::back_inserter(content));
}
```
