## 网址  
https://zx9229.github.io/

## 常用操作  
```
$ hexo new "新文章的标题"
  新建一篇文章。
$ hexo clean
  清除缓存文件 (db.json) 和已生成的静态文件 (public)。
$ hexo generate
  生成静态文件。
$ hexo deploy
  部署网站。
$ hexo server -p 4000
  启动服务器。因为指定了4000端口，所以访问网址为： http://localhost:4000/ 。
$ git add *
  将文件添加到索引库中。
$ git commit -m "message"
  提交修改内容。
$ git pull --rebase
  拉取最新的版本到本地。
$ git push
  将本地版本库的分支推送到远程服务器上。
```

## 下载版本库到本地  
```
$ mkdir /d/_FOLDER_TEMP_STORE_REPO/
$ cd    /d/_FOLDER_TEMP_STORE_REPO/
$ git clone https://github.com/zx9229/zx9229.github.io.git
$ cd ./zx9229.github.io/
$ git branch -a
$ git checkout -b my_blog remotes/origin/my_blog
$ git branch -a
$ sh auto_get_a_hexo_blog.sh
$ cd ../hexo_blog/
```
