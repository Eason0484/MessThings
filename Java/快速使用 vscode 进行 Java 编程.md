# 快速使用 vscode 进行 Java 编程

任何一个程序员都有自己喜爱的编辑器、工具、开发利器，有这样一群人，对于 `vim` 这种上古神器难以驾驭、`IDE` 又太笨重，这时候多了一个选择 vscode！！！

vscode 重新定义了编辑器，它开源、免费、Runs everywhere，是一款介于 IDE 和编辑器之间的产物，我们不能用 IDE 的所有特性都往它身上压，如果都可以的话不就是 IDE 吗？不就是吗？所以用起来的感觉你懂的，美滋滋(๑•̀ㅂ•́) ✧

那么这家伙都有什么牛逼之处呢？

## 特性

- 微软开发，软件质量没的说
- 高颜值，界面非常漂亮，允许自定义更改
- 插件超级多，开发者很愿意接受它
- 对我天朝程序员友好，你懂的
- 启动速度比 atom 快，资源占用少
- 跨平台的特性能没有吗？能吗？
- 对各种编程语言支持良好（当然我只试过 java/node/go/python）
- 自动补全、代码高亮、代码跳转...
- 集成终端好用，可以用 `code` 命令打开文件/文件夹
- `debug` 功能好用(简直是 mini 的 IDE)
- ( ⊙ o ⊙ )啊！特性太多了我实在写不完

说了这么多你一定迫不及待想尝试吧~ （也许并不是）那现在

## 安装 vscode

我知道在座的各位其实根本不用我教你怎么安装，因为它是傻瓜式安装啊！它家的官网是 [https://code.visualstudio.com/](https://link.zhihu.com/?target=https%3A//code.visualstudio.com/)，你只需要在首页下载符合你操作系统的软件即可。

支持 `Windows`、`Linux`、`Mac`。

## 了解 vsccde

为什么要了解它呢？你不了解它的组成就不知道怎么把它用好（高能型大佬除外）。

## 布局

![](https://pic3.zhimg.com/v2-5a495945b24ec0eaa44e46bdef5589aa_r.jpg)

上面是 vscode 的布局，和大多数编辑器一样，分为

- **Editor** 用来编辑文件的主体区域。可以并排打开三个编辑器。
- **Side Bar** 包含不同的像浏览器一样的视图来协助来完成工程。
- **Status Bar** 展示当前打开的工程和正在编辑的文件的信息。
- **View Bar** 在最左手边，帮助切换视图以及提供额外的上下文相关的提示，比如激活了 Git 的情况下，需要提交的变化的数目。

在我看来学习一款编辑器并不用像学习编程语言那样，按照某个教程把所有的功能都学会，我更喜欢探索性的尝试自己需要的那些东西，比如在 **View Bar** 中如何的 5 个功能，其实点一点就大概明白什么意思了，查阅文字资料只是让自己更精确的掌握使用姿势。

## 配置

vscode 的用户配置分 3 个级别，分别是默认配置、全局配置和工作区配置，优先级也依次递增。对于团队项目，一些规范可以通过项目目录下建一个 `.vscode/setting.json` 文件进行配置,比如：

```
// tab长度
"editor.tabSize": 2,
// 启用后，将在保存文件时剪裁尾随空格。
"files.trimTrailingWhitespace": true,
// 配置 glob 模式以排除文件和文件夹。
"files.exclude": {
  "**/.git": true,
  "**/.svn": true,
  "**/.DS_Store": true,
  "**/.idea": true
},
```

这个配置我一般是不用的，只用用户配置，反正电脑就一个用户。配置一下字体大小、自动保存等。

## 必装插件

1.  [Beautify](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3DHookyQR.beautify)：代码高亮
2.  [Terminal](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dformulahendry.terminal)：直接唤起终端
3.  [Project Manager](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dalefragnani.project-manager)：多个项目切换
4.  [Auto Close Tag](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dformulahendry.auto-close-tag)：标签自动闭合（其实我觉得可以内置的）

怎么安装呢？

![](https://pic3.zhimg.com/v2-6e964e31dc14be6e6d5bd797491faff2_r.jpg)

在扩展输入框里输入你想用的插件就可以了，当然它还会经常推荐给我们排行比较高的插件，可以尝试安装，安装完成后重新加载编辑器就可以使用了。

## 常用快捷键

下面这些快捷键是我常用的，如果你想看更全的可以看看 [VS Code 有哪些常用的快捷键](https://www.zhihu.com/question/37623310)

- 向上向下复制一行： Shift+Alt+Up 或 Shift+Alt+Down
- 注释代码: `cmd + /`
- 切换侧边栏: `cmd + b`
- 文件夹中查找: `cmd + shift + f`
- 查找替换: `cmd + shift + h`
- 重构代码: `fn + F2`
- 代码格式化: `Shift+Alt+F`，或 `Ctrl+Shift+P` 后输入 `format code`

**Ctrl+P 模式: (Mac 是 CMD+P)**

- 直接输入文件名，快速打开文件
- `>` 显示并运行命令
- `:` 跳转到行数，也可以 Ctrl+G 直接进入(Mac 是 CMD+G)
- `@` 跳转到 symbol（搜索变量或者函数），也可以 Ctrl+Shift+O 直接进入
- `@:` 根据分类跳转 symbol，查找属性或函数，也可以 Ctrl+Shift+O 后输入:进入
- `#` 根据名字查找 symbol，也可以 Ctrl+T

## 配置 Java 环境

先安装 Java 语言相关的插件 4 枚

1.  [Language Support for Java(TM) by Red Hat](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dredhat.java)
2.  [Debugger for Java](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dvscjava.vscode-java-debug)
3.  [Java Test Runner](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dvscjava.vscode-java-test)
4.  [Maven for Java](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dvscjava.vscode-maven)

有人想问了，妈耶还要 4 个插件，这么麻烦的吗？

第一个插件干嘛的？运行 Java 代码的，第二个呢？调试的，不调试可以不装，第三个运行单元测试，不测试可以不装，第四个建议装上，一个标准化的 Java 工程一定不是几个文件组成，maven 是在 Java 环境下构建应用程序的软件（本地要先安装哦）。

这时候还需要配置一下 `java.home`，我的是

```
"java.home": "/Library/Java/JavaVirtualMachines/jdk1.8.0_101.jdk/Contents/Home",
```

大功告成，现在你可以在 vs code 下创建一个 `Mmp.java` 开始写 `Hello vscode!` 了。

```
public class Mmp {

  public static void main(){
    System.out.println("Hello vscode!");
  }

}
```

点击 **调试** 或者按下 `F5` 运行这久经码场的输出语句。具体操作见文章底部视频。

**代码定位**

![](https://pic4.zhimg.com/v2-7a349375abbdb569dd259b7b912fd9cb_r.jpg)

按住 **ctrl** 键鼠标悬停在类上面会有类描述，点击即可进入类定义处，方法也是同样。

**代码重构**

![](https://pic3.zhimg.com/v2-5669b12e0e07878b7b64195910954ee2_r.jpg)

代码重构

很强大的一个地方就是我们有时候会修改字段、方法的名称。

1.  找到所有的引用： `Shift + F12`
2.  同时修改本文件中所有匹配的： `Ctrl+F12`
3.  重命名：比如要修改一个方法名，可以选中后按 `F2`，输入新的名字，回车，会发现所有的文件都修改了
4.  跳转到下一个 `Error` 或 `Warning`：当有多个错误时可以按 `F8` 逐个跳转
5.  查看 `diff`： 在 `explorer` 里选择文件右键 `Set file to compare`，然后需要对比的文件上右键选择 `Compare with file_name_you_chose`

## 运行 SpringBoot 项目

下载一个 `SpringBoot` 的示例工程

```
git clone https://github.com/JavaExamples/spring-boot-helloworld.git
code spring-boot-helloworld
```

> 什么？`git` 还不会

![](https://pic1.zhimg.com/v2-ffecf58f1a664a9e9bc3e119e5b67ad0_r.jpg)

![](https://pic1.zhimg.com/v2-7ec18936dcbc7a546f73efc1d63226ec_r.jpg)

启动调试，选择 `Java` 语言，会提示我们 `launch.json` 文件是下面这样的

```
{
    // 使用 IntelliSense 了解相关属性。
    // 悬停以查看现有属性的描述。
    // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "type": "java",
            "name": "Debug (Launch)-Application<spring-boot-helloworld>",
            "request": "launch",
            "cwd": "${workspaceFolder}",
            "console": "internalConsole",
            "stopOnEntry": false,
            "mainClass": "hello.Application",
            "projectName": "spring-boot-helloworld",
            "args": ""
        },
        {
            "type": "java",
            "name": "Debug (Attach)",
            "request": "attach",
            "hostName": "localhost",
            "port": 0
        }
    ]
}
```

主要看 `mainClass`，只有第一次生成这个文件，确认后点击 **调试** 即可看到控制台日志

![](https://pic4.zhimg.com/v2-0a736a5baec8a4482578239b97d736bf_r.jpg)

## 尝试 Lombok

这个家伙你用不用都无妨，反正我是挺喜欢的。这里就不啰嗦到底干嘛的，简单来说就是我可以用一个 `@Data` 注解帮我自动生成（编译后生成）`getter`、`setter`、`toString`、`equals`、`hashCode` 这些方法，反正多花时间写这些代码也不会提高你的能力，修改的时候还要多花时间，完全没！必！要！好吗？

按照[官方的文档](https://link.zhihu.com/?target=https%3A//github.com/redhat-developer/vscode-java/wiki/Lombok-support)我尝试了不在 `maven` 环境下是行不通的！行不通的。如果你可以的话在文章评论下告诉我哈~

所以我们安装一个 [Lombok Annotations Support for VS Code](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3DGabrielBB.vscode-lombok) 就可以了。

在 maven 工程中添加 `lombok` 依赖

```
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.16.20</version>
    <scope>provided</scope>
</dependency>
```

试一下吧

![](https://pic4.zhimg.com/v2-ba08cf239441498f001ea89bddd005af_r.jpg)

---

大兄弟如果你能看到这里可以跟我领取真经了，下方是本篇文章的视频操作指南，敬请食用：

[](https://link.zhihu.com/?target=https%3A//www.bilibili.com/video/av21516450/)[](https://link.zhihu.com/?target=https%3A//youtu.be/E-kKggVbiig)

**想看更多 vscode 技巧？点 下面的开发技巧**集锦

[](https://zhuanlan.zhihu.com/p/34989844)

我还有一个 QQ 群聊 Java8、聊代码、聊编程最前言，过于水群直接踢，车牌号：`NjYzODg3NzI5`

本文转自 [https://zhuanlan.zhihu.com/p/35176928](https://zhuanlan.zhihu.com/p/35176928)，如有侵权，请联系删除。
