---
title: 第一次使用Hexo
date: 2017-07-08 00:09:45
tags:
---
假使你的机器是Windows，你准备使用Hexo。  
建议你访问 `https://hexo.io/zh-cn/` 以学习Hexo。  
这篇文章是我写了给自己看的。  
下面是第一次使用Hexo的步骤。

# 在本地配置Hexo环境

1. 安装Git  

在Windows下安装Git其实是安装的`Git for Windows`。  
Git官网：https://git-scm.com/
Git for Windows：https://git-for-windows.github.io/

2. 为Git配置一个全局的name和email

上面说过我的name是zhangsan，email是zhangsan@163.com。  
打开`Git Bash`，执行以下命令：  

```
USERNAME@MACHINE_NAME MINGW64 ~
$ git config --global user.email "zhangsan@163.com"

USERNAME@MACHINE_NAME MINGW64 ~
$ git config --global user.name "zhangsan"

USERNAME@MACHINE_NAME MINGW64 ~
$
```

3. 安装TortoiseGit  

TortoiseGit官网：https://tortoisegit.org/

4. 安装Node.js  

Node.js官网：https://nodejs.org/en/  
`nvm does not support Windows`.  
在Windows下建议下载LTS版本的安装包进行安装。  
安装时，建议勾选`npm package manager`和`Add to PATH`以安装相应的组件和进行相应的设置。    

5. 安装Hexo  

打开`cmd`，然后执行 `npm install hexo-cli -g` 命令。其中`-g`表示全局安装。  
Hexo的英文网站：https://hexo.io/  
Hexo的中文网站：https://hexo.io/zh-cn/

6. 建站以寻找成就感  

在cmd下，将当前目录切到"D:\"下面。  
在cmd下运行命令"hexo init hexo_demo"。  
将当前目录切到"D:\hexo_demo\"下。  
在cmd下执行命令"mpm install"。  
在cmd下执行命令"hexo server"。  
在浏览器里访问`http://localhost:4000/`查看情况。  
如果一切正常的话，我们会看到一个网站，此时我们的成就感的到初步提升。  
下面是具体的命令：  
```
C:\Users\USERNAME> cd /d D:\

D:\> hexo init hexo_demo
...(略)...

D:\> cd hexo_demo

D:\hexo_demo> npm install
...(略)...

D:\hexo_demo> hexo server
INFO  Start processing
INFO  Hexo is running at http://localhost:4000/. Press Ctrl+C to stop.
```


# 一个使用Hexo的示例

## 选择一个目录作为本次示例的根文件夹

假设我们选择"D:\hexo_demo"目录作为本次示例的根目录。  
我们需要执行以下命令来初始化这个根目录。  
```
D:\> hexo init hexo_demo
D:\> cd hexo_demo
D:\hexo_demo> npm install
```

## 写一篇文章

假设这篇文章的标题为"测试Hexo"  

1. 新建一篇名为`测试Hexo`的文章  

在根目录下执行命令 `hexo new "测试Hexo"`  
此命令会自动生成一个名为"测试Hexo"的文件。  

```
D:\hexo_demo> hexo new "测试Hexo"
INFO  Created: D:\hexo_demo\source\_posts\测试Hexo.md
```

2. 编辑"测试Hexo.md"文件  

打开新生成的"测试Hexo.md"文件，保留已有的文字，继续书写文章内容即可。  

3. 启动服务器以查看效果  

在根目录下执行`hexo server`以启动服务器。  
在浏览器里访问`http://localhost:4000/`查看文章的内容和效果。  

```
D:\hexo_demo> hexo server
INFO  Start processing
INFO  Hexo is running at http://localhost:4000/. Press Ctrl+C to stop.
```

4. 生成静态文件  

我们书写了文章之后，应当将文章生成静态文件。生成命令是`hexo generate`。  
我们如果要部署网站的话，是需要将生成的html静态文件部署到网站服务器上的。  
Jekyll你把原文上传GitHub，可以直接生成博客，也可以用在线编辑器处理。Hexo是本地生成html再上传。所以Hexo要求本地环境。  

```
D:\hexo_demo> hexo generate
...(略)...

D:\hexo_demo>
```


# 部署Hexo到GitHub上

## 创建一个repository

在GitHub网页上创建一个repository。  
要创建的这个repository的名字是有规范的。  
举例：我叫张三，我在注册GitHub账号时，填写的Email为"zhangsan@163.com"，Username为"zhangsan"。  
那么，在GitHub上，我的Owner就是"zhangsan"。  
此时我要创建的repository的名字应当为"zhangsan.github.io"。  
这个repository的命名规范为`<Owner>.github.io`。  
如果不以这种方式命名，你一般会遇到一些很奇怪的现象。  
创建repository时，建议勾选`Initialize this repository with a README`，因为这个文件里可以写一些说明，起到一个提示作用。  

## 立即在这个repository上创建一个branch，随便起一个名字，比如`my_blog`  

在GitHub网页上，找到名为`<Owner>.github.io`的repository，然后在master分支上创建一个名为`my_blog`的branch。  
建议在网页上创建这个branch，简单、快捷、方便。  
用途：Hexo是利用源文件在本地生成html，然后将html上传到GitHub上。并非Jekyll那样把源文件上传到GitHub，可以直接生成博客。  
生成的html传上去了，但是原文件并不在GitHub上。这个branch是用来存储源文件和Hexo的一些配置文件的。  


## 选定一个目录作为Hexo的根目录，并新建一个网站。  

比如，我们选定"D:\hexo_data"作为Hexo的根目录。  
我们执行以下命令以初始化这个根目录，为写文章和建站做准备。  

```
D:\> hexo init hexo_data
D:\> cd hexo_data
D:\hexo_data> npm install
```

## 安装 hexo-deployer-git。

安装部署工具 hexo-deployer-git ，为后面将网站部署到GitHub上做准备。  
在"D:\hexo_data>"目录下执行`npm install hexo-deployer-git --save`命令。  
"--save"的含义：`--save: Package will appear in your dependencies.`。  
使用`npm help install`可以查看详情。  

```
D:\hexo_data> npm install hexo-deployer-git --save
...(略)...

D:\hexo_data>
```

## 修改_config.yml配置文件，使其能将网站部署到GitHub上。  
打开配置文件_config.yml，找到deploy部分，其内容可能为：
```
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type:
```
应当将其修改成
```
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo: https://github.com/zhangsan/zhangsan.github.io.git
  branch: master
```
或
```
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo: https://zhangsan@github.com/zhangsan/zhangsan.github.io.git
  branch: master
```
其中，repo的几种写法
```
仅指定用户名：https://zhangsan@github.com/zhangsan/zhangsan.github.io.git
指定用户名和密码：https://zhangsan:mima@github.com/zhangsan/zhangsan.github.io.git
其通用格式为：https://{USERNAME}:{PASSWORD}@github.com/{USERNAME}/{REPOSITORY}.git
```

## 生成静态文件并部署网站到GitHub上以查看效果。  

打开`Git Bash`，切换到根目录(/d/hexo_data)下，执行"hexo g"和"hexo d"命令。  
注意，在执行"hexo d"后，可能会让你输入用户名和密码。  
"hexo generate": 生成静态文件。  
"hexo deploy"  : 部署网站。  
```
USERNAME@MACHINE_NAME MINGW64 /d/hexo_data
$ hexo generate
...(略)...

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data
$ hexo deploy
...(略)...

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data
```
然后在浏览器输入`https://zhangsan.github.io/`查看效果。  
不出意外的话，网站已经部署到GitHub上了。  

## 从GitHub上克隆这个版本库到本地。  

打开 Git Bash ，在"/d"目录下执行clone命令，可以得到一个"zhangsan.github.io.git"文件夹。  
```
USERNAME@MACHINE_NAME MINGW64 /d
$ git clone https://github.com/zx9229/zx9229.github.io.git
...(略)...

USERNAME@MACHINE_NAME MINGW64 /d
$
```

## 将当前分支从master切换到my_blog
先列出来几个关于分支的命令
```
git branch -a    列出所有分支
git checkout -b my_blog remotes/origin/my_blog    checkout远程的my_blog分支，在本地起名为my_blog分支，并切换到本地的my_blog分支。
git checkout my_blog     切换到本地的my_blog分支。
```
我们要执行以下命令
```
USERNAME@MACHINE_NAME MINGW64 /d
$ cd zx9229.github.io/

USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io (master)
$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
  remotes/origin/my_blog

USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io (master)
$ git checkout -b my_blog remotes/origin/my_blog
Switched to a new branch 'my_blog'
Branch my_blog set up to track remote branch my_blog from origin.

USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io (my_blog)
$ git branch -a
  master
* my_blog
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
  remotes/origin/my_blog

USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io (my_blog)
$
```

## 移动 zx9229.github.io 内的所有文件到 hexo_data 下。  
```
USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io (my_blog)
$ ls -a
./  ../  .git/  README.md

USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io (my_blog)
$ mv * .[^.]* /d/hexo_data/

USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io
$ cd /d/hexo_data/

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$
```


## 编辑.gitignore文件，忽略无意义的文件。  
编辑.gitignore文件，忽略其他所有文件和文件夹，仅留下"_config.yml"和"source"文件夹。
编辑之后的.gitignore文件内容可能如下所示
```
.deploy*/
node_modules/
public/
scaffolds/
themes/
db.json
package.json
```

## 提交有意义的文件到服务器的my_blog分支下。  
```
USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$ git add *
The following paths are ignored by one of your .gitignore files:
db.json
node_modules
package.json
public
scaffolds
themes
Use -f if you really want to add them.

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$ git add -f .gitignore

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$ git commit -m "初版提交"
[my_blog c43caab] 初版提交
 3 files changed, 118 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 _config.yml
 create mode 100644 source/_posts/hello-world.md

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$ git pull --rebase
Current branch my_blog is up to date.

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$ git push
Username for 'https://github.com': zx9229
Counting objects: 7, done.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (7/7), 1.66 KiB | 0 bytes/s, done.
Total 7 (delta 0), reused 0 (delta 0)
To https://github.com/zx9229/zx9229.github.io.git
   889a6e2..c43caab  my_blog -> my_blog

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$
```
## 以后写文章并发布的步骤
```
hexo new "新文章"
hexo server
hexo generate
hexo deploy
git add *
git commit -m "提交消息"
git pull --rebase
git push
```

#  从其他地方处理这个版本库的步骤
##安装git和tortoiseGit和Node.js。
## 选定一个目录作为Hexo的根目录，并新建一个网站。
比如，我们选定D:\hexo_data作为Hexo的根目录。
执行hexo init hexo_data
cd hexo_data
npm install

## 检出版本库

## 切换分支到my_doc

## 将文件夹内的所有文件拷贝到hexo_data下。

