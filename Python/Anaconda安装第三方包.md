# Anaconda 安装第三方包

不同的 python 代码需要不同的环境，配置环境非常让人头疼。anaconda 可以创建多个环境，这样可在 anaconda 中为不同的项目或者代码配置不同的环境，使用时只需进行切换即可。

然而有许多优秀的第三方包在 anaconda 中无法直接傻瓜式地安装。

在近期学习中需要安装 scikit-opt 包，经过查资料终于解决该问题。

问题解决步骤
以下以安装 geatpy 包为例，因为我已经安装了 scikit-opt

打开 anaconda prompt。

第一个即为 Anaconda Prompt

当前环境 base
(base)为当前环境。

2.将当前环境转换到需要安装的环境。

activate 环境名

转换当前环境到 de
此时已经将当前环境转换为目标环境。

3.使用 conda install 、pip 安装第三方包

在 anaconda 中有两个命令用于安装包。conda install 和 pip。

首先使用 conda 命令安装需要的包。

conda install 包名
安装成功则可以退出。

但是有许多包用 conda install 无法安装，控制台会显示没有找到包。如下：

conda 找不到包
此时需要使用 pip 命令进行安装。

pip install 包名
安装成功即可退出。

不出意外此时多数人未能安装成功，控制台又会报错。如下：

连接超时
此时换一个国内的豆瓣源即可安装成功。

pip install 包名 -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
成功安装如图所示：

打开 anaconda navigator 查看：

geatpy 已经安装到 de 环境中
注意： 1.目标环境中必须要有 pip 包。

如果没有 pip 包会调用外部的 pip 包，看似安装成功了，其实没有安装到目标环境中。

这种情况多出现在新建一个空白的环境时。

2.出现超时错误就换豆瓣源。

3.暂时就想到这两条。
