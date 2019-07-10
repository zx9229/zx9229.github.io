---
title: 'std::future和std::promise相关'
categories:
  - C/C++
toc: false
date: 2019-06-03 17:06:39
tags:
---
略。
<!-- more -->
```
//c++11多线程编程（八）：std::future , std::promise和线程的返回值
//https://blog.csdn.net/lijinqi1987/article/details/78507623
//C++11之std::future和std::promise
//https://www.cnblogs.com/jiayayao/p/6527989.html
```

* 示例1
```c++
#include <future>
#include <string>
#include <iostream>
#include <chrono>
#include <iomanip>
#define lambda_localtime []() {auto x = std::time(NULL); return std::put_time(std::localtime(&x), "%c"); }()
int main(int argc, char** argv)
{
    std::promise<std::string> promiseObj;
    std::future<std::string> futureObj = promiseObj.get_future();
    //////////////////////////////////////////////////////////////////////////
    std::thread t([](std::promise<std::string>& p) {
        std::cout << std::this_thread::get_id() << ", c_thread, beg_, " << lambda_localtime << std::endl;
        std::this_thread::sleep_for(std::chrono::seconds(5));
        std::cout << std::this_thread::get_id() << ", c_thread, end_, " << lambda_localtime << std::endl;
        p.set_value("hello_world");
    }, std::ref(promiseObj));
    std::cout << std::this_thread::get_id() << ", m_thread, main, " << lambda_localtime << std::endl;
    std::string result = futureObj.get();
    std::cout << std::this_thread::get_id() << ", m_thread, rslt: " << result << std::endl;
    //////////////////////////////////////////////////////////////////////////
    t.join();
    while (getchar() != '\n') {}
    return 0;
}
```
结果
```
14652, m_thread, main, 07/09/19 15:01:34
13836, c_thread, beg_, 07/09/19 15:01:34
13836, c_thread, end_, 07/09/19 15:01:39
14652, m_thread, rslt: hello_world
```

* 示例2
```c++
#include <future>
#include <string>
#include <iostream>
#include <chrono>
#define lambda_localtime []() {auto x = std::time(NULL); return std::put_time(std::localtime(&x), "%c"); }()
int main(int argc, char** argv)
{
    std::future<std::string> futureObj;
    //////////////////////////////////////////////////////////////////////////
    futureObj = std::async(std::launch::async, []()->std::string
    {
        std::cout << std::this_thread::get_id() << ", c_thread, beg_, " << lambda_localtime << std::endl;
        std::this_thread::sleep_for(std::chrono::seconds(5));
        std::cout << std::this_thread::get_id() << ", c_thread, end_, " << lambda_localtime << std::endl;
        return "hello_world";
    });
    //////////////////////////////////////////////////////////////////////////
    std::cout << std::this_thread::get_id() << ", m_thread, main, " << lambda_localtime << std::endl;
    std::string result = futureObj.get();
    std::cout << std::this_thread::get_id() << ", m_thread, rslt: " << result << std::endl;
    //////////////////////////////////////////////////////////////////////////
    while (getchar() != '\n') {}
    return 0;
}
```
结果
```
11052, m_thread, main, 07/09/19 14:35:22
19560, c_thread, beg_, 07/09/19 14:35:22
19560, c_thread, end_, 07/09/19 14:35:27
11052, m_thread, rslt: hello_world
```

* 示例3
```c++
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
    std::async(std::launch::async, [](std::promise<std::string>& p) {
        std::cout << std::this_thread::get_id() << ", c_thread, beg_, " << lambda_localtime << std::endl;
        std::this_thread::sleep_for(std::chrono::seconds(5));
        std::cout << std::this_thread::get_id() << ", c_thread, end_, " << lambda_localtime << std::endl;
        p.set_value("hello_world");
    }, std::ref(promiseObj));
    //////////////////////////////////////////////////////////////////////////
    std::cout << std::this_thread::get_id() << ", m_thread, main, " << lambda_localtime << std::endl;
    std::string result = futureObj.get();
    std::cout << std::this_thread::get_id() << ", m_thread, rslt: " << result << std::endl;
    //////////////////////////////////////////////////////////////////////////
    while (getchar() != '\n') {}
    return 0;
}
```
结果
```
16736, c_thread, beg_, 07/09/19 14:56:42
16736, c_thread, end_, 07/09/19 14:56:47
19560, m_thread, main, 07/09/19 14:56:47
19560, m_thread, rslt: hello_world
```
