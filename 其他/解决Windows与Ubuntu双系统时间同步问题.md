解决Ubuntu(20.04)和Windows10双系统时间不同步问题

黎璃QAQ 2020-11-25 20:22:52  2514  收藏 27
分类专栏： Ubuntu 文章标签： ubuntu window
版权

Ubuntu
专栏收录该内容
2 篇文章0 订阅
订阅专栏
文章目录
1. 原因分析
2. 解决方法
2.1 方法1（亲测有效）
2.2 方法2（对于低版本的Ubuntu系统可能有效）
2.3 方法3（方法二的一个补充，亲测亦有效）
3. 补充及总结

1. 原因分析
出现这种情况的原因是 Windows 和 Ubuntu它们在默认情况下看待硬件时间(主板上的BOIS显示的时间)的方式 不一样。

我们先来了解一下关于时间的概念 ：

UTC，即Universal Time Coordinated, 协调世界时

GMT，即Greenwich Mean Time, 格林尼治平时

RTC时间，即Real-time clock，是电脑的硬件时间

Windows 与 Linux 缺省看待系统硬件时间的方式是不一样的：

Linux 时钟分为系统时钟(System Clock)和硬件(RTC)时钟。Linux把硬件时间当作 UTC,系统时间是UTC时间经过换算得来的。比如说北京时间是GMT+8,则系统中显示时间是硬件时间+8。
Windows把系统硬件(RTC)时间当作本地时间(local time)，即系统时间跟BIOS中显示的时间(RTC)是一样的。

2. 解决方法
2.1 方法1（亲测有效）
在Ubuntu系统中，命令行输入
```
sudo apt-get install ntpdate					//在Ubuntu下更新本地时间
sudo ntpdate time.windows.com
sudo hwclock --localtime --systohc			//将本地时间更新到硬件上
```
然后重启进入Windows，初次重启可能时间依然不同，但是在Windows调整一遍后，再随意切换时间就同步了。


2.2 方法2（对于低版本的Ubuntu系统可能有效）
1，2任选其一即可

1.让Ubuntu不使用UTC时间， 而使用BIOS时间
```
将 /etc/default/rcS 中的	UTC=yes 改为 no		// 高版本(16.04之后)的
```
Ubuntu系统可能在default文件夹下找不到rcS文件，见方法3
2.让Windows使用UTC时间，而不使用BIOS时间
```
开始->运行->CMD,打开命令行程序(Vista则要以管理员方式打开命令行程序方可有权限访问注册表)，
在命令行中输入下面命令并回车：

Reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1
```

2.3 方法3（方法二的一个补充，亲测亦有效）
如果在方法2的1中没有rcs文件，可以采用一下方式解决：

终端输入：
```
timedatectl set-local-rtc 1 --adjust-system-clock
```
然后重启。

对命令的一点解释：
```
--adjust-system-clock
当使用set-local-rtc命令时，若使用了此选项，则表示根据RTC时间来更新系统时钟,而不是用UTC来更新（UTC需要+8）。
若未使用此选项，则表示根据系统时钟来更新RTC时间。
```

3. 补充及总结
为了更好的理解两个系统对待时间的不同，作以下补充即总结：

Windows将硬件时间(RTC)作为系统显示的时间。
Linux将硬件时间(RTC)作为UTC, 然后将UTC+8作为系统时间。这就导致了二者之间的不同, 时间会差8小时。
我们的解决方案是，要么让Windows屈就于Linux，要么让Linux屈就于Windows。我的建议是后者，因为毕竟Windows是主系统。

提供的三种方法本质上都是相同的，都是让Linux直接以RTC作为系统显示时间，而不需要UTC+8。

以下两幅图片，分别是改变前后，Linux时间的区别，大家可以借助理解。


改变前

改变后
————————————————
版权声明：本文为CSDN博主「黎璃QAQ」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/X_T_S/article/details/110142773