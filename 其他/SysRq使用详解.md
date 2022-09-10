# SysRq 使用详解

> 转自https://www.cnblogs.com/ylan2009/articles/2322950.html

曾经啊，对着键盘上 Print Screen/SysRq 的键琢磨许久，也不知道所谓 SysRq 到底是做什么用的。自从用了 linux，才算知道是给内核传递信息，紧急情况下重启系统用的。

因为在 windows 的时候，从来没有用到过这个按键，所以我也就一直忽略掉了它的存在。直到有一天一个 flash 视频全屏后，x 崩溃，不要说进 tty 杀 gnome，就是按下 numberlock 都要反应好一会熄灭…… 幸好我有 SysRq 这个终极武器，顺利重启系统，避免了当前数据的丢失。

当您遇到死机或者没有响应的时候，甚至连 tty 都进不去，可以尝试用 SysRq 重启计算机。

> **警告：SysRq 不是万金油，不能解决任何疑难杂症。它只是您的最后武器，不到万不得已不可使用！因为一旦使用，系统将重启，当前工作的数据可能丢失！**

### **使用 SysRq 重启计算机的方法：**

> **Alt + SysRq + \[R-E-I-S-U-B\]**
> ——台式机键盘或者全尺寸键盘
>
> **Fn + Alt + SysRq + \[R-E-I-S-U-B\]**
> ——部分笔记本键盘

解释：括号内的英文字母需要依次顺序按下，而且每次按下字母后需要间隔 5-10s 再执行下一个动作。（如 alter +SysRq + R，间隔 10s 后再按 alter+ SysRq +E，以此类推）**切记不可快速按下 R-E-I-S-U-B ，否则后果和 扣电池拔电源线无异！**

字母顺序的记忆方法很简单，busy — busier — (reverse) — reisub — R-E-I-S-U-B （想来也是 linus 那斯杰作吧，lol）

**下面详细讲解一下各个序列：**

**unRaw – 把键盘设置为 ASCII 模式，使按键可以穿透 x server 捕捉传递给内核**

**tErminate** – **向除 init 外进程发送 SIGTERM 信号，让其自行结束**

\***\*kIll \- 向除 init 以外所有进程发送 SIGKILL 信号，强制结束进程\*\***

\***\*Sync – 同步缓冲区数据到硬盘，避免数据丢失\*\***

\***\*Unmount – 将所有已经挂载的文件系统 重新挂载为只读\*\***

\*\*\*\*reBoot \- 立即重启计算机

---

可以从顺序中看出，它不仅仅是杀掉进程这么简单，而且还有同步数据等操作，所以在每个操作结束前进行下一个操作是非常危险的。**所以，R-E-I-S-U-B 这个序列的推荐使用方式是：R – 1 秒 – E – 30 秒 – I – 10 秒 – S – 5 秒 – U – 5 秒 – B，而不是一气呵成地按下这六个键，试想一次正常的 reboot 命令也不是在一瞬间完成的吧。**

顺便翻一下其他按键的作用：

> 0-9 设定终端输出的内核 log 优先级
> b 立即重启系统
> c 内核 live reboot，并输出错误信息
> d 显示所有排它锁
> e 向除 init 外进程发送 SIGTERM 信号，让其自行结束
> f 人为触发 OOM Killer (out of memory)
> g 当进入内核模式时，以 framebuttter 代替输出
> h 输出帮助
> i 向除 init 以外所有进程发送 SIGKILL 信号，强制结束进程
> k 结束与当前控制台相关的全部进程
> m 内存使用信息
> n 重置所有进程的 nice（优先级）
> o 关机
> p 输出 cpu 寄存器信息
> q Display all active high-resolution timers and clock sources.
> r 把键盘设置为 ASCII 模式，使按键可以穿透 x server 捕捉传递给内核
> s 同步缓冲区数据到硬盘
> t 输出进程列表
> u 重新挂载所有文件系统为只读模式
> v 输出 Voyager SMP 处理信息
> w 输出 block（d 状态）进程列表
> 组合使用效果更好～

#### 我的尝试：

某次按照顺序执行 r-e-i-s-u-b 时候，忽然想到，既然 i 已经杀死了所有进程，那么僵死进程也必定被 kill 了，只要不是内核挂掉，应该都是可以恢复的。然后尝试进入 tty1，成功。遂输入命令欲启动 gnome，成功。但是在 gnome 登陆界面，鼠标键盘均无法使用……

后来想明白了，应该是把 hal，udev 什么的都 kill 掉了，所以 x-server 无法接受输入设备信息，当然无法使用键鼠了……我的尝试也到此为止，希望有人能验证是不是因为 hal ，udev 被 kill 而导致 gnome 输入无响应。

本文转自 [https://www.cnblogs.com/ylan2009/articles/2322950.html](https://www.cnblogs.com/ylan2009/articles/2322950.html)，如有侵权，请联系删除。
