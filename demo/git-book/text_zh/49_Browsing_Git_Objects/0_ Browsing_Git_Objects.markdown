## 查看Git对象 ##

我们可以使用cat-file命令去查询特定对象的信息. 注意下面只键入了SHA值的一部分, 不必把40个字符全部键入:

    $ git-cat-file -t 54196cc2
    commit
    $ git-cat-file commit 54196cc2
    tree 92b8b694ffb1675e5975148e1121810081dbdffe
    author J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
    committer J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500

    initial commit

一个树(tree)对象可以引用一个或多个块(blob)对象, 每个块对象都对应一个文件. 更进一步, 树对象亦可以引用其他的树对象, 从而构成一个目录层次结构. 你可以使用ls-tree去查看树的内容:

    $ git ls-tree 92b8b694
    100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad    file.txt

我们可以看到树中包含了一个文件. SHA值是文件内容的一个引用(译者注: 相当于指针指向对应的块对象).

    $ git cat-file -t 3b18e512
    blob

一个"块"(blob)即是文件的数据, 我们可以用cat-file查看其内容:

    $ git cat-file blob 3b18e512
    hello world

注意到文件中的数据是旧的. 初始树其实是第一次提交时记录的目录状态快照.

所有的对象都使用SHA1值作为索引存储在git目录之下:

    $ find .git/objects/
    .git/objects/
    .git/objects/pack
    .git/objects/info
    .git/objects/3b
    .git/objects/3b/18e512dba79e4c8300dd08aeb37f8e728b8dad
    .git/objects/92
    .git/objects/92/b8b694ffb1675e5975148e1121810081dbdffe
    .git/objects/54
    .git/objects/54/196cc2703dc165cbd373a65a4dcf22d50ae7f7
    .git/objects/a0
    .git/objects/a0/423896973644771497bdc03eb99d5281615b51
    .git/objects/d0
    .git/objects/d0/492b368b66bdabf2ac1fd8c92b39d3db916e59
    .git/objects/c4
    .git/objects/c4/d59f390b9cfd4318117afde11d601c1085f241

这些文件的内容其实是压缩的数据外加一个标注类型和长度的头. 类型可以是块(blob), 树(tree), 提交(commit)或者标签(tag).

最容易找到提交是HEAD提交, 我们可以在.git/HEAD中找到:

    $ cat .git/HEAD
    ref: refs/heads/master

如你所见, 上面的输出告诉了我们现在在哪个分支之上工作. Git通过创建.git目录下的文件去标识分支(译注: 即refs/heads下面的文件, 多个分支会有多个文件). 每个文件中包含了一个提交的SHA1值, 我们可以用cat-file去查看此提交的内容(译注: 此提交即为该分支的头):

    $ cat .git/refs/heads/master
    c4d59f390b9cfd4318117afde11d601c1085f241
    $ git cat-file -t c4d59f39
    commit
    $ git cat-file commit c4d59f39
    tree d0492b368b66bdabf2ac1fd8c92b39d3db916e59
    parent 54196cc2703dc165cbd373a65a4dcf22d50ae7f7
    author J. Bruce Fields <bfields@puzzle.fieldses.org> 1143418702 -0500
    committer J. Bruce Fields <bfields@puzzle.fieldses.org> 1143418702 -0500

    add emphasis

这里的树对象指向了这棵树的新状态:

    $ git ls-tree d0492b36
    100644 blob a0423896973644771497bdc03eb99d5281615b51    file.txt
    $ git cat-file blob a0423896
    hello world!

父对象指向了前一个提交:

    $ git-cat-file commit 54196cc2
    tree 92b8b694ffb1675e5975148e1121810081dbdffe
    author J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
    committer J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
