# Python：Anaconda 安装虚拟环境到指定路径

anaconda 总是会把虚拟环境默认安装至 C 盘，但是 C 盘容量有限，所以目标将虚拟环境安装至其他盘。
步骤如下：

1.  通过查阅 anaconda 的文档，发现是可以进行指定路径安装的。可以输入如下命令进行查看：

```
conda create --help

```

安装虚拟环境到指定路径的命令如下：

```
conda create --prefix=F:\sofeware-s\Anaconda3\envs\pytorch2 python=3.7

```

2.  进行安装，安装完成后，提示：

```
To activate this environment, use
#
#     $ conda activate F:\sofeware-s\Anaconda3\envs\pytorch2
#
# To deactivate an active environment, use
#
#     $ conda deactivate

```

3.  查看当先的虚拟环境：

```
conda info --envs

```

![在这里插入图片描述](https://img-blog.csdnimg.cn/0d6a01ce45e440a68f17c2797901e337.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6Zeq6Zeq5Y-R5Lqu55qE5bCP5pif5pif,size_20,color_FFFFFF,t_70,g_se,x_16)
4\. 激活目标环境

```
conda activate F:\sofeware-s\Anaconda3\envs\pytorch2

```

![在这里插入图片描述](https://img-blog.csdnimg.cn/cdeee7208f39441f99791e7ec8bfa0b6.png)

本文转自 [https://blog.csdn.net/weixin_39107270/article/details/121502477](https://blog.csdn.net/weixin_39107270/article/details/121502477)，如有侵权，请联系删除。
