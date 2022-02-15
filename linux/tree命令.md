# Linux--tree命令

### 概述

- tree命令的中文意思为“树”，功能是以树形结构列出指定目录下的所有内容，包括所有文件、子目录及子目录里的目录和文件。
- 语　　法：



```sh
tree [-aACdDfFgilnNpqstux][-I <范本样式>][-P <范本样式>][目录...]
```

- 补充说明：执行tree指令，它会列出指定目录下的所有文件，包括子目录里的文件。
- 安装演示：一般linux系统不会自带tree工具，要手动安装：yum -y install tree

### 参数

- 命令参数：tree有很多参数命令，具体想查看全部的命令可以使用man tree命令查看，下面列举部分常用的。



```sh
usage: tree [-adfghilnpqrstuvxACDFNS] [-H baseHREF] [-T title ] [-L level [-R]]
        [-P pattern] [-I pattern] [-o filename] [--version] [--help] [--inodes]
        [--device] [--noreport] [--nolinks] [--dirsfirst] [--charset charset]
        [--filelimit #] [<directory list>]
  -a            All files are listed.
  -d            List directories only.
  -l            Follow symbolic links like directories.
  -f            Print the full path prefix for each file.
  -i            Don't print indentation lines.
  -q            Print non-printable characters as '?'.
  -N            Print non-printable characters as is.
  -p            Print the protections for each file.
  -u            Displays file owner or UID number.
  -g            Displays file group owner or GID number.
  -s            Print the size in bytes of each file.
  -h            Print the size in a more human readable way.
  -D            Print the date of last modification.
  -F            Appends '/', '=', '*', or '|' as per ls -F.
  -v            Sort files alphanumerically by version.
  -r            Sort files in reverse alphanumeric order.
  -t            Sort files by last modification time.
  -x            Stay on current filesystem only.
  -L level      Descend only level directories deep.
  -A            Print ANSI lines graphic indentation lines.
  -S            Print with ASCII graphics indentation lines.
  -n            Turn colorization off always (-C overrides).
  -C            Turn colorization on always.
  -P pattern    List only those files that match the pattern given.
  -I pattern    Do not list files that match the given pattern.
  -H baseHREF   Prints out HTML format with baseHREF as top directory.
  -T string     Replace the default HTML title and H1 header with string.
  -R            Rerun tree when max dir level reached.
  -o file       Output to file instead of stdout.
  --inodes      Print inode number of each file.
  --device      Print device ID number to which each file belongs.
  --noreport    Turn off file/directory count at end of tree listing.
  --nolinks     Turn off hyperlinks in HTML output.
  --dirsfirst   List directories before files.
  --charset X   Use charset X for HTML and indentation line output.
  --filelimit # Do not descend dirs with more than # files in them.
```

- 中文版详解



```sh
1)tree  -a 显示所有文件和目录（不加-a,则隐藏目录不显示)
(2)tree -d 显示目录名称而非内容
(3)tree -f 在每个文件或目录之前，显示完整的相对路径名称
(4)tree -F 在执行文件，目录，Socket，符号连接，管道名称名称，各自加上"*","/","=","@","|"号。
(5)tree -r 以相反次序排列
(6)tree -t 用文件和目录的更改时间排序
(7)tree -L n 只显示 n 层目录 （n 为数字）
(8)tree -dirsfirst 目录显示在前,文件显示在后
(9)可以加的参数
-A 使用ASNI绘图字符显示树状图而非以ASCII字符组合。
-C 在文件和目录清单加上色彩，便于区分各种类型。
-D 列出文件或目录的更改时间。
-g 列出文件或目录的所属群组名称，没有对应的名称时，则显示群组识别码。
-i 不以阶梯状列出文件或目录名称。
-I 不显示符合范本样式的文件或目录名称。
-l 如遇到性质为符号连接的目录，直接列出该连接所指向的原始目录。
-n 不在文件和目录清单加上色彩。
-N 直接列出文件和目录名称，包括控制字符。
-p 列出权限标示。
-P 只显示符合范本样式的文件或目录名称。
-q 用"?"号取代控制字符，列出文件和目录名称。
-s 列出文件或目录大小。
```

### 例子

- 1-不带任何参数执行tree命令



```sh
[root@bigdata-dev-32 6_pyspark_demo]# tree -C
.
├── pyspark_demo
│   ├── demo1_spark.py
│   ├── fun
│   │   ├── count_action.py
│   │   └── __init__.py
│   └── uitl
│       ├── __init__.py
│       └── spark_source.py
├── pyspark_demo.zip
└── pyspark_sumbit.sh
```

- 2-以树形结构显示目录下的所有内容（-a的功能）



```sh
root@bigdata-dev-32 6_pyspark_demo]# tree -a
.
├── pyspark_demo
│   ├── demo1_spark.py
│   ├── fun
│   │   ├── count_action.py
│   │   └── __init__.py
│   ├── .idea
│   │   ├── encodings.xml
│   │   ├── misc.xml
│   │   ├── modules.xml
│   │   ├── pyspark_demo.iml
│   │   ├── vcs.xml
│   │   └── workspace.xml
│   └── uitl
│       ├── __init__.py
│       └── spark_source.py
├── pyspark_demo.zip
└── pyspark_sumbit.sh
```

- 3-只列出根目录下第一层目录的结构（-L功能）



```sh
[root@bigdata-dev-32 6_pyspark_demo]# tree -L 1
.
├── pyspark_demo
├── pyspark_demo.zip
└── pyspark_sumbit.sh

1 directory, 2 files
```

- 4-只显示所有的目录（但不显示文件）



```sh
[root@bigdata-dev-32 6_pyspark_demo]# tree -d
.
└── pyspark_demo
    ├── fun
    └── uitl

3 directories
```

- 5-用tree命令来区分目录和文件的方法（很常用滴哦）



```sh
[root@bigdata-dev-32 liyahui]# tree -L 1 -F 6_pyspark_demo/
6_pyspark_demo/
├── pyspark_demo/
├── pyspark_demo.zip
└── pyspark_sumbit.sh

1 directory, 2 files
[root@bigdata-dev-32 liyahui]# tree -L 1 -F 6_pyspark_demo/| grep /$
6_pyspark_demo/
├── pyspark_demo/
[root@bigdata-dev-32 liyahui]# tree -L 1 -d 6_pyspark_demo/
6_pyspark_demo/
└── pyspark_demo

1 directory
```

- 6-只显示一层目录



```sh
tree -L 1  -d /home/omc/ftl 
tree -Ld 1 /home/omc/ftl  
find /home/omc/ftl -maxdepth 1 -type d       最大深度为1
```

------

参考博客： [Linux命令之----tree](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.cnblogs.com%2Fliang-io%2Fp%2F9561232.html)
[Linux tree命令详解](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.cnblogs.com%2Fftl1012%2Fp%2Ftree.html)
[linux中tree工具命令的使用](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fqq_26442553%2Farticle%2Fdetails%2F79133098)



1人点赞



[Linux技术文档](https://www.jianshu.com/nb/36984196)