# 面向开发者的 WSL2 安装指南

> 转自https://zhuanlan.zhihu.com/p/145488247

### 为什么要使用 Windows 做开发

一直以来 macOS 以类 unix 的特性，获得了程序员的青睐，但是近几年 Apple 在硬件领域少有让人耳目一新的产品，加上取消 Esc、使用蝶式键盘、基本为 0 的硬件可升级性、系统权限的收紧等骚操作，让 Mac 从软件到硬件都不如以前适合编程。另一方面，PC 阵营在软件层面保持开放的基础上，硬件体验也逐步赶上甚至超越 Mac，我也不想在用 Mac 做开发，用 PC 玩游戏，希望用一台电脑兼顾游戏和开发，所以选择回到了 PC 阵营。

随着微软拥抱开源领域，Windows 也开始变得程序员友好。Windows 10 2004 发布后，WSL2 也可以在正式版 Windows 10 中使用，相比于 macOS，WSL2 是一个原生 Linux 环境而非类 unix 环境，甚至可以在 App 商店中选择所需要的发行版。而相比于 WSL1，WSL2 采用了 HyperV 虚拟机的方式，解决了 WSL1 不能安装 Docker 等问题。

### WSL1 和 WSL2

相比于 WSL1，WSL2 通过虚拟机的方式带来了更完整的 Linux 内核，但这种方式也引入了一些问题，微软给出了下面的图表来展示这些不同：

![](https://pic1.zhimg.com/v2-bb7b8a23b362ba5329d66517f81fbca8_r.jpg)

WSL2 不能和 VMWarework Station、VirtualBox 同时运行这一条已经过时了，VirtualBox 和 VMWare Workstation 都发布了支持 WSL2 和 Hyper-V 的新版。

WSL2 跨 OS 的磁盘性能的确低的令人发指，尤其是小文件，安装一个 Python 依赖可能需要等几分钟，安装一个 NodeJS 依赖...当我没说...相关 ISSUE 底下有无数吐槽，不过目前还没有人出来解决，在这里：[https://github.com/microsoft/WSL/issues/4197](https://link.zhihu.com/?target=https%3A//github.com/microsoft/WSL/issues/4197)）。不过微软在文档里也说了，有很多方式可以避免跨 OS 使用文件系统，比如使用 VSCode 的 remote deployment 功能，我认为这也是更好的实践，并且也这么做了。当然，如果你必须跨 OS 使用文件系统，还是乖乖留在 WSL1 吧（WSL1 太渣了，还是留在 VirtualBox 吧）。

除了表格里说的，我认为 WSL2 最大的问题在于...资源占用太大了...我是一台 16G 内存的电脑，使用 WSL2 后开机就要吃掉 11G 的内存，虽然可以使用 `wsl --shutdown` 关闭虚拟机释放资源，但是相比于 VirtualBox 和 WSL1，WSL2 的资源占用可以说翻倍了。

> 微软提供了限制 WSL2 资源的方式，参见[https://docs.microsoft.com/en-us/windows/wsl/release-notes#build-18945](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/en-us/windows/wsl/release-notes%23build-18945)

### 要做些什么

好了，搞清楚 WSL2 是什么之后接下来的问题就是怎么做了，这篇文章会指导你完成如下的安装流程：

- 升级 Windows 10 到 2004
- 启用 WSL2 并安装 Linux

以及一些最佳实践：

- 网络互通
- 文件系统互通
- 使用 Docker

最后会聊聊 WSL2 的未来。

### 升级 Windows 10 2004

升级到 Windows 10 2004 有多种方法，最靠谱的还是从设置 - 更新和安全里进行 OTA 升级，但是 Windows 的更新是分批推送的，2004 更新有可能等到一两个月后才会出现在你的更新界面中。

另一种更快速的方法是从官方地址下载镜像升级，访问这个地址下载运行就可以升级到最新的版本 [https://www.microsoft.com/software-download/windows10](https://link.zhihu.com/?target=https%3A//www.microsoft.com/software-download/windows10)，需要注意的是，发布初期可能 bug 含量会高一些，介意的还是再等等。

### 启用 WSL2

升级 Windows 10 的过程不会碰到太多问题，升级后还需要进行一些配置才可以使用 WSL2，首先要启用 Windows 子系统功能，使用管理员权限打开一个 PowerShell 窗口，输入以下命令，并重启系统：

```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

重启后，Windows 默认启用的是 WSL1，还需要再启用虚拟机平台功能，在 PowerShell 中输入以下命令，并再次重启系统：

```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

重启后，在 PowerShell 中输入以下命令，将 WSL 默认版本改为 WSL2:

```
wsl --set-default-version 2
```

接下来在 Microsoft Store 中找一个 Linux 发行版进行安装，安装后在 PowerShell 中执行 `wsl -l -v` 可以看到当前的发行版是否跑在 WSL2 中，如果显示版本是 1...请重复上面的安装步骤。

> 设置 WSL 版本为 WSL2 报错时，请访问 [https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/en-us/windows/wsl/wsl2-kernel) 下载 WSL2 Kernel。

### 网络互通

WSL2 不和 Windows 共享一个 localhost，所以不像 WSL1 中 Linux 和 Windows 有无感知的网络互通性。

Windows 访问 WSL2 启动的网络服务，可以直接使用 localhost，但是 Linux 访问 Windows 启动的网络服务这种方式就不行了，可以使用如下脚本获取 Windows 的 IP，并使用 IP 访问 Windows：

```
ip route | grep default | awk '{print $3}'
```

### 文件系统互通

WSL2 访问 Windows 文件系统依然通过挂载分区的方式，Windows 下的磁盘会被挂载在 `/mnt` 下，例如 `/mnt/c`。

相比于 WSL1，这次增加了 Windows 访问 Linux 分区的能力，可以在资源管理器中输入 `\\wsl$\<子系统名>` 访问对应的子系统分区，为了方便也可以在资源管理器中把 Linux 分区挂载成一个磁盘。

更加方便的一个方式是，在 Terminal 中，使用 `explorer.exe .` 可以直接调用资源管理器打开当前目录，有点类似 Mac 下的 `open .`。

### 使用 Docker

WSL2 带来了完整的 Linux 内核，所以可以参照 Docker 在 Linux 上安装的过程安装 Docker，并且可以正常使用，但是会有一个小瑕疵。WSL2 的 systemd 吧...还不是原生的，也就是在 WSL1 上就有的无法启动服务守护进程的问题依然存在，Docker 服务自然也不能幸免。

解决这个问题有三种方案：

- 可以让 Windows 执行开机脚本，通过脚本启动 WSL2 中的 Docker，参见[https://blog.csdn.net/XhyEax/article/details/105560377](https://link.zhihu.com/?target=https%3A//blog.csdn.net/XhyEax/article/details/105560377)，这种方案在 WSL1 时代就有，我自己使用过没碰到过问题。

- 第二种方案是使用第三方工具运行 systemd，参见 [https://github.com/arkane-systems/genie](https://link.zhihu.com/?target=https%3A//github.com/arkane-systems/genie)，原理是提供了一个单独的 namespace 跑 systemd。

- 第三种方案是使用 Docker Desktop，2.3.0.2 以上版本已经支持 WSL2 和 Hyper-V，免去一些折腾。

### GPU 支持

Build 2020 发出消息说 WSL2 要支持 GPU，Nvidia 也发出了 CUDA on WSL2 的预览版，在这里：[https://developer.nvidia.com/cuda/wsl](https://link.zhihu.com/?target=https%3A//developer.nvidia.com/cuda/wsl)。

这意味着以后可以直接在 Windows 上使用 GPU 加速训练模型了，虽然支持成都还很有限，但是相比于 Mac 可领先了一个身位都不只了。

### 总结

在体系结构上 WSL2 没有太大的创新，本质就是一台跑在 Hyper-V 上的虚拟机，你可以使用 VMWare Workstation 或 VirtualBox，经过简单的配置实现其 100% 的功能，并且会有更高的性能，更少的资源占用，但是毕竟 WSL2 是一项原生功能，其配置上的便利性和兼容性，大大减少了使用者花在配置上的精力，最大程度的实现开箱即用，这也是 Apple 一直以来吸引开发者的主要原因。在这个时间点，使用 Windows + WSL2 来构建开发环境已经可以满足大部分的需求。

### 参考

[https://github.com/microsoft/WSL/issues/4197](https://link.zhihu.com/?target=https%3A//github.com/microsoft/WSL/issues/4197)

[https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/en-us/windows/wsl/wsl2-kernel)

[https://docs.microsoft.com/en-us/windows/wsl/install-win10](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/en-us/windows/wsl/install-win10)

[https://github.com/arkane-systems/genie](https://link.zhihu.com/?target=https%3A//github.com/arkane-systems/genie)

[https://docs.microsoft.com/en-us/windows/wsl/release-notes#build-18945](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/en-us/windows/wsl/release-notes%23build-18945)

[https://developer.nvidia.com/cuda/wsl](https://link.zhihu.com/?target=https%3A//developer.nvidia.com/cuda/wsl)

[https://devblogs.microsoft.com/directx/directx-heart-linux/](https://link.zhihu.com/?target=https%3A//devblogs.microsoft.com/directx/directx-heart-linux/)

本文转自 [https://zhuanlan.zhihu.com/p/145488247](https://zhuanlan.zhihu.com/p/145488247)，如有侵权，请联系删除。
