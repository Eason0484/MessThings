ctags使用详解

楚兴 2018-05-15 21:26:54  39231  收藏 71
分类专栏： Linux 文章标签： ctags
版权

Linux
专栏收录该内容
17 篇文章0 订阅
订阅专栏
1 查看ctags支持的语言
2 查看语言和扩展名的对应关系
3 查看ctags可以识别和记录的语法元素
4 对当前目录下所有ctags支持的语言格式文件生成tags
5 只对特定文件生成tags
6 使用tags
6.1 tag命令
6.2 快捷键Ctrl+]
6.3 tags命令
6.4 快捷键Ctrl+T
6.5 stag命令
6.6 快捷键Ctrl+W+]
6.7 同名tag
7 其他
ctags的功能：扫描指定的源文件，找出其中所包含的语法元素，并将找到的相关内容记录下来。

1 查看ctags支持的语言
```
ctags --list-languages
```
2 查看语言和扩展名的对应关系
```
ctags --list-maps
```
3 查看ctags可以识别和记录的语法元素
```
ctags --list-kinds
```
单独查看可以识别的C++的语法元素：
```
[chuxing@hostname ~]$ ctags --list-kinds=c++
c  classes
d  macro definitions
e  enumerators (values inside an enumeration)
f  function definitions
g  enumeration names
l  local variables [off]
m  class, struct, and union members
n  namespaces
p  function prototypes [off]
s  structure names
t  typedefs
u  union names
v  variable definitions
x  external and forward variable declarations [off]
```
4 对当前目录下所有ctags支持的语言格式文件生成tags
```
ctags -R *
```
缺点很明显，tags会非常大，tags生成会非常慢，而且代码跳转会卡顿。

5 只对特定文件生成tags
```
ctags `find -name "*.h"`
```
6 使用tags
6.1 tag命令
用于跳转到指定的tag。例如：
```
tag tagname
```
使用这个命令可以跳转到tagname的定义处，即使它在另一个文件中。

6.2 快捷键Ctrl+]
取出当前光标下的word作为tag的名字并进行跳转。

6.3 tags命令
列出曾经访问过的tag的列表

6.4 快捷键Ctrl+T
跳转到前一次的tag处。

6.5 stag命令
```
stag tagname
```
分割当前窗口，并且跳转到指定的tag。

6.6 快捷键Ctrl+W+]
分割当前窗口，并且跳转到光标下的tag。

6.7 同名tag
如果存在多个同名的tag，tag命令会给出一个tag的列表，可以通过键入tag的序号来选择tag；也可以通过tselect来过滤tag，如：:tselect tagname

如果要在多个tag间移动，可以使用如下命令：
```
:tfirst             go to first match
:[count]tprevious   go to [count] previous match
:[count]tnext       go to [count] next match
:tlast              go to last match
```
如果没有指定[count]，默认是1。

7 其他
如果是多个tags文件，可以通过设置tags选项来引入更多的tags文件。例如: :set tags=./tags, ./../tags, ./*/tags
使用tag命令时，可以输入部分tag名，然后使用Tab键进行补全。
参考来源：
1. https://blog.csdn.net/u011729865/article/details/75452867
2. https://blog.csdn.net/gangyanliang/article/details/6889860
————————————————
版权声明：本文为CSDN博主「楚兴」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/foreverling/article/details/80329586