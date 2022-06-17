# Python 中如何更新 pip 以及解决超时的问题

## **一、pip 使用时主要存在的问题**

新手使用 Python 需要安装 pip 下的组件时，经常会遇到以下两个问题：

1、pip 版本过低

![](https://pic3.zhimg.com/v2-c5fa9045abe35bb56d6c478f2ace57e2_r.jpg)

图 1-1 提示你 pip 版本过低

2、超时

超时问题不仅会导致无法更新 pip 的版本，而且也不能安装 pip 下的组件

![](https://pic3.zhimg.com/v2-a09d13af345b8a76fd63a5216b7e3d5a_r.jpg)

图 1-2 提示你超时，资源无法下载

## **二、如何解决这两个问题**

**对于问题 1：**

更新 pip 版本即可

（1）Windos 图标+R

（2）输入 cmd

（3）在显示出来的代码后面输入：python -m pip install --upgrade pip 即可（注：一定要注意这串代码，空格不要落下）

（4）回车即可

**对于问题 2：**

更换国内镜像源即可

（1）点击我的电脑，在最上面的的文件夹窗口（位置如下图）输入 ： %APPDATA%

![](https://pic1.zhimg.com/v2-409a8d8182e82466f3b17583c28f22f4_r.jpg)

图 2-1 %APPDATA%的输入位置

（2）按回车跳转到以下目录，新建 pip 文件夹

（3）创建 pip.ini 文件（文件后缀名为 ini）

（4）编辑 pip.ini，输入以下内容，关闭即可

\[global\]

timeout = 6000

index-url = [https://pypi.tuna.tsinghua.edu.cn/simple](https://link.zhihu.com/?target=https%3A//pypi.tuna.tsinghua.edu.cn/simple)

trusted-host = [Tsinghua Open Source Mirror](https://link.zhihu.com/?target=http%3A//pypi.tuna.tsinghua.edu.cn)

（5）国内源镜像有

V2EX：[http://pypi.v2ex.com/simple](https://link.zhihu.com/?target=http%3A//pypi.v2ex.com/simple)

豆瓣：[http://pypi.douban.com/simple](https://link.zhihu.com/?target=http%3A//pypi.douban.com/simple)

中国科学技术大学：[http://pypi.mirrors.ustc.edu.cn/simple](https://link.zhihu.com/?target=http%3A//pypi.mirrors.ustc.edu.cn/simple)

清华：[https://pypi.tuna.tsinghua.edu.cn/simple](https://link.zhihu.com/?target=https%3A//pypi.tuna.tsinghua.edu.cn/simple)

（注：此处操作来自 CSDN 中微联恒通的博客，作者博客主页[CSDN-个人空间](https://link.zhihu.com/?target=https%3A//me.csdn.net/u012550867)，感谢大神指教）

![](https://pic3.zhimg.com/v2-4478c51957be7268db56475b082acf16_r.jpg)

图 2-2 解决问题的博主的 CSDN 主页

## **三、总结**

实际运用中，一定要先解决问题 2 超时的问题，解决以后，再进行 pip 的更新以及 pip 下的组件安装就不会出错了。

本文转自 [另一篇知乎专栏](https://zhuanlan.zhihu.com/p/136926866#:~:text=%E6%9B%B4%E6%96%B0pip%E7%89%88%E6%9C%AC%E5%8D%B3%E5%8F%AF%20%EF%BC%881%EF%BC%89Windos%E5%9B%BE%E6%A0%87%2BR%20%EF%BC%882%EF%BC%89%E8%BE%93%E5%85%A5cmd%20%EF%BC%883%EF%BC%89%E5%9C%A8%E6%98%BE%E7%A4%BA%E5%87%BA%E6%9D%A5%E7%9A%84%E4%BB%A3%E7%A0%81%E5%90%8E%E9%9D%A2%E8%BE%93%E5%85%A5%EF%BC%9Apython%20-m%20pip,install%20--upgrade%20pip%E5%8D%B3%E5%8F%AF%EF%BC%88%E6%B3%A8%EF%BC%9A%E4%B8%80%E5%AE%9A%E8%A6%81%E6%B3%A8%E6%84%8F%E8%BF%99%E4%B8%B2%E4%BB%A3%E7%A0%81%EF%BC%8C%E7%A9%BA%E6%A0%BC%E4%B8%8D%E8%A6%81%E8%90%BD%E4%B8%8B%EF%BC%89%20%EF%BC%884%EF%BC%89%E5%9B%9E%E8%BD%A6%E5%8D%B3%E5%8F%AF%20%E5%AF%B9%E4%BA%8E%E9%97%AE%E9%A2%982%EF%BC%9A%20%E6%9B%B4%E6%8D%A2%E5%9B%BD%E5%86%85%E9%95%9C%E5%83%8F%E6%BA%90%E5%8D%B3%E5%8F%AF)，如有侵权，请联系删除。
