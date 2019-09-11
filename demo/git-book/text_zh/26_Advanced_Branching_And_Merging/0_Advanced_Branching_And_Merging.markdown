## 高级分支与合并 ##

### 在合并过程中得到解决冲突的协助 ###

git会把所有可以自动合并的修改加入到索引中去, 所以linkgit:git-diff[1]只会显示有冲突的部分. 它使用了一种不常见的语法:

    $ git diff
    diff --cc file.txt
    index 802992c,2b60207..0000000
    --- a/file.txt
    +++ b/file.txt
    @@@ -1,1 -1,1 +1,5 @@@
    ++<<<<<<< HEAD:file.txt
     +Hello world
    ++=======
    + Goodbye
    ++>>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt

回忆一下, 在我们解决冲突之后, 得到的提交会有两个而不是一个父提交: 一个父提交会成为HEAD, 也就是当前分支的tip; 另外一个父提交会成为另一分支的tip, 被暂时存在MERGE_HEAD.

在合并过程中, 索引中保存着每个文件的三个版本. 三个"文件暂存(file stage)"中的每一个都代表了文件的不同版本:

	$ git show :1:file.txt	# 两个分支共同祖先中的版本.
	$ git show :2:file.txt	# HEAD中的版本.
	$ git show :3:file.txt	# MERGE_HEAD中的版本.

当你使用linkgit:git-diff[1]去显示冲突时, 它在工作树(work tree), 暂存2(stage 2)和暂存3(stage 3)之间执行三路diff操作, 只显示那些两方都有的块(换句话说, 当一个块的合并结果只从暂存2中得到时, 是不会被显示出来的; 对于暂存3来说也是一样).

上面的diff结果显示了file.txt在工作树, 暂存2和暂存3中的差异. git不在每行前面加上单个'+'或者'-', 相反地, 它使用两栏去显示差异: 第一栏用于显示第一个父提交与工作目录文件拷贝的差异, 第二栏用于显示第二个父提交与工作文件拷贝的差异. (参见linkgit:git-diff-files[1]中的"COMBINED DIFF FORMAT"取得此格式详细信息.)

在用直观的方法解决冲突之后(但是在更新索引之前), diff输出会变成下面的样子:

    $ git diff
    diff --cc file.txt
    index 802992c,2b60207..0000000
    --- a/file.txt
    +++ b/file.txt
    @@@ -1,1 -1,1 +1,1 @@@
    - Hello world
    -Goodbye
    ++Goodbye world

上面的输出显示了解决冲突后的版本删除了第一个父版本提供的"Hello world"和第二个父版本提供的"Goodbye", 然后加入了两个父版本中都没有的"Goodbye world".

一些特别diff选项允许你对比工作目录和三个暂存中任何一个的差异:

    $ git diff -1 file.txt		# 与暂存1进行比较
    $ git diff --base file.txt	        # 与上相同
    $ git diff -2 file.txt		# 与暂存2进行比较
    $ git diff --ours file.txt	        # 与上相同
    $ git diff -3 file.txt		# 与暂存3进行比较
    $ git diff --theirs file.txt	# 与上相同.

linkgit:git-log[1]和linkgit:gitk[1]命令也为合并操作提供了特别的协助:

    $ git log --merge
    $ gitk --merge

这会显示所有那些只在HEAD或者只在MERGE_HEAD中存在的提交, 还有那些更新(touch)了未合并文件的提交.

你也可以使用linkgit:git-mergetool[1], 它允许你使用外部工具如emacs或kdiff3去合并文件.

每次你解决冲突之后, 应该更新索引:

    $ git add file.txt

完成索引更新之后, git-diff(缺省地)不再显示那个文件的差异, 所以那个文件的不同暂存版本会被"折叠"起来.
