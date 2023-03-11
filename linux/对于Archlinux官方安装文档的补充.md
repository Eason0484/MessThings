# (安装前的准备 > 建立硬盘分区)可以使用cfdisk或cgdisk进行图形化分区

# (安装前的准备 > 建立硬盘分区)Redhat官方的文档中关于swap分区大小设置的建议
| 物理内存     | 建议的交换空间大小 | 如果开启休眠功能建议的交换空间大小 |
| ------------ | ------------------ | ---------------------------------- |
| ⩽ 2GB        | 内存的2倍          | 内存的3倍                          |
| > 2GB – 8GB  | 等于内存大小       | 内存的2倍                          |
| > 8GB – 64GB | 至少4G             | 内存的1.5倍                        |
| > 64GB       | 至少4G             | 不建议使用休眠                     |

# (安装 > 安装必需的软件包)软件包补充
推荐使用pacstrap安装的软件包:
- 基础包: base base-devel linux linux-firmware vim networkmanager dhcpcd grub efibootmgr
- KDE桌面环境: xorg sddm plasma konsole (记得设置开机自启systemctl enable sddm)
- KDE桌面环境整合包: kde-applications
- 中文字体: wqy-microhei
- 输入法: fcitx5 fcitx5-chinese-addons fcitx5-qt fcitx5-gtk

# (安装 > 本地化)
- 编辑 /etc/locale.gen, 然后取消掉 `en_US.UTF-8 UTF-8` 和 `zh_CN.UTF-8 UTF-8`

# (安装结束)GRUB设置
- 留在arch-chroot环境中
- 使用uname -a查看电脑信息
- 参照https://wiki.archlinuxcn.org/wiki/GRUB

# (安装结束)添加用户
- 在arch-chroot环境中修改root密码
- 使用useradd创建新用户并用passwdd修改密码
- 将用户加入/etc/sudoers

# (安装结束)修改为中文本地设置
- arch-chroot环境中
- 若不使用图形界面则不修改此项, 保留为英文
- 修改 `/etc/locale.conf` 文件, 并编辑设定 `LANG` 变量 (LANG=zh_CN.UTF-8)

# (安装结束)输入法配置
- 仅供参考:
```
vim ~/.pam_environment

// 添加如下内容
GTK_IM_MODULE DEFAULT=fcitx
QT_IM_MODULE  DEFAULT=fcitx
XMODIFIERS    DEFAULT=\@im=fcitx
INPUT_METHOD  DEFAULT=fcitx
SDL_IM_MODULE DEFAULT=fcitx
GLFW_IM_MODULE DEFAULT=ibus
```

# (安装结束)安装显卡驱动等各类驱动
- 使用uname -a查看电脑信息

# (安装结束)包管理器换源
- 配置archlinuxcn仓库
```
vim /etc/pacman.conf

// 添加如下内容 此处使用了清华源，可自行更换其他源
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```
同步并安装archlinuxcn-keyring
```
sudo pacman -Syyu

sudo pacman -S archlinuxcn-keyring
```
如果安装archlinuxcn-keyring失败，请以 root 权限运行如下命令
```
pacman -Syu haveged
systemctl start haveged
systemctl enable haveged

rm -fr /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinux
pacman-key --populate archlinuxcn
```
使用 `pacman -Syu` 重新加载
