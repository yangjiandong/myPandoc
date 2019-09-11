### Commit对象 ###

"commit对象"指向一个"tree对象", 并且带有相关的描述信息.

[fig:object-commit]

你可以用 --pretty=raw 参数来配合 linkgit:git-show[1] 或 linkgit:git-log[1] 去查看某个提交(commit):

    $ git show -s --pretty=raw 2be7fcb476
    commit 2be7fcb4764f2dbcee52635b91fedb1b3dcf7ab4
    tree fb3a8bdd0ceddd019615af4d57a53f43d8cee2bf
    parent 257a84d9d02e90447b149af58b271c19405edb6a
    author Dave Watson <dwatson@mimvista.com> 1187576872 -0400
    committer Junio C Hamano <gitster@pobox.com> 1187591163 -0700

        Fix misspelling of 'suppress' in docs

        Signed-off-by: Junio C Hamano <gitster@pobox.com>


你可以看到, 一个提交(commit)由以下的部分组成:

- 一个 **tree**　对象: tree对象的SHA1签名, 代表着目录在某一时间点的内容. 

- **父对象** (parent(s)): 提交(commit)的SHA1签名代表着当前提交前一步的项目历史. 上面的那个例子就只有一个父对象; 合并的提交(merge commits)可能会有不只一个父对象.  如果一个提交没有父对象, 那么我们就叫它“根提交"(root commit), 它就代表着项目最初的一个版本(revision). 每个项目必须有至少有一个“根提交"(root commit). 一个项目可能有多个"根提交“，虽然这并不常见(这不是好的作法).

- **作者** : 做了此次修改的人的名字,　还有修改日期.

- **提交者**（committer): 实际创建提交(commit)的人的名字, 同时也带有提交日期. TA可能会和作者不是同一个人; 例如作者写一个补丁(patch)并把它用邮件发给提交者, 由他来创建提交(commit).

－**注释** 用来描述此次提交.


注意: 一个提交(commit)本身并没有包括任何信息来说明其做了哪些修改; 所有的修改(changes)都是通过与父提交(parents)的内容比较而得出的. 值得一提的是, 尽管git可以检测到文件内容不变而路径改变的情况, 但是它不会去显式(explicitly)的记录文件的更名操作.　(你可以看一下 linkgit:git-diff[1] 的 -M　参数的用法)

一般用 linkgit:git-commit[1] 来创建一个提交(commit), 这个提交(commit)的父对象一般是当前分支(current HEAD),　同时把存储在当前索引(index)的内容全部提交.


### 对象模型 ###

现在我们已经了解了3种主要对象类型(blob, tree 和 commit), 好现在就让我们大概了解一下它们怎么组合到一起的.

如果我们一个小项目, 有如下的目录结构:

    $>tree
    .
    |-- README
    `-- lib
        |-- inc
        |   `-- tricks.rb
        `-- mylib.rb

    2 directories, 3 files


如果我们把它提交(commit)到一个Git仓库中, 在Git中它们也许看起来就如下图:

[fig:objects-example]

你可以看到: 每个目录都创建了 **tree对象** (包括根目录), 每个文件都创建了一个对应的 **blob对象** . 最后有一个 **commit对象** 来指向根tree对象(root of trees), 这样我们就可以追踪项目每一项提交内容.