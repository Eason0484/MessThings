【git 端口拒绝解决方案】ssh: connect to host github.com port 22: Connection refused

s740556472 2018-05-15 10:13:46  59733  收藏 48
分类专栏： |----github 文章标签： git 22端口被拒绝 ssh协议 https协议
版权

|----github
专栏收录该内容
6 篇文章0 订阅
订阅专栏
前言
前一阵儿，在公司同步github代码到本地的时候，爆出了这样的一个错误ssh: connect to host github.com port 22: Connection refused。根据英文可以看出，ssh端口号被拒绝了，应该是被公司的网给禁掉了。

总结下如何换一种方式解决。

git 远程仓库两种协议
在解决问题之前，先要了解git远程仓库的两种协议连接

ssh协议连接github
在windows下的git客户端


在用户的.ssh下生成了两个SSH Key的秘钥对，id_rsa是私钥，不能泄露出去，id_rsa.pub是公钥，可以放心地告诉任何人。



$ ssh-keygen -t rsa -C "youremail@example.com"
1




打开本地的id_rsa.pub(公钥)，将内容复制进去即可



github端配置完毕后，看本地的git 如何添加远程仓库，以下是重头戏:

第一步,查看当前git的远程仓库版本：

$ git remote -v
1
此时若什么都没有显示说明，git无远程仓库。

第二步，添加ssh协议的远程仓库：

$ git remote add origin git@github.com:unlimitbladeworks/Data-Struts-Learning.git
1
2
再次查看

$ git remote -v
origin  git@github.com:unlimitbladeworks/Data-Struts-Learning.git (fetch)
origin  git@github.com:unlimitbladeworks/Data-Struts-Learning.git (push)
1
2
3
4
当前，我本机就是用的这种方式连接的github，好处是每次提交代码时，不需要重复来回输入用户名和密码。

使用公司网合并前一天晚上更新到github上的代码时，报出如下错误：

$ git pull origin master
ssh: connect to host github.com port 22: Connection refused
fatal: Could not read from remote repository.
1
2
3
4
得知第一种协议被禁掉后，只能换一种连接进行合并本地仓库了。继续往下看另一种协议。

切换成 https协议连接github
依然是先查看当前远程仓库使用的那种协议连接：

$ git remote -v
origin  git@github.com:unlimitbladeworks/Data-Struts-Learning.git (fetch)
origin  git@github.com:unlimitbladeworks/Data-Struts-Learning.git (push)
1
2
3
4
移除掉远程仓库的配置

$ git remote rm origin
1
重新添加新的远程仓库，以https的形式：

git remote add origin https://github.com/unlimitbladeworks/Data-Struts-Learning.git
1
再次查看:

$ git remote -v
origin  https://github.com/unlimitbladeworks/Data-Struts-Learning.git (fetch)
origin  https://github.com/unlimitbladeworks/Data-Struts-Learning.git (push)
1
2
3
4
https的地址其实就是github上项目对应的地址，如下图：


完事以上切换操作，其实问题就已经解决了。

最终结果
再次尝试pull代码，可以看到已经成功。

$ git pull origin master
remote: Counting objects: 21, done.
remote: Compressing objects: 100% (8/8), done.
Unpacking objects: 100% (21/21), done.
remote: Total 21 (delta 5), reused 21 (delta 5), pack-reused 0
From https://github.com/unlimitbladeworks/Data-Struts-Learning
 * branch            master     -> FETCH_HEAD
 * [new branch]      master     -> origin/master
————————————————
版权声明：本文为CSDN博主「s740556472」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/s740556472/article/details/80318886