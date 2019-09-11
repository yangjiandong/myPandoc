## 子模块 ##

一个大项目通常由很多较小的, 自完备的模块组成. 例如, 一个嵌入式Linux发行版的代码树会包含每个进行过本地修改的软件的代码; 一个电影播放器可能需要基于一个知名解码库的特定版本完成编译; 数个独立的程序可能会共用同一个创建脚本.

在集中式版本管理系统中, 可以通过把每个模块放在一个单独的仓库中来完成上述的任务. 开发者可以把所有模块都签出(checkout), 也可以选择只签出他需要的模块. 在移动文件, 修改API和翻译时, 他们甚至可以在一个提交中跨多个模块修改文件.

Git不允许部分签出(partial checkout), 所以采用上面(集中式版本管理)的方法会强迫开发者们保留一份他们不感兴趣的模块的本地拷贝. 在签出量巨大时, 提交会慢得超过你的预期, 因为git不得不扫描每一个目录去寻找修改. 如果模块有很多本地历史, 克隆可能永远不能完成.

从好的方面看来, 分布式版本管理系统可以更好地与外部资源进行整合. 在集中化的模式中, 外部项目的一个快照从它本身的版本控制系统中被分离出来, 然后此快照作为一个提供商分支(vendor branch)导入到本地的版本控制系统中去. 快照的历史不再可见. 而分布式管理系统中, 你可以把外部项目的历史一同克隆过来, 从而更好地跟踪外部项目的开发, 便于合并本地修改.

Git的子模块(submodule)功能使得一个仓库可以用子目录的形式去包含一个外部项目的签出版本. 子模块维护它们自己的身份标记(identity); 子模块功能仅仅储存子模块仓库的位置和提交ID, 因此其他克隆父项目("superproject")的开发者可以轻松克隆所有子模块的同一版本. 对父项目的部分签出成为可能: 你可以告诉git去克隆一部分或者所有的子模块, 也可以一个都不克隆.

Git 1.5.3中加入了linkgit:git-submodule[1]这个命令. Git 1.5.2版本的用户可以查找仓库的子模块并且手工签出; 更早的版本不支持子模块功能.

为说明子模块的使用方法, 创建4个用作子模块的示例仓库:

    $ mkdir ~/git
    $ cd ~/git
    $ for i in a b c d
    do
        mkdir $i
	    cd $i
	    git init
	    echo "module $i" > $i.txt
	    git add $i.txt
	    git commit -m "Initial commit, submodule $i"
	    cd ..
    done

现在创建父项目, 加入所有的子模块:

    $ mkdir super
    $ cd super
    $ git init
    $ for i in a b c d
    do
        git submodule add ~/git/$i $i
    done

注意: 如果你想对外发布你的父项目, 请不要使用本地的地址!

列出`git-submodule`创建文件:

    $ ls -a
    .  ..  .git  .gitmodules  a  b  c  d

`git-submodule add`命令进行了如下的操作:

- 它在当前目录下克隆各个子模块, 默认签出master分支.
- 它把子模块的克隆路径加入到linkgit:gitmodules[5]文件中, 然后把这个文件加入到索引, 准备进行提交.
- 它把子模块的当前提交ID加入到索引中, 准备进行提交.

提交父项目:


    $ git commit -m "Add submodules a, b, c and d."

现在克隆父项目:

    $ cd ..
    $ git clone super cloned
    $ cd cloned

子模块的目录创建好了, 但是它们是空的:

    $ ls -a a
    .  ..
    $ git submodule status
    -d266b9873ad50488163457f025db7cdd9683d88b a
    -e81d457da15309b4fef4249aba9b50187999670d b
    -c1536a972b9affea0f16e0680ba87332dc059146 c
    -d96249ff5d57de5de093e6baff9e0aafa5276a74 d

注意: 上面列出的提交对象的名字会和你的项目中看到的有所不同, 但是它们应该和HEAD的提交对象名字一致. 你可以运行`git ls-remote ../git/a`进行检验.

拉取子模块需要进行两步操作. 首先运行`git submodule init`, 把子模块的URL加入到`.git/config`:

    $ git submodule init

现在使用`git-submodule update`去克隆子模块的仓库和签出父项目中指定的那个版本:

    $ git submodule update
    $ cd a
    $ ls -a
    .  ..  .git  a.txt

`git-submodule update`和`git-submodule add`的一个主要区别就是`git-submodule update`签出一个指定的提交, 而不是该分支的tip. 它就像签出一个标签(tag): 头指针脱离, 你不在任何一个分支上工作.

    $ git branch
    * (no branch)
    master

如何你需要对子模块进行修改, 同时头指针又是脱离的状态, 那么你应该创建或者签出一个分支, 进行修改, 发布子模块的修改, 然后更新父项目让其引用新的提交:

    $ git checkout master

或者

    $ git checkout -b fix-up

然后

    $ echo "adding a line again" >> a.txt
    $ git commit -a -m "Updated the submodule from within the superproject."
    $ git push
    $ cd ..
    $ git diff
    diff --git a/a b/a
    index d266b98..261dfac 160000
    --- a/a
    +++ b/a
    @@ -1 +1 @@
    -Subproject commit d266b9873ad50488163457f025db7cdd9683d88b
    +Subproject commit 261dfac35cb99d380eb966e102c1197139f7fa24
    $ git add a
    $ git commit -m "Updated submodule a."
    $ git push

如果你想要更新子模块, 你应该在`git pull`之后运行`git submodule update`.

### 子模块方式的陷阱 ###

你应该总是在发布父项目的修改之前发布子模块修改. 如果你忘记发布子模块的修改, 其他人就无法克隆你的仓库了:

    $ cd ~/git/super/a
    $ echo i added another line to this file >> a.txt
    $ git commit -a -m "doing it wrong this time"
    $ cd ..
    $ git add a
    $ git commit -m "Updated submodule a again."
    $ git push
    $ cd ~/git/cloned
    $ git pull
    $ git submodule update
    error: pathspec '261dfac35cb99d380eb966e102c1197139f7fa24' did not match any file(s) known to git.
    Did you forget to 'git add'?
    Unable to checkout '261dfac35cb99d380eb966e102c1197139f7fa24' in submodule path 'a'

如果你暂存了一个更新过的子模块, 准备进行手工提交, 注意不要在路径后面加上斜杠. 如果加上了斜杠, git会认为你想要移除那个子模块然后签出那个目录内容到父仓库.

    $ cd ~/git/super/a
    $ echo i added another line to this file >> a.txt
    $ git commit -a -m "doing it wrong this time"
    $ cd ..
    $ git add a/
    $ git status
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       deleted:    a
    #       new file:   a/a.txt
    #
    # Modified submodules:
    #
    # * a aa5c351...0000000 (1):
    #   < Initial commit, submodule a
    #

为了修正这个错误的操作, 我们应该重置(reset)这个修改, 然后在add的时候不要加上末尾斜杠.

    $ git reset HEAD A
    $ git add a
    $ git status
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       modified:   a
    #
    # Modified submodules:
    #
    # * a aa5c351...8d3ba36 (1):
    #   > doing it wrong this time
    #

你也不应该把子模块的分支回退到超出任何父项目中记录的提交的范围.

如果你在没有签出分支的情况下对子模块进行了修改并且提交, 运行`git submodule update`将会不安全. 你所进行的修改会在无任何提示的情况下被覆盖.

    $ cat a.txt
    module a
    $ echo line added from private2 >> a.txt
    $ git commit -a -m "line added inside private2"
    $ cd ..
    $ git submodule update
    Submodule path 'a': checked out 'd266b9873ad50488163457f025db7cdd9683d88b'
    $ cd a
    $ cat a.txt
    module a

注意: 这些修改在子模块的reflog中仍然可见.

如果你不想提交你的修改, 那又是另外一种情况了.

[gitcast:c11-git-submodules]("GitCast #11: Git Submodules")
