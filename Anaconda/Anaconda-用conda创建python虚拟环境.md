# Anaconda-用 conda 创建 python 虚拟环境

conda 可以理解为一个工具，也是一个可执行命令，其核心功能是包管理和环境管理。包管理与 pip 的使用方法类似，环境管理则是允许用户方便滴安装不同版本的 python 环境并在不同环境之间快速地切换。

conda 的设计理念

conda 将几乎所有的工具、第三方包都当作 package 进行管理，甚至包括 python 和 conda 自身。Anaconda 是一个打包的集合，里面预装好了 conda、某个版本的 python、各种 packages 等。

1.安装 Anaconda。

打开命令行输入 conda -V 检验是否安装及当前 conda 的版本。

2.conda 常用的命令

1）查看安装了哪些包

conda list 2)查看当前存在哪些虚拟环境

conda env list
conda info -e 3)检查更新当前 conda

conda update conda
3.Python 创建虚拟环境

conda create -n your_env_name python=x.x
anaconda 命令创建 python 版本为 x.x，名字为 your_env_name 的虚拟环境。your_env_name 文件可以在 Anaconda 安装目录 envs 文件下找到。

4.激活或者切换虚拟环境

打开命令行，输入 python --version 检查当前 python 版本。

Linux: source activate your_env_nam
Windows: activate your_env_name 5.对虚拟环境中安装额外的包

conda install -n your_env_name [package] 6.关闭虚拟环境(即从当前环境退出返回使用 PATH 环境中的默认 python 版本)

deactivate env_name
或者`activate root`切回 root 环境
Linux 下：source deactivate 7.删除虚拟环境

conda remove -n your_env_name --all 8.删除环境钟的某个包

conda remove --name $your_env_name $package_name
8、设置国内镜像

[Anaconda](http://Anaconda.org)的服务器在国外，安装多个 packages 时，conda 下载的速度经常很慢。清华 TUNA 镜像源有 Anaconda 仓库的镜像，将其加入 conda 的配置即可：

## 添加 Anaconda 的 TUNA 镜像

conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/

## TUNA 的 help 中镜像地址加有引号，需要去掉

## 设置搜索时显示通道地址

conda config --set show_channel_urls yes

9、恢复默认镜像

conda config --remove-key channels

编辑于 2020-07-18 10:49
