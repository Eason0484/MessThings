欢迎来到电脑知识学习网，专业的**电脑知识大全**学习平台！

[手机版](https://m.pc-daily.com/)

[![](https://www.pc-daily.com/static/images/logo.png)](https://www.pc-daily.com/)

 

*   [网站首页](https://www.pc-daily.com/)
*   [电脑基础](https://www.pc-daily.com/jichu/)
*   [视频教程](https://www.pc-daily.com/shipin/)
*   [操作系统](https://www.pc-daily.com/xitong/)
*   [电脑故障](https://www.pc-daily.com/guzhang/)
*   [病毒安全](https://www.pc-daily.com/anquan/)
*   [网络知识](https://www.pc-daily.com/wangluo/)
*   [电脑选购](https://www.pc-daily.com/xuangou/)
*   [软件应用](https://www.pc-daily.com/ruanjian/)

[首页](https://www.pc-daily.com/) > [操作系统](https://www.pc-daily.com/xitong/) >
----------------------------------------------------------------------------

[返回首页](https://www.pc-daily.com/)

conda删除环境中所有包（虚拟环境创建和激活与退出或删除）
==============================

[操作系统](https://www.pc-daily.com/xitong/) 发布时间：2022-01-06 15:17:50

conda是Anaconda的一个工具，主要是对包管理与环境管理。conda可以对虚拟环境进行创建、激活，退出，删除等操作。

我来分步骤说明：

1、打开Anaconda Prompt工具

输入命令：

conda env list ：显示安装的虚拟环境列表

conda list：显示当前环境安装包

![conda删除环境中所有包（虚拟环境创建和激活与退出或删除）(1)](https://img.pc-daily.com/uploads/allimg/220106/151K0DL-0.jpg)

2、你可以建立不同的虚拟环境，并在不同的虚拟环境中试炼

创建虚拟环境输入命令：

conda create -n env\_name python=3.6 这里是python的版本号，可以参看我之前的文章：

用conda安装虚拟环境

3、创建之后想用哪个虚拟环境就需要激活虚拟环境

输入命令：

(windows)conda activate env\_name

(Linux) source activate env\_name

linux没有用过命令是否有效不知道，windows我测试无误

![conda删除环境中所有包（虚拟环境创建和激活与退出或删除）(2)](https://img.pc-daily.com/uploads/allimg/220106/151K01B1-1.jpg)

激活

4、当你要返回base环境时候可以使用退出命令

（Windows）deactivate env\_name，也可以使用\`activate root\`切回root环境

（Linux）source deactivate your\_env\_name

![conda删除环境中所有包（虚拟环境创建和激活与退出或删除）(3)](https://img.pc-daily.com/uploads/allimg/220106/151K03325-2.jpg)

linux没有过不知道有效性，windows 没问题

5、当你彻底不用虚拟环境时候就可以把它删除了

conda remove -n env\_name --all 参数一定是 两个“-”，并且一定要加--all

![conda删除环境中所有包（虚拟环境创建和激活与退出或删除）(4)](https://img.pc-daily.com/uploads/allimg/220106/151K0B91-3.jpg)

删除虚拟环境

如果只是删除其中的模块可以输入命令：

conda remove --name $your\_env\_name $package\_name

[](about:blank#)[](about:blank# "分享到QQ空间")[](about:blank# "分享到新浪微博")[](about:blank# "分享到腾讯微博")[](about:blank# "分享到微信")[](about:blank# "分享到百度新首页")[](about:blank# "分享到QQ好友")[](about:blank# "分享到百度云收藏")

责任编辑：电脑知识学习网

相关阅读
----

*   [mac安装jdk及环境变量怎么配置（苹果系统安装jdk步骤）](https://www.pc-daily.com/xitong/74960.html "mac安装jdk及环境变量怎么配置（苹果系统安装jdk步骤）")
*   [cuda编程基础与实践（搭建CUDA编程环境）](https://www.pc-daily.com/wangluo/75000.html "cuda编程基础与实践（搭建CUDA编程环境）")
*   [vs2010安装教程及激活（visualstudio2010软件安装教程）](https://www.pc-daily.com/xitong/75027.html "vs2010安装教程及激活（visualstudio2010软件安装教程）")
*   [配置tomcat环境变量（Tomcat的下载及环境变量配置）](https://www.pc-daily.com/xitong/75029.html "配置tomcat环境变量（Tomcat的下载及环境变量配置）")
*   [linux配置jdk环境变量（安装jdk配置环境变量步骤和方法）](https://www.pc-daily.com/xitong/75060.html "linux配置jdk环境变量（安装jdk配置环境变量步骤和方法）")
*   [maven安装教程及环境变量配置（Maven的安装与配置详解）](https://www.pc-daily.com/xitong/75068.html "maven安装教程及环境变量配置（Maven的安装与配置详解）")
*   [linux安装redis详细教程（Linux环境下对中间件redis进行安装和配置）](https://www.pc-daily.com/wangluo/75094.html "linux安装redis详细教程（Linux环境下对中间件redis进行安装和配置）")
*   [java环境变量设置（java配置环境变量的三种方式）](https://www.pc-daily.com/xitong/75134.html "java环境变量设置（java配置环境变量的三种方式）")
*   [conda创建环境命令（conda建立及管理虚拟环境）](https://www.pc-daily.com/xitong/75141.html "conda创建环境命令（conda建立及管理虚拟环境）")
*   [测试环境搭建流程（软件测试之性能测试环境搭建）](https://www.pc-daily.com/wangluo/75161.html "测试环境搭建流程（软件测试之性能测试环境搭建）")

### 频道精选

*   [centos安装ffmpeg添加ogg音频(ffmpeg音频编码)支持操作步骤](https://www.pc-daily.com/xitong/51380.html "centos安装ffmpeg添加ogg音频(ffmpeg音频编码)支持操作步骤")**2019-03-15 08:43:40**
*   [win7系统部分便笺的元数据已被损坏怎么恢复？](https://www.pc-daily.com/xitong/39238.html "win7系统部分便笺的元数据已被损坏怎么恢复？")**2019-02-01 04:53:40**
*   [RedHat服务器上\[Errno 5\] OSError: \[Errno 2\]的解决方法](https://www.pc-daily.com/xitong/51144.html "RedHat服务器上[Errno 5] OSError: [Errno 2]的解决方法")**2019-03-14 13:03:40**
*   [Linux操作系统网络服务器模型分享](https://www.pc-daily.com/xitong/43479.html "Linux操作系统网络服务器模型分享")**2019-02-15 22:18:40**
*   [thinkpad x230i 笔记本电脑开机进入BIOS的方法(U盘启动设置方法)](https://www.pc-daily.com/xitong/41181.html "thinkpad x230i 笔记本电脑开机进入BIOS的方法(U盘启动设置方法) ") **2019-02-07 22:48:40**

*   [Centos服务器远程开机的方法](https://www.pc-daily.com/xitong/51024.html "Centos服务器远程开机的方法")**2019-03-14 03:03:40**
*   [苹果mac控制面板在哪里 苹果笔记本电脑控制面板](https://www.pc-daily.com/xitong/40412.html "苹果mac控制面板在哪里 苹果笔记本电脑控制面板打开方法图解")**2019-02-05 06:43:40**
*   [微软发布新的自动修复补丁KB3092627 可修复Win7更新](https://www.pc-daily.com/xitong/39085.html "微软发布新的自动修复补丁KB3092627 可修复Win7更新错误")**2019-01-31 16:08:40**
*   [Win7玩DNF提示图标系统组建失败如何解决?](https://www.pc-daily.com/xitong/38385.html "Win7玩DNF提示图标系统组建失败如何解决?")**2019-01-29 05:48:40**
*   [mac如何修改hosts？mac修改hosts图文教程](https://www.pc-daily.com/xitong/40858.html "mac如何修改hosts？mac修改hosts图文教程")**2019-02-06 19:53:40**

[![电脑程序关闭快捷键（一键关闭所有电脑程序）](https://img.pc-daily.com/uploads/allimg/211118/0S9141Y2-0-lp.jpg)](https://www.pc-daily.com/xitong/67675.html "电脑程序关闭快捷键（一键关闭所有电脑程序）")[电脑程序关闭快捷键（一键关闭所有电脑程序）](https://www.pc-daily.com/xitong/67675.html "电脑程序关闭快捷键（一键关闭所有电脑程序）")

[![怎么添加打印机到电脑上（台式电脑正确安装打印机方法图解）](https://img.pc-daily.com/uploads/allimg/211011/1KK12212-0-lp.jpg)](https://www.pc-daily.com/xitong/62258.html "怎么添加打印机到电脑上（台式电脑正确安装打印机方法图解）")[怎么添加打印机到电脑上（台式电脑正确安装打](https://www.pc-daily.com/xitong/62258.html "怎么添加打印机到电脑上（台式电脑正确安装打印机方法图解）")

### 操作系统

最新更新
----

*   ·[双系统怎么默认启动win10（苹果双系统设定默认启](https://www.pc-daily.com/xitong/100618.html "双系统怎么默认启动win10（苹果双系统设定默认启动为win10的方法）")
*   ·[如何升级苹果系统（ios15描述文件下载与升级教程](https://www.pc-daily.com/xitong/100617.html "如何升级苹果系统（ios15描述文件下载与升级教程）")
*   ·[怎么通过bios进去系统（各平台电脑进入bios的方法](https://www.pc-daily.com/xitong/100616.html "怎么通过bios进去系统（各平台电脑进入bios的方法）")
*   ·[华硕如何进入bios重装系统（手把手教你如何重装](https://www.pc-daily.com/xitong/100615.html "华硕如何进入bios重装系统（手把手教你如何重装系统）")
*   ·[微软原版win7系统安装教程（微软官方安装win7方法](https://www.pc-daily.com/xitong/100611.html "微软原版win7系统安装教程（微软官方安装win7方法）")
*   ·[电脑怎么做系统备份（电脑系统还原备份数据方](https://www.pc-daily.com/xitong/100606.html "电脑怎么做系统备份（电脑系统还原备份数据方法）")
*   ·[如何用系统盘分区（系统硬盘分区的方法）](https://www.pc-daily.com/xitong/100601.html "如何用系统盘分区（系统硬盘分区的方法）")
*   ·[云骑士如何制作u盘启动盘（uefibios设置u盘启动教](https://www.pc-daily.com/xitong/100598.html "云骑士如何制作u盘启动盘（uefibios设置u盘启动教程）")
*   ·[下载iso镜像后怎么装系统（win7iso镜像系统官方下](https://www.pc-daily.com/xitong/100591.html "下载iso镜像后怎么装系统（win7iso镜像系统官方下载教程）")
*   ·[怎么重装纯净版系统（安装windows系统详细步骤）](https://www.pc-daily.com/xitong/100588.html "怎么重装纯净版系统（安装windows系统详细步骤）")
*   ·[法国两名修道士烧5G基站被捕](https://www.pc-daily.com/news/59627.html "法国两名修道士烧5G基站被捕")
*   ·[中国电信控股股东拟40亿元增持](https://www.pc-daily.com/news/59494.html "中国电信控股股东拟40亿元增持")
*   ·[女子网购32次买真退假被抓](https://www.pc-daily.com/news/59436.html "女子网购32次买真退假被抓")
*   ·[iPhone13首批售罄连夜补货](https://www.pc-daily.com/news/59421.html "iPhone13首批售罄连夜补货")

*   [![centos安装ffmpeg添加ogg音频(ffmpeg音频编码)支持操作步骤](https://img.pc-daily.com/uploads/allimg/5338/151T1G07-0-lp.jpg)](https://www.pc-daily.com/xitong/51380.html "centos安装ffmpeg添加ogg音频(ffmpeg音频编码)支持操作步骤")[centos安装ffmpeg添加ogg音频(ffmpeg音频编码)支持操作](https://www.pc-daily.com/xitong/51380.html "centos安装ffmpeg添加ogg音频(ffmpeg音频编码)支持操作步骤")
*   [![RedHat服务器上[Errno 5] OSError: [Errno 2]的解决方法](https://img.pc-daily.com/uploads/allimg/4752/11135115c-0-lp.png)](https://www.pc-daily.com/xitong/51144.html "RedHat服务器上[Errno 5] OSError: [Errno 2]的解决方法")[RedHat服务器上\[Errno 5\] OSError: \[Errno 2\]的解决方法](https://www.pc-daily.com/xitong/51144.html "RedHat服务器上[Errno 5] OSError: [Errno 2]的解决方法")
*   [![苹果mac控制面板在哪里 苹果笔记本电脑控制面板打开方法图解](https://img.pc-daily.com/uploads/allimg/5002/1Z3345128-0-lp.jpg)](https://www.pc-daily.com/xitong/40412.html "苹果mac控制面板在哪里 苹果笔记本电脑控制面板打开方法图解")[苹果mac控制面板在哪里 苹果笔记本电脑控制面板](https://www.pc-daily.com/xitong/40412.html "苹果mac控制面板在哪里 苹果笔记本电脑控制面板打开方法图解")
*   [![Win7玩DNF提示图标系统组建失败如何解决?](https://img.pc-daily.com/uploads/allimg/1029/22293a145-0-lp.png)](https://www.pc-daily.com/xitong/38385.html "Win7玩DNF提示图标系统组建失败如何解决?")[Win7玩DNF提示图标系统组建失败如何解决?](https://www.pc-daily.com/xitong/38385.html "Win7玩DNF提示图标系统组建失败如何解决?")

本文转自 [https://www.pc-daily.com/xitong/75190.html](https://www.pc-daily.com/xitong/75190.html)，如有侵权，请联系删除。