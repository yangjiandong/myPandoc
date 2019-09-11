## Git引用 ##

分支(branch), 远程跟踪分支(remote-tracking branch)以及标签(tag)都是对提交的引用. 所有的引用是用"refs"开头, 以斜杠分割的路径. 到目前为此, 我们用到的引用名称其实是它们的简写版本:

	- 分支"test"是"refs/heads/test"的简写.
	- 标签"v2.6.18"是"refs/tags/v2.6.18"的简写.
	- "origin/master"是"refs/remotes/origin/master"的简写.

偶尔的情况下全名会比较有用, 例如你的标签和分支重名了, 你应该用全名去区分它们.

(新创建的引用会依据它们的名字存放在.git/refs目录中. 然而, 为了提高效率, 它们也可能被打包到一个文件中, 参见linkgit:git-pack-refs[1]).

另一个有用的技巧是, 仓库的名字可以代表该仓库的HEAD. 例如, "origin"是访问"origin"中的HEAD分支的一个捷径.

要了解Git查找引用路径的完全列表, 以及多个同名简写引用的优先级关系, 请参见linkgit:git-rev-parse[1]中的"SPECIFYING REVISIONS".

### 显示某分支特有的提交 ###

假设你想要查看在"master"分支可达(reachable)但其他任何分支不可达的提交.

我们可以使用linkgit:git-show-ref[1]列出仓库中所有的头:

    $ git show-ref --heads
    bf62196b5e363d73353a9dcf094c59595f3153b7 refs/heads/core-tutorial
    db768d5504c1bb46f63ee9d6e1772bd047e05bf9 refs/heads/maint
    a07157ac624b2524a059a3414e99f6f44bebc1e7 refs/heads/master
    24dbc180ea14dc1aebe09f14c8ecf32010690627 refs/heads/tutorial-2
    1e87486ae06626c2f31eaa63d26fc0fd646c8af2 refs/heads/tutorial-fixes

我们可以使用cut和grep得到"分支-头"(branch-head)部分, 不需要"master":

    $ git show-ref --heads | cut -d' ' -f2 | grep -v '^refs/heads/master'
    refs/heads/core-tutorial
    refs/heads/maint
    refs/heads/tutorial-2
    refs/heads/tutorial-fixes

然后我们就可以查看master中特有的提交:

    $ gitk master --not $( git show-ref --heads | cut -d' ' -f2 |
    				grep -v '^refs/heads/master' )

很明显上面的命令可以有无数种变种; 例如你想查看仓库中所有的分支可达但标签不可达的提交:

    $ gitk $( git show-ref --heads ) --not  $( git show-ref --tags )

(linkgit:git-rev-parse[1]提供了像"--not"之类的"选择提交"语法的解释.)

(!!update-ref!!)
