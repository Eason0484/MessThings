*   本文基于Windows系统
*   [超详细VSCode安装教程（Windows）](https://blog.csdn.net/Zhangguohao666/article/details/105665412)
*   **博主的VSCode专栏：**[分享使用VS Code的基本操作与各种技巧  
    ](https://blog.csdn.net/zhangguohao666/category_9819648.html)

* * *

刚刚开始学习Python时，按照老师提供的傻瓜式操作配好Python后，发现它自带了一个ide：IDLE，  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200324235613149.png)

*   IDLE足够轻量级，打开速度很快，没有太多杂乱的东西（即使它们对于老手非常好用，但会对新手产生各种各样的干扰）
*   IDLE自带的Python Shell是可以交互式的，那时候对于初学Python的我来说，可以快速编辑的学习Python知识点
*   但是，IDLE终归在送我入门后被我抛弃了，因为界面不美观、操作不智能、功能不强大…

我知道有一个很强大的ide：PyCharm，不过，嗯~~~，我没使用过，就直接转入Anaconda的怀抱了  
不过，有的时候，过于专业、强大的功能也意味这软件的“沉重性”（打开它是真滴慢）

VSCode官网中有这么一句话，很有意思

> If your primary purpose for using Python is Data Science, then you might consider a download from Anaconda. Anaconda provides not just a Python interpreter, but many useful libraries and tools for data science

即：如果你主要使用Python进行数据科学，推荐下载使用Anaconda

不过，我日常有时候只想写一些简单的Python代码而已，于是，VSCode进入了我的视线；  
遂打算使用VSCode配置Python环境，满足我偶尔的Python语言编程需要，同时也将这个过程记录下来，希望能帮助大家

[](https://blog.csdn.net/Zhangguohao666/article/details/105040139)目录一：Python extension
======================================================================================

![](https://img-blog.csdnimg.cn/20200323165029974.png)

1.  打开VSCode
2.  点击侧边栏的**Manage extensions**图标  
    ![在这里插入图片描述](https://img-blog.csdnimg.cn/20200319144754811.png)
3.  搜索**Python**，点击**install**即可  
    ![](https://img-blog.csdnimg.cn/20200323165047726.png)

在VSCode中编写Python代码，除了安装上述插件，还需要自行安装Python编译器

[](https://blog.csdn.net/Zhangguohao666/article/details/105040139)目录二：Python
============================================================================

[](https://blog.csdn.net/Zhangguohao666/article/details/105040139)第一步：下载Python解释器
---------------------------------------------------------------------------------

（如果你懒得去官网下载Python，可以直接使用我提供的Python3.8.2的下载链接 [蓝奏云链接：python-3.8.2-amd64.exe](https://www.lanzous.com/iakeaze)）

[Python官方下载网站 - Download the latest version for Windows](https://www.python.org/downloads/)

1.  选择自己需要的Python版本进行download，跳转到另一个页面
    
2.  然后下拉到页面底部，可以看到多个系统供你选择  
    macOS、  
    Windows x86-64（64位）  
    Windows x86（32位）
    
3.  Windows系统有三种文件供你下载  
    embeddable zip file，压缩包文件  
    web-based installer，网络安装，即下载之后，运行这玩意时它联网下载Python  
    executable installer，是exe文件，提供界面化安装指导
    

我使用的是executable installer，因为我不仅仅只是需要Python编译器，我喜欢用IDLE写一些简单的Python代码，因为它足够轻量级  
![](https://img-blog.csdnimg.cn/20200323160216557.png) ![](https://img-blog.csdnimg.cn/20200323161139684.png)  
![](https://img-blog.csdnimg.cn/20200323162039523.png)

**补充：如果你需要使用多个版本的Python，请勾选第二个界面中py launcher，它会帮助你查找和执行不同的Python版本**

[](https://blog.csdn.net/Zhangguohao666/article/details/105040139)第二步：配置环境变量
----------------------------------------------------------------------------

如果你在使用安装程序安装Python的时候没有勾选 **Add Python x.x to PATH** ，请参考此内容

右键此电脑 > 属性 > 高级系统设置 > 高级 > 环境变量

![](https://img-blog.csdnimg.cn/20200320004454258.png)

选中Path，点击编辑

![](https://img-blog.csdnimg.cn/20200323190406725.png)

还要点击多次确定哦，将刚刚打开的页面全部通过确定关掉

假设我的安装路径为：`D:\Python`，则配置的环境变量为：

*   `D:\Python` 配置Python编译器的环境变量
*   `D:\Python\Scripts` 配置pip的环境变量，我们通过pip安装、管理包时，需要用到这个环境变量
*   如果你在使用安装程序安装Python的时候勾选了 **py launcher** ，请检查环境变量PATH中是否配置以下路径，若无则加上
    *   `C:\Users\用户名\AppData\Local\Programs\Python\Launcher\`
    *   路径中的用户名，你应该知道该怎么填吧~

[](https://blog.csdn.net/Zhangguohao666/article/details/105040139)第三步：检查并更新pip
------------------------------------------------------------------------------

win + r，输入cmd，

*   在控制台中输入以下命令

```
py -3 --version

```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200325111729887.png)  
如此即可说明，下载成功了

*   将pip更新到最新版本（pip的典型应用是从PYPI（Python Package Index）上安装Python第三方包）  
    在控制台中输入以下命令

```
python -m pip install --upgrade pip

```

如果没有反应，输入以下命令：

```
py -m pip install --upgrade pip

```

请等待它下载完

[](https://blog.csdn.net/Zhangguohao666/article/details/105040139)目录三：建立Python工作区
=================================================================================

**在下面的操作中，经过一些设置后，会在工作区下生成一些配置文件，而它们只在当前工作区中生效，不是全局的（全局设置本文不讲，因为看完工作区的设置并对配置文件有了一点概念之后，全局设置你会得心应手的）**

**一：**新建一个文件夹用于存放你编写的Python代码，位置自己决定，不建议放到桌面

我直接将文件夹取名为 **Python**

**二：**用VSCode打开Python文件夹

1.  最干脆的办法：选中文件夹 > 鼠标右键 > 通过Code打开
    
2.  如果VSCode没有注册到你的右键菜单中，你就老老实实的打开VSCode > file > open folder
    

![](https://img-blog.csdnimg.cn/20200323184106880.png)

**三：**选择解释器

**Python是一个解释性语言，现在你需要告知VSCode使用哪个解释器**

> opening the Command Palette (Ctrl+Shift+P), start typing the Python: Select Interpreter command to search

简单来说就是，在VSCode中，Ctrl+Shift+P 或者 View > Command Palette，打开命令面板  
输入`Python: Select Interpreter`  
![](https://img-blog.csdnimg.cn/20200325114217582.png)  
选择Python的安装路径（由于我还安装过Anaconda，所以有两个Python解释器）  
![](https://img-blog.csdnimg.cn/2020032511434041.png)  
此时，VSCode自动为你生成**settings.json**文件在.vscode文件夹中  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200325114532114.png)  
**四：**Linter pylint

先新建一个Python文件  
![](https://img-blog.csdnimg.cn/20200323184302306.png)  
VSCode右下角会出现下面的提示，install即可  
![](https://img-blog.csdnimg.cn/20200323184435313.png)  
**Linter pylint**告诉VS Code将此文件`.py`解释为Python程序，以便VSCode使用Python扩展名和选定的解释器

下载完此插件后，它给出了一个提示  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200325121655553.png)  
按照它的要求进行环境变量配置，将它给的路径添加到环境变量中即可

[](https://blog.csdn.net/Zhangguohao666/article/details/105040139)目录四：运行Python代码的三种方法
=====================================================================================

运行代码前请 ctrl + s，保存代码哦

[](https://blog.csdn.net/Zhangguohao666/article/details/105040139)方法一：点击按钮
--------------------------------------------------------------------------

**这个方法最简单**  
只需单击编辑器右上角的 “Run Python File in Terminal” 按钮即可  
![](https://img-blog.csdnimg.cn/20200325171307675.png)

该按钮将打开一个终端面板，在其中自动激活您的Python解释器，然后运行`python test.py`  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200325171459400.png)

[](https://blog.csdn.net/Zhangguohao666/article/details/105040139)方法二：右键菜单
--------------------------------------------------------------------------

右键单击编辑器窗口中的任何位置

右键菜单中有这么两个选项  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200325172124560.png)

*   **Run Python File in Terminal**（它会运行完整代码，并在运行之前为你保存代码）
*   **Run Selection/Line in Python Terminal**（它是用来运行部分代码的，有的时候非常好用）  
    请选中部分代码，然后右键 > Run Selection/Line in Python Terminal，或者Shift + Enter

[](https://blog.csdn.net/Zhangguohao666/article/details/105040139)方法三：交互式解释器
----------------------------------------------------------------------------

Ctrl + Shift + P 或者 View > Command Palette，打开命令面板  
输入`Python: Start REPL`

打开交互式解释器，与IDLE的Python Shell功能一样  
![](https://img-blog.csdnimg.cn/20200325173020776.png)  
交互式解释器可以很方便的用来测试一些Python语法

[](https://blog.csdn.net/Zhangguohao666/article/details/105040139)目录五：Debug
===========================================================================

**一：**设置断点

在某一行代码的行号左边，单击以下，出现红色的圆点  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200325173446924.png)  
**二：**初始化调试器

F5 或者 Run > Start Debugging

由于这是第一次调试此文件，因此将从“命令面板”中打开一个配置菜单，有许多调试配置类型可供我们选择  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200325173942155.png)  
选择 **Python File** （**使用当前选择的Python解释器运行编辑器中显示的当前文件的配置**）

调试也是一种特殊的运行，调试器会在断点处的第一行停止  
![](https://img-blog.csdnimg.cn/20200325174541303.png)  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200325175341792.png)  
补充一点：  
在VSCode中，进行调试工作时，可以改用Logpoints代替常用的print快速检查变量。Logpoints类似于断点，不同之处在于它将消息记录到控制台并且不会停止程序。  
![](https://img-blog.csdnimg.cn/20200325180737171.png)  
有兴趣的，可以[官网：Logpoints](https://code.visualstudio.com/docs/editor/debugging#_logpoints)

[](https://blog.csdn.net/Zhangguohao666/article/details/105040139)目录六：虚拟环境中安装、使用软件包
===================================================================================

Python发展至今，有大量优秀的代码包供我们调用

最常用的就是在PYPI（Python Package Index）上安装Python第三方包

**一：**

*   当你的Python代码中调用了第三方包
*   除非你使用的是Anaconda或以前已经安装过matplotlib包，你应该看到消息**"ModuleNotFoundError：No module named ‘XXX’"**
*   这样的消息表明所需的软件包在您的系统中不可用

**二：**

*   我们最好避免将软件包安装到全局解释器环境中，**最好使用的是特定于项目的虚拟环境，其中包含全局解释器的副本**
*   激活该环境后，随后安装的所有软件包都将与其他环境隔离。这种隔离减少了因版本冲突而引起的许多复杂情况。

**三：**创建、激活虚拟环境

*   创建新的虚拟环境时，VS Code会提示您将其设置为工作区文件夹的默认环境。如果选择此选项，则在打开新终端时将自动激活环境
*   Ctrl + Shift + \` 或者 Terminal > New Terminal，打开集成终端
*   输入以下命令

```
py -3 -m venv .venv

```

若你在终端中输入以上命令时出现**Activate.ps1 is not digitally signed. You cannot run this script on the current system**，直接在终端中输入`Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process`命令来允许PowerShell执行脚本

命令输入后，出现以下提示消息  
![](https://img-blog.csdnimg.cn/20200325200446985.png)  
点击 **Yes**，等价于以下命令（激活虚拟环境）

```
.venv\scripts\activate

```
![](https://img-blog.csdnimg.cn/20200325201136861.png)

此时，在工作区下，VSCode会生成.venv文件夹，其子文件夹Scripts、Lib\\site-packages存放我们在此工作区中安装的packages

在VSCode中，Ctrl+Shift+P 或者 View > Command Palette，打开命令面板  
输入`Python: Select Interpreter`，选择你所需的Python版本调试器

**若需要安装xxx包，只需要打开集成终端，输入以下命令即可**

```
python -m pip install xxx

```

**三：**关闭、开启虚拟环境

关闭

```
deactivate

```

开启

```
.venv\scripts\activate

```

* * *

参考资料：

*   [Python - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
*   [Python in Visual Studio Code](https://code.visualstudio.com/docs/languages/python)

 

  

本文转自 [https://blog.csdn.net/Zhangguohao666/article/details/105040139](https://blog.csdn.net/Zhangguohao666/article/details/105040139)，如有侵权，请联系删除。