---
title: ansible和Windows相关
categories:
  - MyDefaultCategory
toc: true
date: 2018-06-29 00:14:25
tags:
---
摘要暂略。
<!-- more -->

### CentOS6安装python2的pip和python3的pip
```
CentOS安装pip
参考来源`https://github.com/shadowsocks/shadowsocks/wiki/Shadowsocks-使用说明`
`yum install python-setuptools && easy_install pip`
https://blog.csdn.net/ZhouKangClay/article/details/80745268

CentOS 6 默认安装了python 2.6，pip支持python2.6到9.0.3，在(2018-06)执行`pip install winrm`的时候，报错不再支持python2.6。
yum install python34
yum install python34-setuptools
对于`curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py`是官方链接。
源自`https://pip.pypa.io/en/stable/installing/`
所以，我们可以`wget https://bootstrap.pypa.io/get-pip.py`然后`python3 get-pip.py`然后就可以使用pip3了。
```

### CentOS6安装Python35
如果想用ansible控制Windows，那么至少需要Python35。因为`Ansible requires a minimum of Python2 version 2.6 or Python3 version 3.5.`，而`pip install pywinrm`时可以知道`pywinrm`已经不支持`Python2`了。  

CentOS6安装Python35的方法：
[技术|在 CentOS 6 系统上安装最新版 Python3 软件包的 3 种方法](https://linux.cn/article-9680-1.html)。  
我决定使用SCL安装Python35。
[Python 3.5 — Software Collections](https://www.softwarecollections.org/en/scls/rhscl/rh-python35/)。  
安装python35和ansible的全部命令如下：
```
yum install centos-release-scl
yum install rh-python35
scl enable rh-python35 bash
pip install --upgrade pip
pip install ansible
pip install cryptography
pip install pywinrm
pip install kerberos
```

### Windows设置winrm
[ansible管理windows实践 - King.left - 博客园](https://www.cnblogs.com/kingleft/p/6391652.html)。  
[【Ansible 文档】【译文】Windows 支持 - 彭玉松 - 博客园](https://www.cnblogs.com/pengyusong/p/7694201.html)。  
一个命令的格式：
```
PS C:\Windows\system32> winrm set winrm/config/service/auth @{Basic="true"}
错误: Invalid use of command line. Type "winrm -?" for help.
PS C:\Windows\system32> winrm set winrm/config/service/auth '@{Basic="true"}'
Auth
    Basic = true
    Kerberos = true
    Negotiate = true
    Certificate = false
    CredSSP = false
    CbtHardeningLevel = Relaxed

PS C:\Windows\system32>
```
上面的例子适用于`local account`而不适用于`domain account`。  

还有几个链接可以参考：
[Setting up a Windows Host — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html)。  
[python - WinRM - the specified credentials were rejected by the server - Stack Overflow](https://stackoverflow.com/questions/38105486/winrm-the-specified-credentials-were-rejected-by-the-server)。  
[Ansible and Windows: Configuring Kerberos/Active Directory authentication – Trond's Working!](https://hindenes.com/trondsworking/2015/07/27/ansible-and-windows-configuring-kerberosactive-directory-authentication/)。  
[Windows Guides — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/windows.html)。  
[authentication - Using Ansible on windows with domain user - Stack Overflow](https://stackoverflow.com/questions/41922521/using-ansible-on-windows-with-domain-user)。  
你也可以搜索`ansible domain account`进行相关寻找。  
