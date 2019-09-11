## 创建新的空分支 ##

在偶尔的情况下，你可能会想要保留那些与你的代码没有共同祖先的分支。例如在这些分支上保留生成的文档或者其他一些东西。如果你需要创建一个不使用当前代码库作为父提交的分支，你可以用如下的方法创建一个空分支：

    git symbolic-ref HEAD refs/heads/newbranch 
    rm .git/index 
    git clean -fdx 
    <do work> 
    git add your files 
    git commit -m 'Initial commit'
    
[gitcast:c9-empty-branch]("GitCast #7: Creating Empty Branches")
