1. Settings-General-Interface language-zh(界面语言): 简体中文

2. (提前下载powerline字体)设置-通用-字体-控制台主要字体-DejaVu Sans Mono for Powerline-大小-16

3. 通用-大小&位置-窗口大小-最大化

4. 启动-指定命名任务-Bash::Msys2-64

5. 安装zsh(pacman -S zsh)

6. 启动-任务-预定义的任务-{Bash::Msys2-64}-删除set CHERE_INVOKING=1，在最前面加上set MSYS2_PATH_TYPE=inherit & set MSYSTEM=mingw64 & set LIBRARY_PATH=C:\msys64\mingw64\bin & -新窗口默认任务-Default shell(默认shell)(Win+X)

   // 对第五点的注释：set MSYS2_PATH_TYPE=inherit是将Windows的path系统变量与msys2合并

   // set MSYSTEM=mingw64是以mingw64模式启动msys2

7. 启动-任务-预定义的任务-{Bash::Msys2-64}-把-new_console:p后--login前的那一段路径中的bash.exe改成zsh.exe

8. 集成-默认终端-强制使用ConEmu作为控制台应用程序的默认终端

9. 通用-选择你的启动任务(或者带参数的shell)-{Bash::Msys2-64}