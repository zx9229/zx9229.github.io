---
title: CentOS配置TunnelBroker的IPv6地址
date: 2018-01-28 22:45:10
categories:
- MyDefaultCategory
tags:
toc: false
---
摘要暂略。
<!-- more -->  

#### 搬运  
[Fedora/CentOS配置Tunnelbroker IPV6](https://eqblog.com/fedora-centos-set-tunnelbroker-ipv6.html)  

#### 起因  
我买了一个KVM的VPS，它有公网IPv4地址，但没有IPv6地址，我想倒腾一下IPv6玩玩，就有了这个事情。  

#### 准备  
在`https://tunnelbroker.net/`注册一个账号。然后为IPv4创建常规隧道：  
点击`Create Regular Tunnel`->在`IPv4 Endpoint (Your side)`里面输入VPS的公网IPv4地址->在`Available Tunnel Servers`里面选择一个(你认为)距离VPS最近的地方->`Create Tunnel`。那么你应当会得到类似下面的数据：  
```
* IPv6 Tunnel Endpoints
Server IPv4 Address: 72.52.104.74
Server IPv6 Address: 2001:470:1f04:329::1/64
Client IPv4 Address: 172.82.152.3               你的公网IPv4地址
Client IPv6 Address: 2001:470:1f04:329::2/64    分给你的IPv6地址
* Routed IPv6 Prefixes
Routed /64: 2001:470:1f05:329::/64
Routed /48: Assign /48
* DNS Resolvers
Anycast IPv6 Caching Nameserver: 2001:470:20::2
Anycast IPv4 Caching Nameserver: 74.82.42.42
* rDNS Delegations
rDNS Delegated NS1:
rDNS Delegated NS2:
rDNS Delegated NS3:
rDNS Delegated NS4:
rDNS Delegated NS5:
```

#### 配置CentOS的VPS  
`vi /etc/sysconfig/network`，修改或者添加以下内容：  
```
NETWORKING_IPV6=yes
IPV6_DEFAULTGW=[Server IPv6 Address] # 网页上显示的地址, 注意这里不要加 /64
```
例如  
```
NETWORKING_IPV6=yes
IPV6_DEFAULTGW=2001:470:1f04:329::1
```
假定我们想创建一个名叫tb的网卡，那么  
`vi /etc/sysconfig/network-scripts/ifcfg-tb`  
然后键入如下内容：  
```
DEVICE=tb  # 设备的名字, 因为我们为它取名为tb, 所以这里填写tb
BOOTPROTO=none
ONBOOT=yes
IPV6INIT=yes
IPV6TUNNELIPV4=[Server IPv4 Address]  # 网页上显示的地址
IPV6TUNNELIPV4LOCAL=[Client IPv4 Address]  # 网页上显示的地址, 其实就是VPS的公网地址
IPV6ADDR=[Client IPv6 Address]  # 网页上显示的地址, 注意这里要添加 /64
DNS1=[Anycast IPv6 Caching Nameserver]  # 网页上显示的地址
DNS2=[Anycast IPv4 Caching Nameserver]  # 网页上显示的地址
```
例如  
```
DEVICE=tb
BOOTPROTO=none
ONBOOT=yes
IPV6INIT=yes
IPV6TUNNELIPV4=72.52.104.74
IPV6TUNNELIPV4LOCAL=172.82.152.3
IPV6ADDR=2001:470:1f04:329::2/64
DNS1=2001:470:20::2
DNS2=74.82.42.42
```
然后`service network restart`让配置生效。  
执行`ping6 ipv6.google.com`进行测试。  

#### 备注  
* TunnelBroker应当使用了6in4的隧道技术  
  在`https://tunnelbroker.net/`的`FAQ`中能看到`IP Protocol 41`的问题。  
  而6in4就是将IPv6数据包装入IPv4数据包中，同时将IPv4数据包的IP头的IP协议号设置为41。  

* 6in4 和 6to4 和 6over4  
  https://zh.wikipedia.org/zh-hans/6in4  

* nslookup可以查询IPv6地址  
  例子: `nslookup -querytype=AAAA www.qq.com`  
  CentOS需要`yum -y install bind-utils`安装nslookup。  

* 几个链接  
  [IPv6 Global Unicast Address Assignments](https://www.iana.org/assignments/ipv6-unicast-address-assignments/ipv6-unicast-address-assignments.xhtml)  
  [ipv6_reference_card.pdf](https://www.ripe.net/participate/member-support/lir-basics/ipv6_reference_card.pdf)  
  [List of IPv6 tunnel brokers](https://en.wikipedia.org/wiki/List_of_IPv6_tunnel_brokers)  
