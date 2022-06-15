# Anaconda 如何创建新的虚拟环境

### 文章目录

- - - [1、创建虚拟环境](about:blank#1_1)
    - [2、激活与反激活虚拟环境](about:blank#2_25)
    - [3、查看虚拟环境及其他信息](about:blank#3_49)

### [](https://blog.csdn.net/weixin_42515907/article/details/103958606)1、创建虚拟环境

创建虚拟环境的目的：满足存在多个项目需要不同运行环境的情况。
创建方法：在 Anaconda Prompt 中输入

```
conda create -n virtual python=3.7

```

![在这里插入图片描述](https://img-blog.csdnimg.cn/2020011315231712.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjUxNTkwNw==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200113152401249.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjUxNTkwNw==,size_16,color_FFFFFF,t_70)
报了一个错误：CondaVerificationError:The package for vs2015_runtime located at C:\\Users\\Admin\\Anaconda3\\pkgs\\vs2015_runtime-14.16.27012-hf0eaf9b_1
appears to be corrupted. The path ‘Library/bin/ucrtbase.dll’
specified in the package manifest cannot be found.

这个错误的原因在于有些包的版本太低，将这些包清除即可，操作如下：

```
conda clean --packages --tarballs

```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200113152616950.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjUxNTkwNw==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200113152635486.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjUxNTkwNw==,size_16,color_FFFFFF,t_70)![在这里插入图片描述](https://img-blog.csdnimg.cn/20200113152752184.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjUxNTkwNw==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020011315281051.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjUxNTkwNw==,size_16,color_FFFFFF,t_70)
移除完之后重新安装：
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020011315292946.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjUxNTkwNw==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200113153012656.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjUxNTkwNw==,size_16,color_FFFFFF,t_70)

### [](https://blog.csdn.net/weixin_42515907/article/details/103958606)2、激活与反激活虚拟环境

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200113153327228.png)
表示当前虚拟环境为 base
若要切换至新的虚拟环境，以刚刚创建的 virtual 为例，

```
activate virtual

```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200113153507687.png)
可见当前虚拟环境已经改变了。
接下来就可以在自己想要的环境中安装所需要的库，以安装 tensorflow 为例

```
(virtual) C:\Users\Admin>pip install tensorflow

```

就能实现。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200113153902683.png)
该路径就能找到我们刚刚创建的新的虚拟环境。
反之，如果想回到 base 环境，操作如下：

```
(virtual) C:\Users\Admin>deactivate

```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200113154541324.png)

### [](https://blog.csdn.net/weixin_42515907/article/details/103958606)3、查看虚拟环境及其他信息

如果想要查看当前所有的虚拟环境的信息，操作如下：

```
(base) C:\Users\Admin>conda info --e

```

或者

```
(base) C:\Users\Admin>conda info -envs

```

得到下面的结果：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200113155014650.png)
这里我有三个虚拟环境，\*代表的就是当前所在的虚拟环境。
如果想要查看更多的信息，操作如下：

```
(virtual) C:\Users\Admin>conda info

```

![在这里插入图片描述](https://img-blog.csdnimg.cn/202001131554263.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjUxNTkwNw==,size_16,color_FFFFFF,t_70)

本文转自 [https://blog.csdn.net/weixin_42515907/article/details/103958606](https://blog.csdn.net/weixin_42515907/article/details/103958606)，如有侵权，请联系删除。
