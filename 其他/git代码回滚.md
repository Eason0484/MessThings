## [代码回滚](https://zhuanlan.zhihu.com/p/137856034)

不知道大家在平常开发时中没有犯过这样一个错误，就是把IDE的配置或者项目运行的本地配置文件上传到服务器，导致别人更新代码之后，出现本地项目无法运行情况。

这是常见需要做代码回滚的一个场景，提交了一些我们不希望的文件。

我们也可能会碰到，在一次产品上线之后，出现了紧急Bug，一时半会无法修复，为了保证线上稳定，需要做代码回滚。

时光不能回退，Git却允许我们改变历史。

想要让Git回退历史，有以下步骤：

```text
使用git log命令，查看分支提交历史，确认需要回退的版本
使用git reset --hard commit_id命令，进行版本回退
使用git push origin命令，推送至远程分支
```

快捷命令：

```text
回退上个版本：git reset --hard HEAD^ 
```

【注：HEAD是指向当前版本的指针，HEAD^表示上个版本,HEAD^^表示上上个版本】

如果修改到的文件比较少，我们可以不通过命令回滚的方式，手动删除之前的修改，再进行提交。

## 撤销修改

一些时候，为了验证Bug，我们可能会直接在测试服务器上打断点调试。如果忘记去掉调试内容，在执行git pull更新时，Git会提示你提交修改。

此时，你可能已经不记得修改什么了，这个时候，我们可以用git checkout -- file命令，来清空工作区的修改。是的，[git checkout命令](https://www.zhihu.com/search?q=git+checkout命令&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A137856034})不仅可以用来切换分支，还能撤销文件修改。

如果想要撤销提交到暂存区后的文件内容怎么办呢(即执行git add之后)，我们可以使用git reset HEAD file命令撤销提交到暂存区的内容,再使用git checkout -- file命令来撤销工作区的修改，需要分两步进行操作。

## reset还是revert?

针对评论区提出的，回滚是使用reset还是revert的疑问，这边做下补充说明。

reset和revert都可以用来回滚代码。但他们是有区别的，准确来说，reset是用来"回退"版本，而revert是用来"还原"某次或者某几次提交。

听起来有点绕，怎么去理解他们呢？

举个例子，比如在master分支，有以下提交历史:

```text
42eae13 (HEAD -> master) 第四次修改
97ea0f9 第三次修改
e50b7c2 第二次修改
3a52650 第一次修改
```

可以看到，master最新版本为第四次修改。

如果发现，在第四次修改有错误，需要回滚到第三次修改，就可以用[reset命令](https://www.zhihu.com/search?q=reset命令&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A137856034})来回退。

执行 git reset --hard 97ea0f9,这个时候，git的提交历史变为:

```text
97ea0f9 (HEAD -> master) 第三次修改
e50b7c2 第二次修改
3a52650 第一次修改
```

可以看到master当前指向97ea0f9这个版本，我们回到了第三次修改。

使用reset命令，Git会把要回退版本之后提交的修改都删除掉。要从第四次修改回退到第一次修改，那么会删除第二、三、四次的修改。【注：这里并不是真正的[物理删除](https://www.zhihu.com/search?q=物理删除&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A137856034})】

那如果发现第三次修改有错误，想要恢复第三次修改，却要保留第四次修改呢？

这个时候就可以用revert命令：

```text
git revert -n 97ea0f9
git commit -m "恢复第三次修改"
```

Git提交历史会变成：

```text
33b8b30 (HEAD -> master) Revert "恢复第三次修改"
42eae13 第四次修改
97ea0f9 第三次修改
e50b7c2 第二次修改
3a52650 第一次修改
```

实际上，Git把第三次修改从提交中剔除(还原)了，还保留了第四次修改，并且产生了新的[commit_id](https://www.zhihu.com/search?q=commit_id&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A137856034})。

在实际生产环境中，代码是基于master分支发布到线上的，会有多人进行提交。可能会碰到自己或团队其他成员开发的某个功能在上线之后有Bug,需要及时做代码回滚的操作。

在确认要回滚的版本之后，如果别人没有最新提交，那么就可以直接用reset命令进行版本回退，否则，就可以考虑使用revert命令进行还原修改，不能影响到别人的提交。

使用reset还是revert，需要考虑实际的适用场景，没有绝对化。

上面提的*并不是真正的物理删除*，是因为Git会把分支的每次修改记录都会保留下来，比如有某次的commit,某次的reset等。而使用git reflog show命令,可以查看完整的提交历史，

只要有commit_id，我们就能恢复任意版本的代码，在各版本之间来回穿梭。

以上，就是我对Git回滚代码的一些使用心得，个人观点,仅供参考。