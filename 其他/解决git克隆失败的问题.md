解决git使用ssh克隆失败的问题

前尘忆梦丿 2020-11-02 20:32:39  2313  收藏 6
文章标签： git ssh github
版权
git常用的两种克隆方式:
通过github代码下载获取地址




# 1
git clone https://github.com/xxx/HelloWorld.git
# 2
git clone git@github.com:xxx/HelloWorld.git
1
2
3
4
但是当我使用ssh克隆时出现了错误

1.在git bash的命令行里输入
ssh -v git@github.com
最后两行会出现

debug1: No more authentication methods to try.
git@github.com: Permission denied (publickey).
1
2
2.执行以下命令
ssh-agent -s
出现

SSH_AUTH_SOCK=/tmp/ssh-xPulfUOCtixu/agent.1928; export SSH_AUTH_SOCK;
SSH_AGENT_PID=1929; export SSH_AGENT_PID;
echo Agent pid 1929;
1
2
3
3.输入
ssh-add ~/.ssh/id_rsa 最后的id_rsa为你秘钥的key,如果你生成秘钥的时候什么都不输入直接按enter生成，最后你的key就为id_rsa。
可能会出现
Could not open a connection to your authentication agent.
此时输入
ssh-agent bash
在输入
ssh-add ~/.ssh/id_rsa
会出现

Enter passphrase for /c/Users/Admin/.ssh/id_rsa:
Identity added: /c/Users/Admin/.ssh/id_rsa (youremail@qq.com)
1
2
此时表明你已经成功了，可以使用ssh克隆了。

参考解决[git@github.com: Permission denied (publickey). Could](https://www.jianshu.com/p/7d57ce4147d3)
————————————————
版权声明：本文为CSDN博主「前尘忆梦丿」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_37866436/article/details/109456501