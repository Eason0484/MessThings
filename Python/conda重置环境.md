# conda重置环境

一般情况下，个人在conda root环境下进行编码，有时新装的包乱了、或者错误的更新，欲重置回滚。

[](https://blog.csdn.net/nima1994/article/details/103064351)解决方案
----------------------------------------------------------------

1.  `conda list --revisions`  
    查看历史，按需选择 `REV_NUM` 数值。一般情况下，0表示是第一次安装，包括root环境和conda命令，所以**一般为1或之后**。
    
2.  `conda install --revision REV_NUM`  
    稍等片刻，即可重置。
    

 

  

本文转自 [https://blog.csdn.net/nima1994/article/details/103064351](https://blog.csdn.net/nima1994/article/details/103064351)，如有侵权，请联系删除。