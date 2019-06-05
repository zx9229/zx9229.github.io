---
title: 'std::future和std::promise相关'
categories:
  - MyDefaultCategory
toc: false
date: 2019-06-03 17:06:39
tags:
---
略。
<!-- more -->
```c++
//c++11多线程编程（八）：std::future , std::promise和线程的返回值
//https://blog.csdn.net/lijinqi1987/article/details/78507623
//C++11之std::future和std::promise
//https://www.cnblogs.com/jiayayao/p/6527989.html
#include <future>
#include <string>
#include <iostream>
#include <chrono>
#define lambda_localtime []() {auto x = std::time(NULL); return std::put_time(std::localtime(&x), "%c"); }()
int main(int argc, char** argv)
{
    std::promise<std::string> promiseObj;
    std::future<std::string> futureObj = promiseObj.get_future();
    //////////////////////////////////////////////////////////////////////////
    //std::thread t([](std::promise<std::string>& p) {
    //    std::cout << std::this_thread::get_id() << ", beg" << std::endl;
    //    std::this_thread::sleep_for(std::chrono::seconds(5));
    //    std::cout << std::this_thread::get_id() << ", end" << std::endl;
    //    p.set_value("hello_world");
    //}, std::ref(promiseObj));
    //////////////////////////////////////////////////////////////////////////
    std::async(std::launch::async, [](std::promise<std::string>& p) {
        std::cout << std::this_thread::get_id() << ", beg, " << lambda_localtime << std::endl;
        std::this_thread::sleep_for(std::chrono::seconds(5));
        std::cout << std::this_thread::get_id() << ", end, " << lambda_localtime << std::endl;
        p.set_value("hello_world");
    }, std::ref(promiseObj));
    //////////////////////////////////////////////////////////////////////////
    std::cout << std::this_thread::get_id() << ", main, " << lambda_localtime << std::endl;
    std::string result = futureObj.get();
    std::cout << std::this_thread::get_id() << ", " << result << std::endl;
    //////////////////////////////////////////////////////////////////////////
    while (getchar() != '\n') {}
    return 0;
}
```
