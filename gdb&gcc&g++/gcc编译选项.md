# [GCC 编译命令](https://www.cnblogs.com/ibyte/p/5828445.html)

今天突然被同事问道一个GCC编译命令的问题，感觉对相应内容生疏了，赶紧整理下相关内容，梳理下相关知识。

GCC命令提供了非常多的命令选项，但并不是所有都要熟悉，初学时掌握几个常用的就可以了，到后面再慢慢学习其它选项，免得因选项太多而打击了学习的信心。

**一. 常用编译命令选项**

假设源程序文件名为test.c。

\1. 无选项编译链接
用法：#gcc test.c
作用：将test.c*预处理、汇编、编译并链接形成可执行文*件。这里未指定输出文件，*默认输出为a.ou*t。

\2. 选项 -o
用法：#gcc test.c -o test
作用：将test.c*预处理、汇编、编译并链接形成可执行文件*test。-o选项用来指定输出文件的文件名。

\3. 选项 -E
用法：#gcc -E test.c -o test.i
作用：将test.c预处理输出test.i文件。

\4. 选项 -S
用法：#gcc -S test.i
作用：将预处理输出文件test.i汇编成test.s文件。

\5. 选项 -c
用法：#gcc -c test.s
作用：将*汇编输出文*件test.s编*译输*出test.o文件。

\6. 无选项链接
用法：#gcc test.o -o test
作用：将编译输出文件test.o*链接成最终*可执行文件test。

\7. 选项-O
用法：#gcc -O1 test.c -o test
作用：使用编译优化级别1编译程序。级别为1~3，*级别越大优化效果*越好，但编译时间越长。

**二. 多源文件的编译方法**

如果有多个源文件，基本上有两种编译方法：
[假设有两个源文件为test.c和testfun.c]

\1. 多个文件一起编译
用法：#gcc testfun.c test.c -o test
作用：将testfun.c和test.c分别编译后链接成test可执行文件。

\2. 分别编译各个源文件，之后对编译后输出的目标文件链接。
用法：
\#gcc -c testfun.c //将testfun.c编译成testfun.o
\#gcc -c test.c  //将test.c编译成test.o
\#gcc -o testfun.o test.o -o test //将testfun.o和test.o链接成test

以上两种方法相比较，第一中方法编译时需要所有文件重新编译，而第二种方法可以只重新编译修改的文件，未修改的文件不用重新编译。

#### 3库文件连接

开发软件时，完全不使用第三方函数库的情况是比较少见的，通常来讲都需要借助许多函数库的支持才能够完成相应的功能。从程序员的角度看，函数库实际上就是一些头文件（.h）和库文件（so、或lib、dll）的集合。。虽然Linux下的大多数函数都默认将头文件放到/usr/include/目录下，而库文件则放到/usr/lib/目录下；Windows所使用的库文件主要放在Visual Stido的目录下的include和lib，以及系统文件夹下。但也有的时候，我们要用的库不再这些目录下，所以GCC在编译时必须用自己的办法来查找所需要的头文件和库文件。

例如我们的程序test.c是在linux上使用c连接mysql，这个时候我们需要去mysql官网下载MySQL Connectors的C库，下载下来解压之后，有一个include文件夹，里面包含mysql connectors的头文件，还有一个lib文件夹，里面包含二进制so文件libmysqlclient.so

其中inclulde文件夹的路径是/usr/dev/mysql/include,lib文件夹是/usr/dev/mysql/lib

 

##### 3.1编译成可执行文件

首先我们要进行编译test.c为目标文件，这个时候需要执行

```
gcc –c –I /usr/dev/mysql/include test.c –o test.o
```

##### 3.2链接

最后我们把所有目标文件链接成可执行文件:

```
gcc –L /usr/dev/mysql/lib –lmysqlclient test.o –o test
```

Linux下的库文件分为两大类分别是动态链接库（通常以.so结尾）和静态链接库（通常以.a结尾），二者的区别仅在于程序执行时所需的代码是在运行时动态加载的，还是在编译时静态加载的。

##### 3.3强制链接时使用静态链接库

默认情况下， GCC在链接时优先使用动态链接库，只有当动态链接库不存在时才考虑使用静态链接库，如果需要的话可以在编译时加上-static选项，强制使用静态链接库。

在/usr/dev/mysql/lib目录下有链接时所需要的库文件libmysqlclient.so和libmysqlclient.a，为了让GCC在链接时只用到静态链接库，可以使用下面的命令:

```
gcc –L /usr/dev/mysql/lib –static –lmysqlclient test.o –o test
```

 

静态库链接时搜索路径顺序：

\1. ld会去找GCC命令中的参数-L
\2. 再找gcc的环境变量LIBRARY_PATH
\3. 再找内定目录 /lib /usr/lib /usr/local/lib 这是当初compile gcc时写在程序内的

动态链接时、执行时搜索路径顺序:

\1. 编译目标代码时指定的动态库搜索路径
\2. 环境变量LD_LIBRARY_PATH指定的动态库搜索路径
\3. 配置文件/etc/ld.so.conf中指定的动态库搜索路径
\4. 默认的动态库搜索路径/lib
\5. 默认的动态库搜索路径/usr/lib

有关环境变量：
LIBRARY_PATH环境变量：指定程序静态链接库文件搜索路径
LD_LIBRARY_PATH环境变量：指定程序动态链接库文件搜索路径

# GCC 编译详解

![img](https://csdnimg.cn/release/blogv2/dist/pc/img/reprint.png)

[junmuzi](https://blog.csdn.net/junmuzi) 2016-03-18 15:53:03 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 8694 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏 24

分类专栏： [Ubuntu](https://blog.csdn.net/junmuzi/category_1341851.html) [linux_basic](https://blog.csdn.net/junmuzi/category_1246384.html)

[![img](https://img-blog.csdnimg.cn/20201014180756927.png?x-oss-process=image/resize,m_fixed,h_64,w_64)Ubuntu](https://blog.csdn.net/junmuzi/category_1341851.html)同时被 2 个专栏收录![img](https://csdnimg.cn/release/blogv2/dist/pc/img/newArrowDown1White.png)

109 篇文章0 订阅

订阅专栏

[![img](https://img-blog.csdnimg.cn/20201014180756925.png?x-oss-process=image/resize,m_fixed,h_64,w_64)linux_basic](https://blog.csdn.net/junmuzi/category_1246384.html)

149 篇文章0 订阅

订阅专栏



### 常用选项



`-E`：只进行预处理，不编译
`-S`：只编译，不汇编
`-c`：只编译、汇编，不链接
`-g`：包含调试信息
`-I`：指定include包含文件的搜索目录
`-o`：输出成指定文件名

### 高级选项

`-v`：详细输出编译过程中所采用的每一个选项
`-C`：预处理时保留注释信息
`-ggdb`：在可执行文件中包含可供`GDB`使用的调试信息
`-fverbose-asm`：在编译成汇编语言时，把C变量的名称作为汇编语言中的注释
`-save-temps`：自动输出预处理文件、汇编文件、对象文件，编译正常进行
`-fsyntax-only`：只测试源文件语法是否正确，不会进行任何编译操作
`-ffreestanding`：编译成独立程序，而非宿主程序

### 语言标准

`-ansi`：ANSI标准
`-std=c99`：C99标准
`-std=gnu89`：ISO/IEC 9899:1990 以及GNU扩充
`-std=gnu99`：ISO/IEC 9899:1999 以及GNU扩充
`-trigraphs`：支持ISO C三字符组

### 出错提示

`-w`：忽略所有警告
`-Werror`：不区分警告和错误，遇到任何警告都停止编译
`-Wall`：开启大部分警告提示
`-Wshadow`：某语句块作用域变量与更大作用域的另一变量同名时发出警告（此警告未包含在`-Wall`选项中，需单独开启）
`-Wextra`：对所有合法但值得怀疑的表达式发出警告

### 优化选项

`-O0`：关闭所有优化选项
`-O1`：第一级别优化，使用此选项可使可执行文件更小、运行更快，并不会增加太多编译时间，可以简写为`-O`
`-O2`：第二级别优化，采用了几乎所有的优化技术，使用此选项会延长编译时间
`-O3`：第三级别优化，在`-O2`的基础上增加了产生`inline`函数、使用寄存器等优化技术
`-Os`：此选项类似于`-O2`，作用是优化所占用的空间，但不会进行性能优化，常用于生成最终版本











GNU CC（简称为Gcc）是GNU项目中符合ANSI C标准的编译系统，能够编译用C、C++和Object C等语言编写的程序。Gcc不仅功能强大，而且可以编译如C、C++、Object C、Java、Fortran、Pascal、Modula-3和Ada等多种语言，而且Gcc又是一个交叉平台编译器，它能够在当前CPU平台上为多种不同体系结构的硬件平台开发软件，因此尤其适合在嵌入式领域的开发编译。本章中的示例，除非特别注明，否则均采用Gcc版本为4.0.0。

 

 

GCC入门基础

表3.6 Gcc所支持后缀名解释

| 后 缀 名    | 所对应的语言              | 后 缀 名 | 所对应的语言         |
| ----------- | ------------------------- | -------- | -------------------- |
| .c          | C原始程序                 | .s/.S    | 汇编语言原始程序     |
| .C/.cc/.cxx | C++原始程序               | .h       | 预处理文件（头文件） |
| .m          | Objective-C原始程序       | .o       | 目标文件             |
| .i          | 已经过预处理的C原始程序   | .a/.so   | 编译后的库文件       |
| .ii         | 已经过预处理的C++原始程序 |          |                      |

如本章开头提到的，Gcc的编译流程分为了四个步骤，分别为：

· 预处理（Pre-Processing）

· 编译（Compiling）

· 汇编（Assembling）

· 链接（Linking）

下面就具体来查看一下Gcc是如何完成四个步骤的。

首先，有以下hello.c源代码

\#include<stdio.h>

int main()

{

printf("Hello! This is our embedded world!n");

return 0;

}

（1）预处理阶段

在该阶段，编译器将上述代码中的stdio.h编译进来，并且用户可以使用Gcc的选项”-E”进行查看，该选项的作用是让Gcc在预处理结束后停止编译过程。

|      | 注意 | Gcc指令的一般格式为：Gcc [选项] 要编译的文件 [选项] [目标文件]其中，目标文件可缺省，Gcc默认生成可执行的文件，命为：编译文件.out |
| ---- | ---- | ------------------------------------------------------------ |
|      |      |                                                              |

 

[root@localhost Gcc]# gcc -E hello.c  -o hello.i

 

在此处，选项”-o”是指目标文件，由表3.6可知，”.i”文件为已经过预处理的C原始程序。以下列出了hello.i文件的部分内容：

 

typedef int (*__gconv_trans_fct) (struct __gconv_step *,

struct __gconv_step_data *, void *,

__const unsigned char *,

__const unsigned char **,

__const unsigned char *, unsigned char **,

size_t *);

…

\# 2 "hello.c" 2

int main()

{

printf("Hello! This is our embedded world!n");

return 0;

}

 

由此可见，Gcc确实进行了预处理，它把”stdio.h”的内容插入到hello.i文件中。

（2）编译阶段

接下来进行的是编译阶段，在这个阶段中，Gcc首先要检查代码的规范性、是否有语法错误等，以确定代码的实际要做的工作，在检查无误后，Gcc把代码翻译成汇编语言。用户可以使用”-S”选项来进行查看，该选项只进行编译而不进行汇编，生成汇编代码。

 

[root@localhost Gcc]# Gcc -S hello.i -o hello.s

 

以下列出了hello.s的内容，可见Gcc已经将其转化为汇编了，感兴趣的读者可以分析一下这一行简单的C语言小程序是如何用汇编代码实现的。

 

.file "hello.c"

.section .rodata

.align 4

.LC0:

.string"Hello! This is our embedded world!"

.text

.globl main

.type main, @function

main:

pushl �p

movl %esp, �p

subl $8, %esp

andl $-16, %esp

movl $0, �x

addl $15, �x

addl $15, �x

shrl $4, �x

sall $4, �x

subl �x, %esp

subl $12, %esp

pushl $.LC0

call puts

addl $16, %esp

movl $0, �x

leave

ret

.size main, .-main

.ident "GCC: (GNU) 4.0.0 20050519 (Red Hat 4.0.0-8)"

.section .note.GNU-stack,"",@progbits

 

（3）汇编阶段

汇编阶段是把编译阶段生成的”.s”文件转成目标文件，读者在此可使用选项”-c”就可看到汇编代码已转化为”.o”的二进制目标代码了。如下所示：

 

[root@localhost Gcc]# gcc -c hello.s -o hello.o

 

（4）链接阶段

在成功编译之后，就进入了链接阶段。在这里涉及到一个重要的概念：函数库。

读者可以重新查看这个小程序，在这个程序中并没有定义”printf”的函数实现，且在预编译中包含进的”stdio.h”中也只有该函数的声明，而没有定义函数的实现，那么，是在哪里实现”printf”函数的呢？最后的答案是：系统把这些函数实现都被做到名为libc.so.6的库文件中去了，在没有特别指定时，Gcc会到系统默认的搜索路径”/usr/lib”下进行查找，也就是链接到libc.so.6库函数中去，这样就能实现函数”printf”了，而这也就是链接的作用。

函数库一般分为静态库和动态库两种。静态库是指编译链接时，把库文件的代码全部加入到可执行文件中，因此生成的文件比较大，但在运行时也就不再需要库文件了。其后缀名一般为”.a”。动态库与之相反，在编译链接时并没有把库文件的代码加入到可执行文件中，而是在程序执行时由运行时链接文件加载库，这样可以节省系统的开销。动态库一般后缀名为”.so”，如前面所述的libc.so.6就是动态库。Gcc在编译时默认使用动态库。

完成了链接之后，Gcc就可以生成可执行文件，如下所示。

 

[root@localhost Gcc]# gcc hello.o -o hello

 

运行该可执行文件，出现正确的结果如下。

 

[root@localhost Gcc]# ./hello

Hello! This is our embedded world!

Gcc编译选项分析

Gcc有超过100个的可用选项，主要包括总体选项、告警和出错选项、优化选项和体系结构相关选项。以下对每一类中最常用的选项进行讲解。

（1）总体选项

Gcc的总结选项如表3.7所示，很多在前面的示例中已经有所涉及。

表3.7 Gcc总体选项列表

| 后缀名    | 所对应的语言                                         |
| --------- | ---------------------------------------------------- |
| -c        | 只是编译不链接，生成目标文件“.o”                     |
| -S        | 只是编译不汇编，生成汇编代码                         |
| -E        | 只进行预编译，不做其他处理                           |
| -g        | 在可执行程序中包含标准调试信息                       |
| -o file   | 把输出文件输出到file里                               |
| -v        | 打印出编译器内部编译各过程的命令行信息和编译器的版本 |
| -I dir    | 在头文件的搜索路径列表中添加dir目录                  |
| -L dir    | 在库文件的搜索路径列表中添加dir目录                  |
| -static   | 链接静态库                                           |
| -llibrary | 连接名为library的库文件                              |

 

对于“-c”、“-E”、“-o”、“-S”选项在前一小节中已经讲解了其使用方法，在此主要讲解另外两个非常常用的库依赖选项“-I dir”和“-L dir”。

· “-I dir”

正如上表中所述，“-I dir”选项可以在头文件的搜索路径列表中添加dir目录。由于Linux中头文件都默认放到了“/usr/include/”目录下，因此，当用户希望添加放置在其他位置的头文件时，就可以通过“-I dir”选项来指定，这样，Gcc就会到相应的位置查找对应的目录。

比如在“/root/workplace/Gcc”下有两个文件：

 

 

\#include<my.h>

int main()

{

printf(“Hello!!n”);

return 0;

}

 

\#include<stdio.h>

 

这样，就可在Gcc命令行中加入“-I”选项：

 

[root@localhost Gcc] Gcc hello1.c –I /root/workplace/Gcc/ -o hello1

 

这样，Gcc就能够执行出正确结果。

 

| 小知识 | 在include语句中，“<>”表示在标准路径中搜索头文件，““””表示在本目录中搜索。故在上例中，可把hello1.c的“#include<my.h>”改为“#include “my.h””，就不需要加上“-I”选项了。 |
| ------ | ------------------------------------------------------------ |
|        |                                                              |

 

· “-L dir”

选项“-L dir”的功能与“-I dir”类似，能够在库文件的搜索路径列表中添加dir目录。例如有程序hello_sq.c需要用到目录“/root/workplace/Gcc/lib”下的一个动态库libsunq.so，则只需键入如下命令即可：

 

[root@localhost Gcc] Gcc hello_sq.c –L /root/workplace/Gcc/lib –lsunq –o hello_sq

 

需要注意的是，“-I dir”和“-L dir”都只是指定了路径，而没有指定文件，因此不能在路径中包含文件名。

另外值得详细解释一下的是“-l”选项，它指示Gcc去连接库文件libsunq.so。由于在Linux下的库文件命名时有一个规定：必须以lib三个字母开头。因此在用-l选项指定链接的库文件名时可以省去lib三个字母。也就是说Gcc在对”-lsunq”进行处理时，会自动去链接名为libsunq.so的文件。

（2）告警和出错选项

Gcc的告警和出错选项如表3.8所示。

表3.8 Gcc总体选项列表

| 选项            | 含义                                                       |
| --------------- | ---------------------------------------------------------- |
| -ansi           | 支持符合ANSI标准的C程序                                    |
| -pedantic       | 允许发出ANSI C标准所列的全部警告信息                       |
| 选项            | 含义                                                       |
| -pedantic-error | 允许发出ANSI C标准所列的全部错误信息                       |
| -w              | 关闭所有告警                                               |
| -Wall           | 允许发出Gcc提供的所有有用的报警信息                        |
| -werror         | 把所有的告警信息转化为错误信息，并在告警发生时终止编译过程 |

 

下面结合实例对这几个告警和出错选项进行简单的讲解。

如有以下程序段：

 

\#include<stdio.h>

 

void main()

{

long long tmp = 1;

printf(“This is a bad code!n”);

return 0;

}

 

这是一个很糟糕的程序，读者可以考虑一下有哪些问题？

· “-ansi”

该选项强制Gcc生成标准语法所要求的告警信息，尽管这还并不能保证所有没有警告的程序都是符合ANSI C标准的。运行结果如下所示：

 

[root@localhost Gcc]# Gcc –ansi warning.c –o warning

warning.c: 在函数“main”中：

warning.c:7 警告：在无返回值的函数中，“return”带返回值

warning.c:4 警告：“main”的返回类型不是“int”

 

可以看出，该选项并没有发现”long long”这个无效数据类型的错误。

· “-pedantic”

允许发出ANSI C标准所列的全部警告信息，同样也保证所有没有警告的程序都是符合ANSI C标准的。其运行结果如下所示：

 

[root@localhost Gcc]# Gcc –pedantic warning.c –o warning

warning.c: 在函数“main”中：

warning.c:5 警告：ISO C90不支持“long long”

warning.c:7 警告：在无返回值的函数中，“return”带返回值

warning.c:4 警告：“main”的返回类型不是“int”

 

可以看出，使用该选项查看出了”long long”这个无效数据类型的错误。

· “-Wall”

允许发出Gcc能够提供的所有有用的报警信息。该选项的运行结果如下所示：

[root@localhost Gcc]# Gcc –Wall warning.c –o warning

warning.c:4 警告：“main”的返回类型不是“int”

warning.c: 在函数”main”中：

warning.c:7 警告：在无返回值的函数中，”return”带返回值

warning.c:5 警告：未使用的变量“tmp”

 

使用“-Wall”选项找出了未使用的变量tmp，但它并没有找出无效数据类型的错误。

另外，Gcc还可以利用选项对单独的常见错误分别指定警告，有关具体选项的含义感兴趣的读者可以查看Gcc手册进行学习。

（3）优化选项

Gcc可以对代码进行优化，它通过编译选项“-On”来控制优化代码的生成，其中n是一个代表优化级别的整数。对于不同版本的Gcc来讲，n的取值范围及其对应的优化效果可能并不完全相同，比较典型的范围是从0变化到2或3。

不同的优化级别对应不同的优化处理工作。如使用优化选项“-O”主要进行线程跳转（Thread Jump）和延迟退栈（Deferred Stack Pops）两种优化。使用优化选项“-O2”除了完成所有“-O1”级别的优化之外，同时还要进行一些额外的调整工作，如处理器指令调度等。选项“-O3”则还包括循环展开和其他一些与处理器特性相关的优化工作。

虽然优化选项可以加速代码的运行速度，但对于调试而言将是一个很大的挑战。因为代码在经过优化之后，原先在源程序中声明和使用的变量很可能不再使用，控制流也可能会突然跳转到意外的地方，循环语句也有可能因为循环展开而变得到处都有，所有这些对调试来讲都将是一场噩梦。所以笔者建议在调试的时候最好不使用任何优化选项，只有当程序在最终发行的时候才考虑对其进行优化。

（4）体系结构相关选项

Gcc的体系结构相关选项如表3.9所示。

表3.9Gcc体系结构相关选项列表

| 选项         | 含义                                                         |
| ------------ | ------------------------------------------------------------ |
| -mcpu=type   | 针对不同的CPU使用相应的CPU指令。可选择的type有i386、i486、pentium及i686等 |
| -mieee-fp    | 使用IEEE标准进行浮点数的比较                                 |
| -mno-ieee-fp | 不使用IEEE标准进行浮点数的比较                               |
| -msoft-float | 输出包含浮点库调用的目标代码                                 |
| -mshort      | 把int类型作为16位处理，相当于short int                       |
| -mrtd        | 强行将函数参数个数固定的函数用ret NUM返回，节省调用函数的一条指令 |

 

这些体系结构相关选项在嵌入式的设计中会有较多的应用，读者需根据不同体系结构将对应的选项进行组合处理。在本书后面涉及到具体实例会有针对性的讲解。

Gdb调试器

调试是所有程序员都会面临的问题。如何提高程序员的调试效率，更好更快地定位程序中的问题从而加快程序开发的进度，是大家共同面对的。就如读者熟知的Windows下的一些调试工具，如VC自带的如设置断点、单步跟踪等，都受到了广大用户的赞赏。那么，在Linux下有什么很好的调试工具呢？

本文所介绍的Gdb调试器是一款GNU开发组织并发布的UNIX/Linux下的程序调试工具。虽然，它没有图形化的友好界面，但是它强大的功能也足以与微软的VC工具等媲美。下面就请跟随笔者一步步学习Gdb调试器。

Gdb使用流程

首先，笔者给出了一个短小的程序，由此带领读者熟悉一下Gdb的使用流程。强烈建议读者能够实际动手操作。

首先，打开Linux下的编辑器Vi或者Emacs，编辑如下代码。（由于为了更好地熟悉Gdb的操作，笔者在此使用Vi编辑，希望读者能够参见3.3节中对Vi的介绍，并熟练使用Vi）。

 

 

\#include <stdio.h>

int sum(int m);

int main()

{

int i,n=0;

sum(50);

for(i=1; i<=50; i++)

{

n += i;

}

printf("The sum of 1-50 is %d n", n );

 

}

int sum(int m)

{

int i,n=0;

for(i=1; i<=m;i++)

n += i;

printf("The sum of 1-m is %dn", n);

}

 

在保存退出后首先使用Gcc对test.c进行编译，注意一定要加上选项”-g”，这样编译出的可执行代码中才包含调试信息，否则之后Gdb无法载入该可执行文件。

 

[root@localhost Gdb]# gcc -g test.c -o test

 

虽然这段程序没有错误，但调试完全正确的程序可以更加了解Gdb的使用流程。接下来就启动Gdb进行调试。注意，Gdb进行调试的是可执行文件，而不是如”.c”的源代码，因此，需要先通过Gcc编译生成可执行文件才能用Gdb进行调试。

 

[root@localhost Gdb]# gdb test

GNU Gdb Red Hat Linux (6.3.0.0-1.21rh)

Copyright 2004 Free Software Foundation, Inc.

GDB is free software, covered by the GNU General Public License, and you are

welcome to change it and/or distribute copies of it under certain conditions.

Type "show copying" to see the conditions.

There is absolutely no warranty for GDB. Type "show warranty" for details.

This GDB was configured as "i386-redhat-linux-gnu"...Using host libthread_db library "/lib/libthread_db.so.1".

(gdb)

 

可以看出，在Gdb的启动画面中指出了Gdb的版本号、使用的库文件等信息，接下来就进入了由“（gdb）”开头的命令行界面了。

（1）查看文件

在Gdb中键入”l”（list）就可以查看所载入的文件，如下所示：

 

|      | 注意 | 在Gdb的命令中都可使用缩略形式的命令，如“l”代便“list”，“b”代表“breakpoint”，“p”代表“print”等，读者也可使用“help”命令查看帮助信息。 |
| ---- | ---- | ------------------------------------------------------------ |
|      |      |                                                              |

 

(Gdb) l

1 #include <stdio.h>

2 int sum(int m);

3 int main()

4 {

5 int i,n=0;

6 sum(50);

7 for(i=1; i<=50; i++)

8 {

9 n += i;

10 }

(Gdb) l

11 printf("The sum of 1～50 is %d n", n );

12

13 }

14 int sum(int m)

15 {

16 int i,n=0;

17 for(i=1; i<=m;i++)

18 n += i;

19 printf("The sum of 1～m is = %dn", n);

20 }

 

可以看出，Gdb列出的源代码中明确地给出了对应的行号，这样就可以大大地方便代码的定位。

（2）设置断点

设置断点是调试程序中是一个非常重要的手段，它可以使程序到一定位置暂停它的运行。因此，程序员在该位置处可以方便地查看变量的值、堆栈情况等，从而找出代码的症结所在。

在Gdb中设置断点非常简单，只需在”b”后加入对应的行号即可（这是最常用的方式，另外还有其他方式设置断点）。如下所示：

 

(Gdb) b 6

Breakpoint 1 at 0x804846d: file test.c, line 6.

 

要注意的是，在Gdb中利用行号设置断点是指代码运行到对应行之前将其停止，如上例中，代码运行到第五行之前暂停（并没有运行第五行）。

（3）查看断点情况

在设置完断点之后，用户可以键入”info b”来查看设置断点情况，在Gdb中可以设置多个断点。

 

(Gdb) info b

Num Type Disp Enb Address What

1 breakpoint keep y 0x0804846d in main at test.c:6

 

（4）运行代码

接下来就可运行代码了，Gdb默认从首行开始运行代码，可键入”r”（run）即可（若想从程序中指定行开始运行，可在r后面加上行号）。

 

(Gdb) r

Starting program: /root/workplace/Gdb/test

Reading symbols from shared object read from target memory...done.

Loaded system supplied DSO at 0x5fb000

 

Breakpoint 1, main () at test.c:6

6 sum(50);

 

可以看到，程序运行到断点处就停止了。

（5）查看变量值

在程序停止运行之后，程序员所要做的工作是查看断点处的相关变量值。在Gdb中只需键入”p”＋变量值即可，如下所示：

 

(Gdb) p n

$1 = 0

(Gdb) p i

$2 = 134518440

 

在此处，为什么变量”i”的值为如此奇怪的一个数字呢？原因就在于程序是在断点设置的对应行之前停止的，那么在此时，并没有把”i”的数值赋为零，而只是一个随机的数字。但变量”n”是在第四行赋值的，故在此时已经为零。

 

| 小技巧 | Gdb在显示变量值时都会在对应值之前加上”$N”标记，它是当前变量值的引用标记，所以以后若想再次引用此变量就可以直接写作”$N”，而无需写冗长的变量名。 |
| ------ | ------------------------------------------------------------ |
|        |                                                              |

 

（6）单步运行

单步运行可以使用命令”n”（next）或”s”（step），它们之间的区别在于：若有函数调用的时候，”s”会进入该函数而”n”不会进入该函数。因此，”s”就类似于VC等工具中的”step in”，”n”类似与VC等工具中的”step over”。它们的使用如下所示：

 

(Gdb) n

The sum of 1-m is 1275

7 for(i=1; i<=50; i++)

(Gdb) s

sum (m=50) at test.c:16

16 int i,n=0;

 

可见，使用”n”后，程序显示函数sum的运行结果并向下执行，而使用”s”后则进入到sum函数之中单步运行。

（7）恢复程序运行

在查看完所需变量及堆栈情况后，就可以使用命令”c”（continue）恢复程序的正常运行了。这时，它会把剩余还未执行的程序执行完，并显示剩余程序中的执行结果。以下是之前使用”n”命令恢复后的执行结果：

 

(Gdb) c

Continuing.

The sum of 1-50 is :1275

 

Program exited with code 031.

 

可以看出，程序在运行完后退出，之后程序处于“停止状态”。

 

| 小知识 | 在Gdb中，程序的运行状态有“运行”、“暂停”和“停止”三种，其中“暂停”状态为程序遇到了断点或观察点之类的，程序暂时停止运行，而此时函数的地址、函数参数、函数内的局部变量都会被压入“栈”（Stack）中。故在这种状态下可以查看函数的变量值等各种属性。但在函数处于“停止”状态之后，“栈”就会自动撤销，它也就无法查看各种信息了。 |
| ------ | ------------------------------------------------------------ |
|        |                                                              |

Gdb基本命令

Gdb的命令可以通过查看help进行查找，由于Gdb的命令很多，因此Gdb的help将其分成了很多种类（class），用户可以通过进一步查看相关class找到相应命令。如下所示：

 

(gdb) help

List of classes of commands:

 

aliases -- Aliases of other commands

breakpoints -- Making program stop at certain points

data -- Examining data

files -- Specifying and examining files

internals -- Maintenance commands

…

Type "help" followed by a class name for a list of commands in that class.

Type "help" followed by command name for full documentation.

Command name abbreViations are allowed if unambiguous.

 

上述列出了Gdb各个分类的命令，注意底部的加粗部分说明其为分类命令。接下来可以具体查找各分类种的命令。如下所示：

 

(gdb) help data

Examining data.

 

List of commands:

 

call -- Call a function in the program

delete display -- Cancel some expressions to be displayed when program stops

delete mem -- Delete memory region

disable display -- Disable some expressions to be displayed when program stops

…

Type "help" followed by command name for full documentation.

Command name abbreViations are allowed if unambiguous.

 

至此，若用户想要查找call命令，就可键入“help call”。

 

(gdb) help call

Call a function in the program.

The argument is the function name and arguments, in the notation of the

current working language. The result is printed and saved in the value

history, if it is not void.

 

当然，若用户已知命令名，直接键入“help [command]”也是可以的。

Gdb中的命令主要分为以下几类：工作环境相关命令、设置断点与恢复命令、源代码查看命令、查看运行数据相关命令及修改运行参数命令。以下就分别对这几类的命令进行讲解。

1．工作环境相关命令

Gdb中不仅可以调试所运行的程序，而且还可以对程序相关的工作环境进行相应的设定，甚至还可以使用shell中的命令进行相关的操作，其功能极其强大。表3.10所示列出了Gdb常见工作环境相关命令。

表3.10 Gdb工作环境相关命令

| 命 令 格 式                  | 含义                                 |
| ---------------------------- | ------------------------------------ |
| set args运行时的参数         | 指定运行时参数，如：set args 2       |
| show args                    | 查看设置好的运行参数                 |
| path dir                     | 设定程序的运行路径                   |
| show paths                   | 查看程序的运行路径                   |
| set enVironment var [=value] | 设置环境变量                         |
| show enVironment [var]       | 查看环境变量                         |
| cd dir                       | 进入到dir目录，相当于shell中的cd命令 |
| pwd                          | 显示当前工作目录                     |
| shell command                | 运行shell的command命令               |

2．设置断点与恢复命令

Gdb中设置断点与恢复的常见命令如表3.11所示。

表3.11 Gdb设置断点与恢复相关命令

| 命 令 格 式                      | 含义                                                         |
| -------------------------------- | ------------------------------------------------------------ |
| bnfo b                           | 查看所设断点                                                 |
| break 行号或函数名 <条件表达式>  | 设置断点                                                     |
| tbreak 行号或函数名 <条件表达式> | 设置临时断点，到达后被自动删除                               |
| delete [断点号]                  | 删除指定断点，其断点号为”info b”中的第一栏。若缺省断点号则删除所有断点 |
| disable [断点号]]                | 停止指定断点，使用”info b”仍能查看此断点。同delete一样，省断点号则停止所有断点 |
| enable [断点号]                  | 激活指定断点，即激活被disable停止的断点                      |
| condition [断点号] <条件表达式>  | 修改对应断点的条件                                           |
| ignore [断点号]<num>             | 在程序执行中，忽略对应断点num次                              |
| step                             | 单步恢复程序运行，且进入函数调用                             |
| next                             | 单步恢复程序运行，但不进入函数调用                           |
| finish                           | 运行程序，直到当前函数完成返回                               |
| c                                | 继续执行函数，直到函数结束或遇到新的断点                     |

 

由于设置断点在Gdb的调试中非常重要，所以在此再着重讲解一下Gdb中设置断点的方法。

Gdb中设置断点有多种方式：其一是按行设置断点，设置方法在3.5.1节已经指出，在此就不重复了。另外还可以设置函数断点和条件断点，在此结合上一小节的代码，具体介绍后两种设置断点的方法。

① 函数断点

Gdb中按函数设置断点只需把函数名列在命令”b”之后，如下所示：

 

(gdb) b sum

Breakpoint 1 at 0x80484ba: file test.c, line 16.

(gdb) info b

Num Type Disp Enb Address What

1 breakpoint keep y 0x080484ba in sum at test.c:16

 

要注意的是，此时的断点实际是在函数的定义处，也就是在16行处（注意第16行还未执行）。

② 条件断点

Gdb中设置条件断点的格式为：b 行数或函数名 if 表达式。具体实例如下所示：

 

(gdb) b 8 if i==10

Breakpoint 1 at 0x804848c: file test.c, line 8.

(gdb) info b

Num Type Disp Enb Address What

1 breakpoint keep y 0x0804848c in main at test.c:8

stop only if i == 10

(gdb) r

Starting program: /home/yul/test

The sum of 1-m is 1275

 

Breakpoint 1, main () at test.c:9

9 n += i;

(gdb) p i

$1 = 10

 

可以看到，该例中在第8行（也就是运行完第7行的for循环）设置了一个“i==0”的条件断点，在程序运行之后可以看出，程序确实在i为10时暂停运行。

3．Gdb中源码查看相关命令

在Gdb中可以查看源码以方便其他操作，它的常见相关命令如表3.12所示：

表3.12 Gdb源码查看相关相关命令

| 命 令 格 式               | 含义                       |
| ------------------------- | -------------------------- |
| list <行号>\|<函数名>     | 查看指定位置代码           |
| file [文件名]             | 加载指定文件               |
| forward-search 正则表达式 | 源代码前向搜索             |
| reverse-search 正则表达式 | 源代码后向搜索             |
| dir dir                   | 停止路径名                 |
| show directories          | 显示定义了的源文件搜索路径 |
| info line                 | 显示加载到Gdb内存中的代码  |

4．Gdb中查看运行数据相关命令

Gdb中查看运行数据是指当程序处于“运行”或“暂停”状态时，可以查看的变量及表达式的信息，其常见命令如表3.13所示：

表3.13 Gdb查看运行数据相关命令

| 命 令 格 式        | 含义                                                         |
| ------------------ | ------------------------------------------------------------ |
| print 表达式\|变量 | 查看程序运行时对应表达式和变量的值                           |
| x <n/f/u>          | 查看内存变量内容。其中n为整数表示显示内存的长度，f表示显示的格式，u表示从当前地址往后请求显示的字节数 |
| display 表达式     | 设定在单步运行或其他情况中，自动显示的对应表达式的内容       |

5．Gdb中修改运行参数相关命令

Gdb还可以修改运行时的参数，并使该变量按照用户当前输入的值继续运行。它的设置方法为：在单步执行的过程中，键入命令“set 变量＝设定值”。这样，在此之后，程序就会按照该设定的值运行了。下面，笔者结合上一节的代码将n的初始值设为4，其代码如下所示：

 

(Gdb) b 7

Breakpoint 5 at 0x804847a: file test.c, line 7.

(Gdb) r

Starting program: /home/yul/test

The sum of 1-m is 1275

 

Breakpoint 5, main () at test.c:7

7 for(i=1; i<=50; i++)

(Gdb) set n=4

(Gdb) c

Continuing.

The sum of 1-50 is 1279

 

Program exited with code 031.

 

可以看到，最后的运行结果确实比之前的值大了4。

 

|      | Gdb的使用切记点：· 在Gcc编译选项中一定要加入”-g”。· 只有在代码处于“运行”或“暂停”状态时才能查看变量值。· 设置断点后程序在指定行之前停止。 |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

Make工程管理器

到此为止，读者已经了解了如何在Linux下使用编辑器编写代码，如何使用Gcc把代码编译成可执行文件，还学习了如何使用Gdb来调试程序，那么，所有的工作看似已经完成了，为什么还需要Make这个工程管理器呢？

所谓工程管理器，顾名思义，是指管理较多的文件的。读者可以试想一下，有一个上百个文件的代码构成的项目，如果其中只有一个或少数几个文件进行了修改，按照之前所学的Gcc编译工具，就不得不把这所有的文件重新编译一遍，因为编译器并不知道哪些文件是最近更新的，而只知道需要包含这些文件才能把源代码编译成可执行文件，于是，程序员就不能不再重新输入数目如此庞大的文件名以完成最后的编译工作。

但是，请读者仔细回想一下本书在3.1.2节中所阐述的编译过程，编译过程是分为编译、汇编、链接不同阶段的，其中编译阶段仅检查语法错误以及函数与变量的声明是否正确声明了，在链接阶段则主要完成是函数链接和全局变量的链接。因此，那些没有改动的源代码根本不需要重新编译，而只要把它们重新链接进去就可以了。所以，人们就希望有一个工程管理器能够自动识别更新了的文件代码，同时又不需要重复输入冗长的命令行，这样，Make工程管理器也就应运而生了。

实际上，Make工程管理器也就是个“自动编译管理器”，这里的“自动”是指它能够根据文件时间戳自动发现更新过的文件而减少编译的工作量，同时，它通过读入Makefile文件的内容来执行大量的编译工作。用户只需编写一次简单的编译语句就可以了。它大大提高了实际项目的工作效率，而且几乎所有Linux下的项目编程均会涉及到它，希望读者能够认真学习本节内容。

Makefile基本结构

Makefile是Make读入的惟一配置文件，因此本节的内容实际就是讲述Makefile的编写规则。在一个Makefile中通常包含如下内容：

· 需要由make工具创建的目标体（target），通常是目标文件或可执行文件；

· 要创建的目标体所依赖的文件（dependency_file）；

· 创建每个目标体时需要运行的命令（command）。

它的格式为：

 

target: dependency_files

command

 

例如，有两个文件分别为hello.c和hello.h，创建的目标体为hello.o，执行的命令为gcc编译指令：gcc –c hello.c，那么，对应的Makefile就可以写为：

 

\#The simplest example

hello.o: hello.c hello.h

gcc –c hello.c –o hello.o

 

接着就可以使用make了。使用make的格式为：make target，这样make就会自动读入Makefile（也可以是首字母小写makefile）并执行对应target的command语句，并会找到相应的依赖文件。如下所示：

 

[root@localhost makefile]# make hello.o

gcc –c hello.c –o hello.o

[root@localhost makefile]# ls

hello.c hello.h hello.o Makefile

 

可以看到，Makefile执行了“hello.o”对应的命令语句，并生成了“hello.o”目标体。

 

|      | 注意 | 在Makefile中的每一个command前必须有“Tab”符，否则在运行make命令时会出错。 |
| ---- | ---- | ------------------------------------------------------------ |
|      |      |                                                              |

Makefile变量

上面示例的Makefile在实际中是几乎不存在的，因为它过于简单，仅包含两个文件和一个命令，在这种情况下完全不必要编写Makefile而只需在Shell中直接输入即可，在实际中使用的Makefile往往是包含很多的文件和命令的，这也是Makefile产生的原因。下面就可给出稍微复杂一些的Makefile进行讲解：

 

sunq:kang.o yul.o

Gcc kang.o bar.o -o myprog

kang.o : kang.c kang.h head.h

Gcc –Wall –O -g –c kang.c -o kang.o

yul.o : bar.c head.h

Gcc - Wall –O -g –c yul.c -o yul.o

 

在这个Makefile中有三个目标体（target），分别为sunq、kang.o和yul.o，其中第一个目标体的依赖文件就是后两个目标体。如果用户使用命令“make sunq”，则make管理器就是找到sunq目标体开始执行。

这时，make会自动检查相关文件的时间戳。首先，在检查“kang.o”、“yul.o”和“sunq”三个文件的时间戳之前，它会向下查找那些把“kang.o”或“yul.o”做为目标文件的时间戳。比如，“kang.o”的依赖文件为：“kang.c”、“kang.h”、“head.h”。如果这些文件中任何一个的时间戳比“kang.o”新，则命令“gcc –Wall –O -g –c kang.c -o kang.o”将会执行，从而更新文件“kang.o”。在更新完“kang.o”或“yul.o”之后，make会检查最初的“kang.o”、“yul.o”和“sunq”三个文件，只要文件“kang.o”或“yul.o”中的任比文件时间戳比“sunq”新，则第二行命令就会被执行。这样，make就完成了自动检查时间戳的工作，开始执行编译工作。这也就是Make工作的基本流程。

接下来，为了进一步简化编辑和维护Makefile，make允许在Makefile中创建和使用变量。变量是在Makefile中定义的名字，用来代替一个文本字符串，该文本字符串称为该变量的值。在具体要求下，这些值可以代替目标体、依赖文件、命令以及makefile文件中其它部分。在Makefile中的变量定义有两种方式：一种是递归展开方式，另一种是简单方式。

递归展开方式定义的变量是在引用在该变量时进行替换的，即如果该变量包含了对其他变量的应用，则在引用该变量时一次性将内嵌的变量全部展开，虽然这种类型的变量能够很好地完成用户的指令，但是它也有严重的缺点，如不能在变量后追加内容（因为语句：CFLAGS = $(CFLAGS) -O在变量扩展过程中可能导致无穷循环）。

为了避免上述问题，简单扩展型变量的值在定义处展开，并且只展开一次，因此它不包含任何对其它变量的引用，从而消除变量的嵌套引用。

递归展开方式的定义格式为：VAR=var

简单扩展方式的定义格式为：VAR：=var

Make中的变量使用均使用格式为：$(VAR)

 

|      | 注意 | 变量名是不包括“:”、“#”、“=”结尾空格的任何字符串。同时，变量名中包含字母、数字以及下划线以外的情况应尽量避免，因为它们可能在将来被赋予特别的含义。变量名是大小写敏感的，例如变量名“foo”、“FOO”、和“Foo”代表不同的变量。推荐在makefile内部使用小写字母作为变量名，预留大写字母作为控制隐含规则参数或用户重载命令选项参数的变量名。 |
| ---- | ---- | ------------------------------------------------------------ |
|      |      |                                                              |

 

下面给出了上例中用变量替换修改后的Makefile，这里用OBJS代替kang.o和yul.o，用CC代替Gcc，用CFLAGS代替“-Wall -O –g”。这样在以后修改时，就可以只修改变量定义，而不需要修改下面的定义实体，从而大大简化了Makefile维护的工作量。

经变量替换后的Makefile如下所示：

 

OBJS = kang.o yul.o

CC = Gcc

CFLAGS = -Wall -O -g

sunq : $(OBJS)

$(CC) $(OBJS) -o sunq

kang.o : kang.c kang.h

$(CC) $(CFLAGS) -c kang.c -o kang.o

yul.o : yul.c yul.h

$(CC) $(CFLAGS) -c yul.c -o yul.o

 

可以看到，此处变量是以递归展开方式定义的。

Makefile中的变量分为用户自定义变量、预定义变量、自动变量及环境变量。如上例中的OBJS就是用户自定义变量，自定义变量的值由用户自行设定，而预定义变量和自动变量为通常在Makefile都会出现的变量，其中部分有默认值，也就是常见的设定值，当然用户可以对其进行修改。

预定义变量包含了常见编译器、汇编器的名称及其编译选项。下表3.14列出了Makefile中常见预定义变量及其部分默认值。

表3.14 Makefile中常见预定义变量

| 命 令 格 式 | 含义                              |
| ----------- | --------------------------------- |
| AR          | 库文件维护程序的名称，默认值为ar  |
| AS          | 汇编程序的名称，默认值为as        |
| CC          | C编译器的名称，默认值为cc         |
| CPP         | C预编译器的名称，默认值为$(CC) –E |
| CXX         | C++编译器的名称，默认值为g++      |
| FC          | FORTRAN编译器的名称，默认值为f77  |
| RM          | 文件删除程序的名称，默认值为rm –f |
| ARFLAGS     | 库文件维护程序的选项，无默认值    |
| ASFLAGS     | 汇编程序的选项，无默认值          |
| CFLAGS      | C编译器的选项，无默认值           |
| CPPFLAGS    | C预编译的选项，无默认值           |
| CXXFLAGS    | C++编译器的选项，无默认值         |
| FFLAGS      | FORTRAN编译器的选项，无默认值     |

 

可以看出，上例中的CC和CFLAGS是预定义变量，其中由于CC没有采用默认值，因此，需要把“CC=Gcc”明确列出来。

由于常见的Gcc编译语句中通常包含了目标文件和依赖文件，而这些文件在Makefile文件中目标体的一行已经有所体现，因此，为了进一步简化Makefile的编写，就引入了自动变量。自动变量通常可以代表编译语句中出现目标文件和依赖文件等，并且具有本地含义（即下一语句中出现的相同变量代表的是下一语句的目标文件和依赖文件）。下表3.15列出了Makefile中常见自动变量。

表3.15Makefile中常见自动变量

| 命令格式 | 含义                                                         |
| -------- | ------------------------------------------------------------ |
| $*       | 不包含扩展名的目标文件名称                                   |
| $+       | 所有的依赖文件，以空格分开，并以出现的先后为序，可能包含重复的依赖文件 |
| $<       | 第一个依赖文件的名称                                         |
| $?       | 所有时间戳比目标文件晚的依赖文件，并以空格分开               |
| 命令格式 | 含义                                                         |
| $@       | 目标文件的完整名称                                           |
| $^       | 所有不重复的依赖文件，以空格分开                             |
| $%       | 如果目标是归档成员，则该变量表示目标的归档成员名称           |

 

自动变量的书写比较难记，但是在熟练了之后会非常的方便，请读者结合下例中的自动变量改写的Makefile进行记忆。

 

OBJS = kang.o yul.o

CC = Gcc

CFLAGS = -Wall -O -g

sunq : $(OBJS)

$(CC) $^ -o $@

kang.o : kang.c kang.h

$(CC) $(CFLAGS) -c $< -o $@

yul.o : yul.c yul.h

$(CC) $(CFLAGS) -c $< -o $@

 

另外，在Makefile中还可以使用环境变量。使用环境变量的方法相对比较简单，make在启动时会自动读取系统当前已经定义了的环境变量，并且会创建与之具有相同名称和数值的变量。但是，如果用户在Makefile中定义了相同名称的变量，那么用户自定义变量将会覆盖同名的环境变量。

Makefile规则

Makefile的规则是Make进行处理的依据，它包括了目标体、依赖文件及其之间的命令语句。一般的，Makefile中的一条语句就是一个规则。在上面的例子中，都显示地指出了Makefile中的规则关系，如“$(CC) $(CFLAGS) -c $< -o $@”，但为了简化Makefile的编写，make还定义了隐式规则和模式规则，下面就分别对其进行讲解。

1．隐式规则

隐含规则能够告诉make怎样使用传统的技术完成任务，这样，当用户使用它们时就不必详细指定编译的具体细节，而只需把目标文件列出即可。Make会自动搜索隐式规则目录来确定如何生成目标文件。如上例就可以写成：

 

OBJS = kang.o yul.o

CC = Gcc

CFLAGS = -Wall -O -g

sunq : $(OBJS)

$(CC) $^ -o $@

 

为什么可以省略后两句呢？因为Make的隐式规则指出：所有“.o”文件都可自动由“.c”文件使用命令“$(CC) $(CPPFLAGS) $(CFLAGS) -c file.c –o file.o”生成。这样“kang.o”和“yul.o”就会分别调用“$(CC) $(CFLAGS) -c kang.c -o kang.o”和“$(CC) $(CFLAGS) -c yul.c -o yul.o”生成。

 

|      | 注意 | 在隐式规则只能查找到相同文件名的不同后缀名文件，如”kang.o”文件必须由”kang.c”文件生成。 |
| ---- | ---- | ------------------------------------------------------------ |
|      |      |                                                              |

 

下表3.16给出了常见的隐式规则目录：

表3.16 Makefile中常见隐式规则目录

| 对应语言后缀名         | 规则                              |
| ---------------------- | --------------------------------- |
| C编译：.c变为.o        | $(CC) –c $(CPPFLAGS) $(CFLAGS)    |
| C++编译：.cc或.C变为.o | $(CXX) -c $(CPPFLAGS) $(CXXFLAGS) |
| Pascal编译：.p变为.o   | $(PC) -c $(PFLAGS)                |
| Fortran编译：.r变为-o  | $(FC) -c $(FFLAGS)                |

2．模式规则

模式规则是用来定义相同处理规则的多个文件的。它不同于隐式规则，隐式规则仅仅能够用make默认的变量来进行操作，而模式规则还能引入用户自定义变量，为多个文件建立相同的规则，从而简化Makefile的编写。

模式规则的格式类似于普通规则，这个规则中的相关文件前必须用“%”标明。使用模式规则修改后的Makefile的编写如下：

 

OBJS = kang.o yul.o

CC = Gcc

CFLAGS = -Wall -O -g

sunq : $(OBJS)

$(CC) $^ -o $@

%.o : %.c

$(CC) $(CFLAGS) -c $< -o $@

Make使用

使用make管理器非常简单，只需在make命令的后面键入目标名即可建立指定的目标，如果直接运行make，则建立Makefile中的第一个目标。

此外make还有丰富的命令行选项，可以完成各种不同的功能。下表3.17列出了常用的make命令行选项。

表3.17 make的命令行选项

| 命令格式 | 含 义                                          |
| -------- | ---------------------------------------------- |
| -C dir   | 读入指定目录下的Makefile                       |
| -f file  | 读入当前目录下的file文件作为Makefile           |
| 命令格式 | 含 义                                          |
| -i       | 忽略所有的命令执行错误                         |
| -I dir   | 指定被包含的Makefile所在目录                   |
| -n       | 只打印要执行的命令，但不执行这些命令           |
| -p       | 显示make变量数据库和隐含规则                   |
| -s       | 在执行命令时不显示命令                         |
| -w       | 如果make在执行过程中改变目录，则打印当前目录名 |

使用autotools

在上一小节，读者已经了解到了make项目管理器的强大功能。的确，Makefile可以帮助make完成它的使命，但要承认的是，编写Makefile确实不是一件轻松的事，尤其对于一个较大的项目而言更是如此。那么，有没有一种轻松的手段生成Makefile而同时又能让用户享受make的优越性呢？本节要讲的autotools系列工具正是为此而设的，它只需用户输入简单的目标文件、依赖文件、文件目录等就可以轻松地生成Makefile了，这无疑是广大用户的所希望的。另外，这些工具还可以完成系统配置信息的收集，从而可以方便地处理各种移植性的问题。也正是基于此，现在Linux上的软件开发一般都用autotools来制作Makefile，读者在后面的讲述中就会了解到。

autotools使用流程

正如前面所言，autotools是系列工具，读者首先要确认系统是否装了以下工具（可以用which命令进行查看）。

· aclocal

· autoscan

· autoconf

· autoheader

· automake

使用autotools主要就是利用各个工具的脚本文件以生成最后的Makefile。其总体流程是这样的：

· 使用aclocal生成一个“aclocal.m4”文件，该文件主要处理本地的宏定义；

· 改写“configure.scan”文件，并将其重命名为“configure.in”，并使用autoconf文件生成configure文件。

接下来，笔者将通过一个简单的hello.c例子带领读者熟悉autotools生成makefile的过程，由于在这过程中有涉及到较多的脚本文件，为了更清楚地了解相互之间的关系，强烈建议读者实际动手操作以体会其整个过程。

1．autoscan

它会在给定目录及其子目录树中检查源文件，若没有给出目录，就在当前目录及其子目录树中进行检查。它会搜索源文件以寻找一般的移植性问题并创建一个文件“configure.scan”，该文件就是接下来autoconf要用到的“configure.in”原型。如下所示：

 

[root@localhost automake]# autoscan

autom4te: configure.ac: no such file or directory

autoscan: /usr/bin/autom4te failed with exit status: 1

[root@localhost automake]# ls

autoscan.log configure.scan hello.c

 

如上所示，autoscan首先会尝试去读入“configure.ac”（同configure.in的配置文件）文件，此时还没有创建该配置文件，于是它会自动生成一个“configure.in”的原型文件“configure.scan”。

2．autoconf

configure.in是autoconf的脚本配置文件，它的原型文件“configure.scan”如下所示：

 

\# -*- Autoconf -*-

\# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.59)

\#The next one is modified by sunq

\#AC_INIT(FULL-PACKAGE-NAME,VERSION,BUG-REPORT-ADDRESS)

AC_INIT(hello,1.0)

\# The next one is added by sunq

AM_INIT_AUTOMAKE(hello,1.0)

AC_CONFIG_SRCDIR([hello.c])

AC_CONFIG_HEADER([config.h])

\# Checks for programs.

AC_PROG_CC

\# Checks for libraries.

\# Checks for header files.

\# Checks for typedefs, structures, and compiler characteristics.

\# Checks for library functions.

AC_CONFIG_FILES([Makefile])

AC_OUTPUT

 

下面对这个脚本文件进行解释：

· 以“#”号开始的行为注释。

· AC_PREREQ宏声明本文件要求的autoconf版本，如本例使用的版本2.59。

· AC_INIT宏用来定义软件的名称和版本等信息，在本例中省略了BUG-REPORT-ADDRESS，一般为作者的e-mail。

· AM_INIT_AUTOMAKE是笔者另加的，它是automake所必备的宏，也同前面一样，PACKAGE是所要产生软件套件的名称，VERSION是版本编号。

· AC_CONFIG_SRCDIR宏用来侦测所指定的源码文件是否存在，来确定源码目录的有

效性。在此处为当前目录下的hello.c。

· AC_CONFIG_HEADER宏用于生成config.h文件，以便autoheader使用。

· AC_CONFIG_FILES宏用于生成相应的Makefile文件。

· 中间的注释间可以添加分别用户测试程序、测试函数库、测试头文件等宏定义。

接下来首先运行aclocal，生成一个“aclocal.m4”文件，该文件主要处理本地的宏定义。如下所示：

 

[root@localhost automake]# aclocal

 

再接着运行autoconf，生成“configure”可执行文件。如下所示：

 

[root@localhost automake]# autoconf

[root@localhost automake]# ls

aclocal.m4 autom4te.cache autoscan.log configure configure.in hello.c

3．autoheader

接着使用autoheader命令，它负责生成config.h.in文件。该工具通常会从“acconfig.h”文件中复制用户附加的符号定义，因此此处没有附加符号定义，所以不需要创建“acconfig.h”文件。如下所示：

 

[root@localhost automake]# autoheader

4．automake

这一步是创建Makefile很重要的一步，automake要用的脚本配置文件是Makefile.am，用户需要自己创建相应的文件。之后，automake工具转换成Makefile.in。在该例中，笔者创建的文件为Makefile.am如下所示：

 

AUTOMAKE_OPTIONS=foreign

bin_PROGRAMS= hello

hello_SOURCES= hello.c

 

下面对该脚本文件的对应项进行解释。

· 其中的AUTOMAKE_OPTIONS为设置automake的选项。由于GNU（在第1章中已经有所介绍）对自己发布的软件有严格的规范，比如必须附带许可证声明文件COPYING等，否则automake执行时会报错。automake提供了三种软件等级：foreign、gnu和gnits，让用户选择采用，默认等级为gnu。在本例使用foreign等级，它只检测必须的文件。

· bin_PROGRAMS定义要产生的执行文件名。如果要产生多个执行文件，每个文件名用空格隔开。

· hello_SOURCES定义“hello”这个执行程序所需要的原始文件。如果”hello”这个程序是由多个原始文件所产生的，则必须把它所用到的所有原始文件都列出来，并用空格隔开。例如：若目标体“hello”需要“hello.c”、“sunq.c”、“hello.h”三个依赖文件，则定义hello_SOURCES=hello.c sunq.c hello.h。要注意的是，如果要定义多个执行文件，则对每个执行程序都要定义相应的file_SOURCES。

接下来可以使用automake对其生成“configure.in”文件，在这里使用选项“—adding-missing”可以让automake自动添加有一些必需的脚本文件。如下所示：

 

[root@localhost automake]# automake --add-missing

configure.in: installing './install-sh'

configure.in: installing './missing'

Makefile.am: installing 'depcomp'

[root@localhost automake]# ls

aclocal.m4 autoscan.log configure.in hello.c Makefile.am missing

autom4te.cache configure depcomp install-sh Makefile.in config.h.in

 

可以看到，在automake之后就可以生成configure.in文件。

5．运行configure

在这一步中，通过运行自动配置设置文件configure，把Makefile.in变成了最终的Makefile。如下所示：

 

[root@localhost automake]# ./configure

checking for a BSD-compatible install... /usr/bin/install -c

checking whether build enVironment is sane... yes

checking for gawk... gawk

checking whether make sets $(MAKE)... yes

checking for Gcc... Gcc

checking for C compiler default output file name... a.out

checking whether the C compiler works... yes

checking whether we are cross compiling... no

checking for suffix of executables...

checking for suffix of object files... o

checking whether we are using the GNU C compiler... yes

checking whether Gcc accepts -g... yes

checking for Gcc option to accept ANSI C... none needed

checking for style of include used by make... GNU

checking dependency style of Gcc... Gcc3

configure: creating ./config.status

config.status: creating Makefile

config.status: executing depfiles commands

可以看到，在运行configure时收集了系统的信息，用户可以在configure命令中对其进行方便地配置。在./configure的自定义参数有两种，一种是开关式（--enable-XXX或--disable-XXX），另一种是开放式，即后面要填入一串字符（--with-XXX=yyyy）参数。读者可以自行尝试其使用方法。另外，读者可以查看同一目录下的”config.log”文件，以方便调试之用。

到此为止，makefile就可以自动生成了。回忆整个步骤，用户不再需要定制不同的规则，而只需要输入简单的文件及目录名即可，这样就大大方便了用户的使用。下面的图3.9总结了上述过程：

 

图3.9 autotools生成Makefile流程图

使用autotools所生成的Makefile

autotools生成的Makefile除具有普通的编译功能外，还具有以下主要功能（感兴趣的读者可以查看这个简单的hello.c程序的makefile）：

1．make

键入make默认执行”make all”命令，即目标体为all，其执行情况如下所示：

 

[root@localhost automake]# make

if Gcc -DPACKAGE_NAME="" -DPACKAGE_TARNAME="" -DPACKAGE_VERSION="" -DPACKAGE_STRING="" -DPACKAGE_BUGREPORT="" -DPACKAGE="hello" -DVERSION="1.0" -I. -I. -g -O2 -MT hello.o -MD -MP -MF ".deps/hello.Tpo" -c -o hello.o hello.c;

then mv -f ".deps/hello.Tpo" ".deps/hello.Po"; else rm -f ".deps/hello.Tpo"; exit 1; fi

Gcc -g -O2 -o hello hello.o

此时在本目录下就生成了可执行文件“hello”，运行“./hello”能出现正常结果，如下所示：

 

[root@localhost automake]# ./hello

Hello!Autoconf!

2．make install

此时，会把该程序安装到系统目录中去，如下所示：

 

[root@localhost automake]# make install

if Gcc -DPACKAGE_NAME="" -DPACKAGE_TARNAME="" -DPACKAGE_VERSION="" -DPACKAGE_STRING="" -DPACKAGE_BUGREPORT="" -DPACKAGE="hello" -DVERSION="1.0" -I. -I. -g -O2 -MT hello.o -MD -MP -MF ".deps/hello.Tpo" -c -o hello.o hello.c;

then mv -f ".deps/hello.Tpo" ".deps/hello.Po"; else rm -f ".deps/hello.Tpo"; exit 1; fi

Gcc -g -O2 -o hello hello.o

make[1]: Entering directory '/root/workplace/automake'

test -z "/usr/local/bin" || mkdir -p -- "/usr/local/bin"

/usr/bin/install -c 'hello' '/usr/local/bin/hello'

make[1]: Nothing to be done for 'install-data-am'.

make[1]: LeaVing directory '/root/workplace/automake'

 

此时，若直接运行hello，也能出现正确结果，如下所示：

 

[root@localhost automake]# hello

Hello!Autoconf!

3．make clean

此时，make会清除之前所编译的可执行文件及目标文件（object file, *.o），如下所示：

 

[root@localhost automake]# make clean

test -z "hello" || rm -f hello

rm -f *.o

4．make dist

此时，make将程序和相关的文档打包为一个压缩文档以供发布，如下所示：

 

[root@localhost automake]# make dist

[root@localhost automake]# ls hello-1.0-tar.gz

hello-1.0-tar.gz

 

可见该命令生成了一个hello-1.0-tar.gz的压缩文件。

由上面的讲述读者不难看出，autotools确实是软件维护与发布的必备工具，也鉴于此，如今GUN的软件一般都是由automake来制作的。

 

|      | 想一想 | 对于automake制作的这类软件，应如何安装呢？ |
| ---- | ------ | ------------------------------------------ |
|      |        |                                            |

Vi使用练习

1．实验目的

通过指定指令的Vi操作练习，使读者能够熟练使用Vi中的常见操作，并且熟悉Vi的三种模式，如果读者能够熟练掌握实验内容中所要求的内容，则表明对Vi的操作已经很熟练了。

2．实验内容

（1）在“/root”目录下建一个名为“/Vi”的目录。

（2）进入“/Vi”目录。

（3）将文件“/etc/inittab”复制到“/Vi”目录下。

（4）使用Vi打开“/Vi”目录下的inittab。

（5）设定行号，指出设定initdefault（类似于“id:5:initdefault”）的所在行号。

（6）将光标移到该行。

（7）复制该行内容。

（8）将光标移到最后一行行首。

（9）粘贴复制行的内容。

（10）撤销第9步的动作。

（11）将光标移动到最后一行的行尾。

（12）粘贴复制行的内容。

（13）光标移到“si::sysinit:/etc/rc.d/rc.sysinit”。

（14）删除该行。

（15）存盘但不退出。

（16）将光标移到首行。

（17）插入模式下输入“Hello,this is Vi world!”。

（18）返回命令行模式。

（19）向下查找字符串“0:wait”。

（20）再向上查找字符串“halt”。

（21）强制退出Vi，不存盘。

分别指出每个命令处于何种模式下？

3．实验步骤

（1）mkdir /root/Vi

（2）cd /root/Vi

（3）cp /etc/inittab ./

（4）Vi ./inittab

（5）:set nu（底行模式）

（6）17<enter>（命令行模式）

（7）yy

（8）G

（9）p

（10）u

（11）$

（12）p

（13）21G

（14）dd

（15）:w（底行模式）

（16）1G

（17）i 并输入“Hello,this is Vi world!”（插入模式）

（18）Esc

（19）/0:wait（命令行模式）

（20）?halt

（21）:q!（底行模式）

4．实验结果

该实验最后的结果只对“/root/inittab”增加了一行复制的内容：“id:5:initdefault”。

用Gdb调试有问题的程序

1．实验目的

通过调试一个有问题的程序，使读者进一步熟练使用Vi操作，而且熟练掌握Gcc编译命令及Gdb的调试命令，通过对有问题程序的跟踪调试，进一步提高发现问题和解决问题的能力。这是一个很小的程序，只有35行，希望读者认真调试。

2．实验内容

（1）使用Vi编辑器，将以下代码输入到名为greet.c的文件中。此代码的原意为输出倒序main函数中定义的字符串，但结果显示没有输出。代码如下所示：

 

\#include <stdio.h>

int display1(char *string);

int display2(char *string);

 

int main ()

{

char string[] = "Embedded Linux";

display1 (string);

display2 (string);

}

int display1 (char *string)

{

printf ("The original string is %s n", string);

}

int display2 (char *string1)

{

char *string2;

int size,i;

size = strlen (string1);

string2 = (char *) malloc (size + 1);

for (i = 0; i < size; i++)

string2[size - i] = string1[i];

string2[size+1] = ' ';

printf("The string afterward is %sn",string2);

}

 

（2）使用Gcc编译这段代码，注意要加上“-g”选项以方便之后的调试。

（3）运行生成的可执行文件，观察运行结果。

（4）使用Gdb调试程序，通过设置断点、单步跟踪，一步步找出错误所在。

（5）纠正错误，更改源程序并得到正确的结果。

3．实验步骤

（1）在工作目录上新建文件greet.c，并用Vi启动：vi greet.c。

（2）在Vi中输入以上代码。

（3）在Vi中保存并退出：wq。

（4）用Gcc编译：gcc -g greet.c -o greet。

（5）运行greet：./greet，输出为：

 

The original string is Embedded Linux

The string afterward is

 

可见，该程序没有能够倒序输出。

（6）启动Gdb调试：gdb greet。

（7）查看源代码，使用命令“l”。

（8）在30行（for循环处）设置断点，使用命令“b 30”。

（9）在33行（printf函数处）设置断点，使用命令“b 33”。

（10）查看断点设置情况，使用命令“info b”。

（11）运行代码，使用命令“r”。

（12）单步运行代码，使用命令“n”。

（13）查看暂停点变量值，使用命令“p string2[size - i]”。

（14）继续单步运行代码数次，并使用命令查看，发现string2[size-1]的值正确。

（15）继续程序的运行，使用命令“c”。

（16）程序在printf前停止运行，此时依次查看string2[0]、string2[1]…，发现string[0]没有被正确赋值，而后面的复制都是正确的，这时，定位程序第31行，发现程序运行结果错误的原因在于“size-1”。由于i只能增到“size-1”，这样string2[0]就永远不能被赋值而保持NULL，故输不出任何结果。

（17）退出Gdb，使用命令q。

（18）重新编辑greet.c，把其中的“string2[size - i] = string1[i]”改为“string2[size – i - 1] = string1[i];”即可。

（19）使用Gcc重新编译：gcc -g greet.c -o greet。

（20）查看运行结果：./greet

 

The original string is Embedded Linux

The string afterward is xuniL deddedbmE

 

这时，输入结果正确。

4．实验结果

将原来有错的程序经过Gdb调试，找出问题所在，并修改源代码，输出正确的倒序显示字符串的结果。

编写包含多文件的Makefile

1．实验目的

通过对包含多文件的Makefile的编写，熟悉各种形式的Makefile，并且进一步加深对Makefile中用户自定义变量、自动变量及预定义变量的理解。

2．实验过程

（1）用Vi在同一目录下编辑两个简单的Hello程序，如下所示：

 

\#hello.c

\#include "hello.h"

int main()

{

printf("Hello everyone!n");

}

\#hello.h

\#include <stdio.h>

 

（2）仍在同一目录下用Vi编辑Makefile，且不使用变量替换，用一个目标体实现（即直接将hello.c和hello.h编译成hello目标体）。然后用make验证所编写的Makefile是否正确。

（3）将上述Makefile使用变量替换实现。同样用make验证所编写的Makefile是否正确

（4）用编辑另一Makefile，取名为Makefile1，不使用变量替换，但用两个目标体实现（也就是首先将hello.c和hello.h编译为hello.o，再将hello.o编译为hello），再用make的”-f”选项验证这个Makefile1的正确性。

（5）将上述Makefile1使用变量替换实现。

3．实验步骤

（1）用Vi打开上述两个代码文件“hello.c”和“hello.h”。

（2）在shell命令行中用Gcc尝试编译，使用命令：”Gcc hello.c –o hello”，并运行hello可执行文件查看结果。

（3）删除此次编译的可执行文件：rm hello。

（4）用Vi编辑Makefile，如下所示：

 

hello:hello.c hello.h

Gcc hello.c -o hello

 

（5）退出保存，在shell中键入：make，查看结果。

（6）再次用Vi打开Makefile，用变量进行替换，如下所示：

 

OBJS :=hello.o

CC :=Gcc

hello:$(OBJS)

$(CC) $^ -o $@

 

（7）退出保存，在shell中键入：make，查看结果。

（8）用Vi编辑Makefile1，如下所示：

 

hello:hello.o

Gcc hello.o -o hello

hello.o:hello.c hello.h

Gcc -c hello.c -o hello.o

 

（9）退出保存，在shell中键入：make -f Makefile1，查看结果。

（10）再次用Vi编辑Makefile1，如下所示：

 

OBJS1 :=hello.o

OBJS2 :=hello.c hello.h

CC :=Gcc

hello:$(OBJS1)

$(CC) $^ -o $@

$(OBJS1):$(OBJS2)

$(CC) -c $< -o $@

 

在这里请注意区别“$^”和“$<”。

（11）退出保存，在shell中键入：make -f Makefile1，查看结果

4．实验结果

各种不同形式的makefile都能完成其正确的功能。

使用autotools生成包含多文件的Makefile

1．实验目的

通过使用autotools生成包含多文件的Makefile，进一步掌握autotools的正确使用方法。同时，掌握Linux下安装软件的常用方法。

2．实验过程

（1）在原目录下新建文件夹auto。

（2）利用上例的两个代码文件“hello.c”和“hello.h”，并将它们复制到该目录下。

（3）使用autoscan生成configure.scan。

（4）编辑configure.scan，修改相关内容，并将其重命名为configure.in。

（5）使用aclocal生成aclocal.m4。

（6）使用autoconf生成configure。

（7）使用autoheader生成config.in.h。

（8）编辑Makefile.am。

（9）使用automake生成Makefile.in。

（10）使用configure生成Makefile。

（11）使用make生成hello可执行文件，并在当前目录下运行hello查看结果。

（12）使用make install将hello安装到系统目录下，并运行，查看结果。

（13）使用make dist生成hello压缩包。

（14）解压hello压缩包。

（15）进入解压目录。

（16）在该目录下安装hello软件。

3．实验步骤

（1）mkdir ./auto。

（2）cp hello.* ./auto（假定原先在“hello.c”文件目录下）。

（3）命令：autoscan。

（4）使用Vi编辑configure.scan为：

 

\# -*- Autoconf -*-

\# Process this file with autoconf to produce a configure script.

 

AC_PREREQ(2.59)

AC_INIT(hello, 1.0)

AM_INIT_AUTOMAKE(hello,1.0)

AC_CONFIG_SRCDIR([hello.h])

AC_CONFIG_HEADER([config.h])

\# Checks for programs.

AC_PROG_CC

\# Checks for libraries.

\# Checks for header files.

\# Checks for typedefs, structures, and compiler characteristics.

\# Checks for library functions.

AC_OUTPUT(Makefile)

 

（5）保存退出，并重命名为configure.in。

（6）运行：aclocal。

（7）运行：autoconf，并用ls查看是否生成了configure可执行文件。

（8）运行：autoheader。

（9）用Vi编辑Makefile.am文件为：

 

AUTOMAKE_OPTIONS=foreign

bin_PROGRAMS=hello

hello_SOURCES=hello.c hello.h

 

（10）运行：automake。

（11）运行：./configure。

（12）运行：make。

（13）运行：./hello，查看结果是否正确。

（14）运行：make install。

（15）运行：hello，查看结果是否正确。

（16）运行：make dist。

（17）在当前目录下解压hello-1.0.tar.gz：tar –zxvf hello-1.0.tar.gz。

（18）进入解压目录：cd ./hello-1.0。

（19）下面开始Linux下常见的安装软件步骤：./configure。

（20）运行：make。

（21）运行：./hello（在正常安装时这一步可省略）。

（22）运行：make install。

（23）运行：hello，查看结果是否正确。

4．实验结果

能够正确使用autotools生成Makefile，并且能够安装成功短小的Hello软件。

C语言再学习 -- GCC编译过程

聚优致成 2016-11-25 21:04:42  13447  收藏 19
分类专栏： C语言再学习
版权

C语言再学习
同时被 2 个专栏收录
77 篇文章35 订阅
订阅专栏

C语言再学习
58 篇文章226 订阅
订阅专栏
参看：GCC编译过程分解

一、GCC简介：

gcc的原名叫做GNU C语言 编译器（GNU C Compile），只能编译C语言程序，后来很快就做了扩展，支持了更多的编程语言，比如C+ Object-c ...，改名为GNC 编译器 套件（GNU Compile Collection） 支持很多的硬件和操作系统。

二、编译过程

C语言的编译过程可分为四个阶段：预处理->>编译->>汇编->>链接

下面以hello.c为示例详细介绍各个编译过程：


//示例hello.c
#include <stdio.h>
int main (void)
{
	printf ("hello world!\n");
	return 0;
}
1、预处理

预编译过程主要处理那些源代码中以#开始的预编译指令，主要处理规则如下：
1）将所有的#define删除，并且展开所有的宏定义；
2）处理所有条件编译指令，如#if，#ifdef等；
3）处理#include预编译指令，将被包含的文件插入到该预编译指令的位置。该过程递归进行，及被包含的文件可能还包含其他文件。
4）删除所有的注释//和 /**/；
5）添加行号和文件标识，如#2 “hello.c” 2,以便于编译时编译器产生调试用的行号信息及用于编译时产生编译错误或警告时能够显示行号信息；
6）保留所有的#pragma编译器指令，因为编译器须要使用它们；

gcc -E hello.c -o hello.i   得到一个.i为后缀的预处理之后的文件，该文件叫做预处理文件，以下为预处理后的输出文件hello.i的内容：


# 1 "hello.c"
# 1 "<built-in>"
# 1 "<命令行>"
# 1 "hello.c"
# 1 "/usr/include/stdio.h" 1 3 4
# 28 "/usr/include/stdio.h" 3 4

/***** 省略了部分内容,包括stdio.h中的一些声明及定义  *****/

# 2 "hello.c" 2
int main (void)
{
 printf ("hello world!\n");
 return 0;
}
2、编译

编译过程就是把预处理完的文件进行一系列词法分析，语法分析，语义分析及优化后生成相应的汇编代码文件。

gcc -S hello.i -o hello.s   得到一个.s为后缀的汇编文件，以下为编译后的输出文件hello.s的内容：


	.file	"hello.c"
	.section	.rodata
.LC0:
	.string	"hello world!"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$16, %esp
	movl	$.LC0, (%esp)
	call	puts
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",@progbits

3、汇编
汇编器是将汇编代码转变成机器可以执行的命令，每一个汇编语句几乎都对应一条机器指令。汇编相对于编译过程比较简单，根据汇编指令和机器指令的对照表一一翻译即可。

gcc –c hello.s –o hello.o，得到一个.o为后缀的目标文件，由于hello.o的内容为机器码，不能以文本形式方便的呈现。可用命令hexdump hello.o 打开。

4、链接

目标代码不能直接执行，要想将目标代码变成可执行程序，还需要进行链接操作。才会生成真正可以执行的可执行程序。链接操作最重要的步骤就是将函数库中相应的代码组合到目标文件中。

gcc hello.o -o hello，实现链接的处理，默认生成可执行文件 a.out，可以通过 -o来指定输出文件名。



使用ld指令
ld -static crt1.o crti.o crtbeginT.o hello.o -start -group -lgcc -lgcc_eh -lc -end-group crtend.o crtn.o 

（目标文件，未指定具体目录）
连接的过程包括按序叠加、相似段合并、符号地址的确定、符号解析与重定位、指令修正、全局构造与解析等等

tarena@ubuntu:~/project/c_test$ gcc -v
使用内建 specs。
COLLECT_GCC=gcc.real
COLLECT_LTO_WRAPPER=/usr/lib/gcc/i686-linux-gnu/4.6/lto-wrapper
目标：i686-linux-gnu
配置为：../src/configure -v --with-pkgversion='Ubuntu/Linaro 4.6.3-1ubuntu5' --with-bugurl=file:///usr/share/doc/gcc-4.6/README.Bugs --enable-languages=c,c++,fortran,objc,obj-c++ --prefix=/usr --program-suffix=-4.6 --enable-shared --enable-linker-build-id --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --with-gxx-include-dir=/usr/include/c++/4.6 --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --enable-gnu-unique-object --enable-plugin --enable-objc-gc --enable-targets=all --disable-werror --with-arch-32=i686 --with-tune=generic --enable-checking=release --build=i686-linux-gnu --host=i686-linux-gnu --target=i686-linux-gnu
线程模型：posix
gcc 版本 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) 

tarena@ubuntu:/$ find /usr -name crt*
/usr/lib/i386-linux-gnu/crti.o
/usr/lib/i386-linux-gnu/crt1.o
/usr/lib/i386-linux-gnu/crtn.o
/usr/lib/gcc/i686-linux-gnu/4.6/crtbeginT.o
/usr/lib/gcc/i686-linux-gnu/4.6/crtfastmath.o
/usr/lib/gcc/i686-linux-gnu/4.6/crtend.o
/usr/lib/gcc/i686-linux-gnu/4.6/crtprec80.o
/usr/lib/gcc/i686-linux-gnu/4.6/crtprec32.o
/usr/lib/gcc/i686-linux-gnu/4.6/crtbeginS.o
/usr/lib/gcc/i686-linux-gnu/4.6/crtbegin.o
/usr/lib/gcc/i686-linux-gnu/4.6/crtendS.o
/usr/lib/gcc/i686-linux-gnu/4.6/crtprec64.o
tarena@ubuntu:~/project/c_test$ ld -static -verbose /usr/lib/i386-linux-gnu/crt1.o /usr/lib/i386-linux-gnu/crti.o /usr/lib/gcc/i686-linux-gnu/4.6/crtbeginT.o -L/usr/lib/gcc/i686-linux-gnu/4.6 -L/usr/lib/i386-linux-gnu hello.o -start -group -lgcc -lgcc_eh -lc -end-group /usr/lib/gcc/i686-linux-gnu/4.6/crtend.o /usr/lib/i386-linux-gnu/crtn.o 
GNU ld (GNU Binutils for Ubuntu) 2.22
  Supported emulations:
   elf_i386
   i386linux
   elf32_x86_64
   elf_x86_64
   elf_l1om
   elf_k1om
ld: bad -rpath option 


gcc版本不对，支持的是 i386linux，如果想深入研究，安装gcc 4.1.2：
参看：ld script初探

可以直接通过 gcc hello.c -o hello来生成可执行文件，这只是把中步操作隐藏起来了



注意：gcc -c hello.o -o hello 是错误的


tarena@ubuntu:~/project/c_test$ gcc -c hello.o -o hello
gcc.real: 警告： hello.o：未使用链接器输入文件，因为链接尚未完成


注意：目标文件和可执行文件的不同


# gcc -c hello.c 
生成 hello.o  /*目标文件*/
# file hello.o
hello.o: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), not stripped

# readelf -h hello.o 
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              REL (Relocatable file)
  Machine:                           Intel 80386
  Version:                           0x1
  Entry point address:               0x0
  Start of program headers:          0 (bytes into file)
  Start of section headers:          288 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           0 (bytes)
  Number of program headers:         0
  Size of section headers:           40 (bytes)
  Number of section headers:         13
  Section header string table index: 10
# gcc hello.o -o hello
生成 hello  /*可执行文件*/
# file hello
hello: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=0x25c438a7052180bb74c1b9d78b498e6777586c92, not stripped

# readelf -h hello
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           Intel 80386
  Version:                           0x1
  Entry point address:               0x8048320
  Start of program headers:          52 (bytes into file)
  Start of section headers:          4412 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         9
  Size of section headers:           40 (bytes)
  Number of section headers:         30
================================================

# arm-linux-gcc -c hello.c  
生成 hello.o  /*二进制目标文件*/
# file hello.o
hello.o: ELF 32-bit LSB relocatable, ARM, version 1 (SYSV), not stripped

# readelf -h hello.o
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              REL (Relocatable file)
  Machine:                           ARM
  Version:                           0x1
  Entry point address:               0x0
  Start of program headers:          0 (bytes into file)
  Start of section headers:          288 (bytes into file)
  Flags:                             0x5000000, Version5 EABI
  Size of this header:               52 (bytes)
  Size of program headers:           0 (bytes)
  Number of program headers:         0
  Size of section headers:           40 (bytes)
  Number of section headers:         12
  Section header string table index: 9
# arm-linux-gcc hello.o -o hello  
生成 hello  /*二进制可执行文件*/
# file hello
hello: ELF 32-bit LSB executable, ARM, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, not stripped
# readelf -h hello
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           ARM
  Version:                           0x1
  Entry point address:               0x8304
  Start of program headers:          52 (bytes into file)
  Start of section headers:          4464 (bytes into file)
  Flags:                             0x5000002, has entry point, Version5 EABI
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         10
  Size of section headers:           40 (bytes)
  Number of section headers:         29
  Section header string table index: 26

readelf -h 选项，读取ELF文件的文件头信息，注意其中的三项值：Type、Machine、Entry point address。

Type  信息就是file中的文件类型
Machine  是在ARM执行还是在inter执行的
Entry point address  表示文件的执行入口点，只有可执行文件该项才有值，而目标文件是可重定向文件，还不可以直接执行，因此该项值为0.



如果在ARM上执行目标文件而不是可执行文件会出现如下错误：
line 1: syntax error: unexpected word (expecting ")")

总之一句话，你要明白你编译出来的是什么



三、文件名后缀


tarena@ubuntu:~/project/c_test$ ls
hello  hello.c  hello.i  hello.o  hello.s
文件名后缀 

文件类型

.c

C源文件

.C .cpp .cc .c++ .cxx               

C++源文件

.h

头文件

.i

预处理后的C源文件                           

.s

汇编程序文件

.o

目标文件

.a

静态链接库

.so

动态链接库


四、gcc 常用命令

参看：15个常用的gcc 命令选项

下载：gcc,g++-GNU工程的C和C++编译器中文手册

GCC编译器非常强大，在各个发行的 linux  系统中都非常流行，本文介绍的是一些常用的 gcc 编译选型。

下面这段代码将回绕整个文章：

编译 hello.c 如下：


#include <stdio.h>

int main (void)
{
	printf ("hello world!\n");
	return 0;
}


GCC 编译选项：
1、指定输出可执行文件的名字

使用最基本的gcc编译格式


gcc hello.c
生成 a.out 
执行完上面这句命令，会在当前目录下输出一个名为 a.out 的可执行文件。
使用 -o 选项可以指定输出的可执行文件名称。


gcc hello.c -o hello
生成 hello
执行完上面这句命令，会在当前目录下输出一个名为 hello 的可执行文件。

2、让所有编译警告都显示出来，选项 -Wall

如下，编辑一段警告的代码


#include <stdio.h>

int main (void)
{
	int i;
	printf ("\n hello world![i]\n", i);
	return 0;
}

root@ubuntu:/home/tarena/project/c_test# gcc -Wall hello.c -o hello
hello.c: 在函数‘main’中:
hello.c:6:2: 警告： 提供给格式字符串的实参太多 [-Wformat-extra-args]
hello.c:6:9: 警告： 此函数中的‘i’在使用前未初始化 [-Wuninitialized]
3、指定 -E 编译选项，使得只输出预编译结果


gcc -E hello.c -o hello.i
生成 helo.i
4、通过编译选项 -S 输出汇编代码

gcc -S hello.c
生成 hello.s
5、指定 -c 输出编译后的代码

gcc -c hello.c
生成 hello.o
6、通过编译选项 -save-temps 输出所有的中间代码

root@ubuntu:/home/tarena/project/c_test# gcc -save-temps hello.c 
root@ubuntu:/home/tarena/project/c_test# ls
a.out  hello.c  hello.i  hello.o  hello.s
7、链接共享库 （动态链接库）指定编译选项 -l

gcc hello.c -o hello -lCPPfile
gcc 命令在执行链接 hello.c 代码时，会链接上 -lCPPfile 动态链接库来生成 hello 可执行文件。
8、指定编译选项 -fPIC 创建独立的（无关联的）地址信息代码

当创建动态链接库时，独立位置信息(position independent)代码也需要生成。这可以帮助动态链接库或者跟多的加载地址信息来替代其他相对的地址信息。所以-fPIC这个选项作用很大，能快速准确定位错误地址。
下面是一个例子，


$ gcc -c -Wall -Werror -fPIC Cfile.c  
$ gcc -shared -o libCfile.so Cfile.o  
9、查看gcc版本信息选项 -v


root@ubuntu:/home/tarena/project/c_test# gcc -v
使用内建 specs。
COLLECT_GCC=gcc.real
COLLECT_LTO_WRAPPER=/usr/lib/gcc/i686-linux-gnu/4.6/lto-wrapper
目标：i686-linux-gnu
配置为：../src/configure -v --with-pkgversion='Ubuntu/Linaro 4.6.3-1ubuntu5' --with-bugurl=file:///usr/share/doc/gcc-4.6/README.Bugs --enable-languages=c,c++,fortran,objc,obj-c++ --prefix=/usr --program-suffix=-4.6 --enable-shared --enable-linker-build-id --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --with-gxx-include-dir=/usr/include/c++/4.6 --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --enable-gnu-unique-object --enable-plugin --enable-objc-gc --enable-targets=all --disable-werror --with-arch-32=i686 --with-tune=generic --enable-checking=release --build=i686-linux-gnu --host=i686-linux-gnu --target=i686-linux-gnu
线程模型：posix
gcc 版本 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) 
10、指定编译选项 -ansi，支持 ISO C89 程序

通过-ansi 选项开启支持 ISO C89 风格，看如下代码：


root@ubuntu:/home/tarena/project/c_test# gcc -ansi hello.c 
hello.c: 在函数‘main’中:
hello.c:5:2: 错误： expected expression before ‘/’ token
11、指定编译选项 -funsigned-char 选项将 char 类型解释为 unsigned char 类型


#include <stdio.h>

int main (void)
{
	char c = -10;
	printf ("c is %d\n", c);
	return 0;
}

root@ubuntu:/home/tarena/project/c_test# gcc hello.c 
root@ubuntu:/home/tarena/project/c_test# ./a.out 
c is -10
root@ubuntu:/home/tarena/project/c_test# gcc -funsigned-char hello.c 
root@ubuntu:/home/tarena/project/c_test# ./a.out 
c is 246
root@ubuntu:/home/tarena/project/c_test# 
12、指定 -D 选型开启编译时的宏

#include <stdio.h>  
int main()  
{  
    int num=0;  
    int arr[SIZE]={};   //使用gcc -D可以宏定义这个数字  
    for(num = 0;num <= SIZE - 1;num++)  
    {  
        arr[num]=num;  
        printf("%d ",arr[num]);  
    }  
    printf("\n");  
    return 0;  
}  
gcc -DSIZE=4 define.c  
输出结果：  
0 1 2 3  
13、将编译警告转换成错误的选项 -Werror

编译警告很多时候会被我们忽视，在特殊场合我们还是需要重视编译警告的，如果能把编译警告变成直接输出错误，那我们的重视程度会提高很多并去解决。

#include <stdio.h>

int main (void)
{
	int i;
	printf ("\n hello world![i]\n", i);
	return 0;
}

root@ubuntu:/home/tarena/project/c_test# gcc -Wall -Werror hello.c
hello.c: 在函数‘main’中:
hello.c:6:2: 错误： 提供给格式字符串的实参太多 [-Werror=format-extra-args]
cc1: all warnings being treated as errors
上述代码未初始化变量 c ，警告变成了错误提示。
14、通过文件制定编译选项，指定@编译选项

比较神奇的功能，可以使用@编译选项然后跟着文件名，例如：

root@ubuntu:/home/tarena/project/c_test# cat opt_file 
-o hello
root@ubuntu:/home/tarena/project/c_test# gcc hello.c @opt_file
生成 hello
15、指定采用什么版本的规范进行编译，选项 -std

加上 -std=c89/-std=c99


root@ubuntu:/home/tarena/project/c_test# gcc -std=c99 hello.c
生成 a.out
16、优化程序选项 -O

优化是编译器的一部分，它可以检查和组合编译器生成的代码，指出未达到最优的部分，并重新生成它们，从而使用户编写的程序更加完美且节省空间。在gcc编译器选项中，使用-O选项对代码进行优化。优化级别分3级，由高到低分别为：-O3、-O2、-O1
优化程序选项说明：
-O1(-O)： 对编译出的代码进行优化
-O2： 进行比-O高一级的优化
-O3： 产生更高级别的优化
说明：
-O1（或-O）、-O2、-O3分别代表优化级别，数字越高，代表gcc的优化级别越高，高的优化级别代表着程序将运行的更快。优化级别越高则程序量越大。直接优化程序本身，性能的提高的变化更加明显。

缺点，编译、链接的速度就相应地要慢一些。

17、连接程序选项

库：是一组预先编译好的函数集合。
说明：
标准库文件一般存储在/lib和/usr/lib目录中。所有的库名都以lib开头。例如：libc.so（标准C语言函数库）、libm.so（数学运算函数库）以.a结尾的是静态库；以.so结尾的库是动态库。使用ar工具将目标文件收集起来，放到一个归档文件中。
连接程序选项说明：
-L dir：将dir所指出的目录加到“函数库搜索列表”中，dir 为库文件所在的路径
-llib： 链接lib库，lib 为库名
-I name： 连接时，加载名字为name的函数库。该库位于系统预设的目录或者由-L选项确定的目录下。实际的库名是libname（后缀为.a或.so）



链接过程通常的形式如下：


gcc file.o -o file -lxxx -L dirname 
-L：指定了链接时用到的库文件所在的目录。
-lxxx：指示链接的库函数名为libxxx.a


例子：编译产生可执行文件hello，搜索数学库以解决问题。

# gcc hello.o -o hello  /usr/lib/libm.a
或者
# gcc -o hello hello.c -lm 
比如，使用pow幂函数，当指数为变量时，编译出现undefined reference to `pow‘的错误


因为math.h不是C运行库函数，就像linux下线程函数库pthread.h也不是，都需要在编译时连接该库。如果你有

IDE（如eclipse）+ GCC 开发C程序，可以在项目属性中编译命令中添加-lm，作用是一样的。


#include <stdio.h>  
#include <math.h>  

int main (void)  
{  
    int n = 2, m = 2;  
    int i = pow (2, m);  
    printf ("i = %d\n", i);  
    return 0;  
}  
编译：gcc test.c -lm  
输出结果：  
i = 4  
18、指定头文件的路径dir，选项 -I dir
先在指定的路径中搜索要包含的头文件，若找不到，则在标准路径（/usr/include，/usr/lib及当前工作目录）上搜索


#include "add.h"
int main (void)
{
	printf ("hello world!\n");
	return 0;
}

root@ubuntu:/home/tarena/project/c_test# gcc hello.c 
hello.c:1:17: 致命错误： add.h：没有那个文件或目录
编译中断。
root@ubuntu:/home/tarena/project/c_test# gcc hello.c -I ../    /*上一个目录查找*/
root@ubuntu:/home/tarena/project/c_test# ./a.out 
hello world!
root@ubuntu:/home/tarena/project/c_test# 
19、调试选型 -g

可产生供gdb调试用的可执行文件，大小明显比只用-o选项编译汇编连接后的文件大。

root@ubuntu:/home/tarena/project/c_test# gcc hello.c 
root@ubuntu:/home/tarena/project/c_test# ls -la a.out 
-rwxr-xr-x 1 root root 7159 Nov 26 23:32 a.out
root@ubuntu:/home/tarena/project/c_test# gcc -g hello.c 
root@ubuntu:/home/tarena/project/c_test# ls -la a.out 
-rwxr-xr-x 1 root root 8051 Nov 26 23:32 a.out

gdb的简单使用：

(gdb)l  列表（list）
(gdb)r  执行（run）
(gdb)n  下一个（next）
(gdb)q  退出（quit）
(gdb)p  输出（print）
(gdb)c  继续（continue）
(gdb)b 4 设置断点（break）
(gdb)d   删除断点（delete）

root@ubuntu:/home/tarena/project/c_test# gdb a.out
GNU gdb (Ubuntu/Linaro 7.4-2012.02-0ubuntu2) 7.4-2012.02
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i686-linux-gnu".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>...
Reading symbols from /home/tarena/project/c_test/a.out...done.
(gdb) l
1	#include <stdio.h>
2	int main (void)
3	{
4		printf ("hello world!\n");
5		return 0;
6	}
(gdb) r
Starting program: /home/tarena/project/c_test/a.out 
hello world!
[Inferior 1 (process 6906) exited normally]
(gdb) q
root@ubuntu:/home/tarena/project/c_test# 

扩展：可使用 man gcc/cc 查询 gcc/cc的更多相关信息和选项

五、后续应用

参看：C语言再学习 -- 关键字volatile

参看：UNIX再学习 -- 静态库与共享库

参看：S5PV210开发 -- 交叉编译器

这里面的问题，line 1: syntax error: unexpected word (expecting ")")   值得看一下。
————————————————
版权声明：本文为CSDN博主「聚优致成」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_29350001/article/details/53339861