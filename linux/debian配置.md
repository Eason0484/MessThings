# [从CentOS转Debian的思考 - 简书 (jianshu.com)](https://www.jianshu.com/p/0e1ce30e06d2)

[![](https://cdn2.jianshu.io/assets/default_avatar/11-4d7c6ca89f439111aff57b23be1c73ba.jpg)](https://www.jianshu.com/u/8e9929a1e26b)

[code猪](https://www.jianshu.com/u/8e9929a1e26b)

接触Linux到现在已有五年。刚开始使用的是Ubuntu，那时候的界面还是Gnome2，和windows界面比较类似。除了命令行使用不习惯外，其他也没有什么特别。当然，那也只是作为一个玩具罢了。后来需要Linux作为科研环境，开始使用CentOS。她比Ubuntu更稳定，当然更简洁，没有花哨的界面、特效，特别适合作服务器系统使用，实验室的服务器系统都选择CentOS。

然后自己对CentOS特别熟悉，除了不能打游戏外，其它都能满足。特别满意的是，使用CentOS作为桌面系统后再也不需要应付：弹窗、被QQ打扰、流氓软件和杀毒软件。使用CentOS作为桌面系统的另外两个非常大的好处是文档处理和编程特别方便。

使用CentOS有两个比较大的缺点：

* 为求稳定，软件和库比较旧
* 没有很好用的输入法，如搜狗输入法、谷歌输入法，当然我也尝试过安装fcitx，但bug特别多

后来，又尝试了其他的发行版，如Fedora、Archlinux等等。发现他们都不能完美符合自己的要求。Debian号称Linux发行版之源，很多发行版都是基于Debian修改的，如大名鼎鼎的Ubuntu。安装过好几次都不能很好的安装一些软件，如为知笔记和搜狗输入法，又放弃了。

经过思考，问题不在于选择CentOS还是Debian，而在于自己没有尽力去尝试解决出现的问题。**没有尽力尝试，遇到问题就思考着放弃，选择原来保守方法，就不会有突破，也不能认识问题的本质，更不能创新。**Linux各个发行版只是安装的库版本不同，内核还是一样的。因此，我又安装一次Debian，并选择最新的版本Debian9。将每个需要的软件都尝试安装，如为知笔记、Calibre、Xmind、WPS等等。遇到问题就百度和谷歌，并将其一一解决。

然后，我的桌面系统变成了Debian，她和CentOS7没有很大的区别，都是Gnome3，安装了同样的插件，如pomodoro和panelfavorites。最关键的是还可以使用搜狗输入法，flashplayer都可以自动安装。

从这个过程，我认识自己的问题。**很多时候自己特别懒，这个懒不是在劳力上，而是在思想上 \-\-\- 自己不愿意动脑筋去解决问题，而宁愿抱残守缺。**我们和其他动物最大的优势是我们的大脑更发达，我们可以进行深入的思考，学会使用工具，借助各种力量去解决问题。我们不可将这个优势丢弃，脑越用越活，要进行不断的刻意训练，让她反应更快，更有深度。

接下来分享一些安装Debian后的优化。

* 首先修改更新源：gedit /etc/apt/source.list

    # 163
    deb http://mirrors.163.com/debian/ stretch main non-free contrib
    deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib
    deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib
    deb-src http://mirrors.163.com/debian/ stretch main non-free contrib
    deb-src http://mirrors.163.com/debian/ stretch-updates main non-free contrib
    deb-src http://mirrors.163.com/debian/ stretch-backports main non-free contrib
    deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib
    deb-src http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib
    # 清华
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch main non-free contrib
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-updates main non-free contrib
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-backports main non-free contrib
    deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch main non-free contrib
    deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-updates main non-free contrib
    deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-backports main non-free contrib
    deb https://mirrors.tuna.tsinghua.edu.cn/debian-security/ stretch/updates main non-free contrib
    deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security/ stretch/updates main non-free contrib
   

* 删除不需要的软件并使用gnome-tweak-tool修改外观
    
* 更新和安装插件
    

    apt-get update && apt upgrade
    apt-get install gnome-shell-extension-top-icons-plus gnome-shell-pomodoro gnome-shell-pomodoro-data stardict
   

* 安装中文输入法

    apt-get install fcitx-ui-classic && apt-get install fcitx-ui-light
   

* 再安装其他软件，如vncviewer、为知笔记、星际译王、Calibre、Xmind和WPS

重启。

附一张自己桌面图

![](https://upload-images.jianshu.io/upload_images/2137228-0b07b7a149e2ab87.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

Debian9