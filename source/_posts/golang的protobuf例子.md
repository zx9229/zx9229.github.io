---
title: golang的protobuf例子
categories:
  - golang
toc: false
date: 2018-08-06 23:47:12
tags:
---
略。
<!-- more -->

[Google Protocol Buffer 的使用和原理](https://www.ibm.com/developerworks/cn/linux/l-cn-gpb/index.html)。  
下面是`mytest.proto`内容
```
syntax = "proto3";

package mytest;

message HelloworldData {
    int32  id = 1;   // ID
    string str = 2;  // str
    int32  opt = 3;  //optional field
}

message Person {
    string name = 1;
    int32 id = 2;    // Unique ID number for this person.
    string email = 3;
 
    enum PhoneType {
        MOBILE = 0;
        HOME = 1;
        WORK = 2;
    }
 
    message PhoneNumber {
        string number = 1;
        PhoneType type = 2;
    }
    repeated PhoneNumber phone = 4;
}
```
对于`protoc`程序的使用：  
`protoc --help`可知：  
`Usage: protoc [OPTION] PROTO_FILES`  
`protoc  --proto_path=PATH  --go_out=OUT_DIR  PROTO_FILES`  
如果当前目录下有一个test.proto文件,那么  
`protoc  --proto_path=./  --go_out=./  ./mytest.proto`  
即可在当前目录生成`mytest.pb.go`文件。  
然后可以如下编写代码测试
```golang
package main

import (
	"fmt"
	"my_code/testProtocolBuffer/mytest"

	"github.com/golang/protobuf/proto"
)

func main() {
	persion := mytest.Person{}
	persion.Name = "zhangsan"
	persion.Phone = make([]*mytest.Person_PhoneNumber, 0)
	persion.Phone = append(persion.Phone, &mytest.Person_PhoneNumber{Number: "12312341234", Type: mytest.Person_MOBILE})
	persion.Phone = append(persion.Phone, &mytest.Person_PhoneNumber{Number: "12356785678", Type: mytest.Person_WORK})
	var err error
	var data []byte
	if data, err = proto.Marshal(&persion); err != nil {
		panic(err)
	}
	invalidData := new(mytest.HelloworldData)
	if err = proto.Unmarshal(data, invalidData); err != nil {
		fmt.Println("HelloworldData", err)
	} else {
		fmt.Println("HelloworldData", invalidData)
	}
	validData := new(mytest.Person)
	if err = proto.Unmarshal(data, validData); err != nil {
		fmt.Println("Person", err)
	} else {
		fmt.Println("Person", validData)
	}
}
```
