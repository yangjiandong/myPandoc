## Git索引 ##

索引(index)是一个存放了排好序的路径的二进制文件(通常是.git/index), 每一个条目都附带有一个块对象的SHA1值以及访问权限; linkgit:git-ls-files[1]可以显示出索引的内容:

    $ git ls-files --stage
    100644 63c918c667fa005ff12ad89437f2fdc80926e21c 0	.gitignore
    100644 5529b198e8d14decbe4ad99db3f7fb632de0439d 0	.mailmap
    100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0	COPYING
    100644 a37b2152bd26be2c2289e1f57a292534a51a93c7 0	Documentation/.gitignore
    100644 fbefe9a45b00a54b58d94d06eca48b03d40a50e0 0	Documentation/Makefile
    ...
    100644 2511aef8d89ab52be5ec6a5e46236b4b6bcd07ea 0	xdiff/xtypes.h
    100644 2ade97b2574a9f77e7ae4002a4e07a6a38e46d07 0	xdiff/xutils.c
    100644 d5de8292e05e7c36c4b68857c1cf9855e3d2f70a 0	xdiff/xutils.h

请注意, 在一些旧的文档中, 索引可能被称为"当前目录缓存(current directory cache)"或者"缓存(cache)". 它有三个重要的属性:

1. 索引存储了生成一个(独一无二的)树对象所需要的所有信息.

    例如, 运行linkgit:git-commit[1]会从索引中生成一个树对象, 把这个树对象存储在对象数据库(object database)中, 然后把它与这个提交关联起来. (译注: 回忆"查看Git对象"一章, 每一个提交都对应一个树对象.)

2. 索引使得对索引生成的树对象和工作树进行快速比较成为可能.

    索引通过存储每个对象的一些额外信息(比如说最后修改时间)来完成这个工作. 这些数据没有在上面显示出来, 也没有存储在创建出来的树对象中, 但是它们可以用于快速找出当时工作目录中的文件与索引的差异, 从而让Git不必将文件的内容全部读出.

3. 索引可以有效地表示树对象合并时的冲突信息, 使得每一个路径名都有足够的信息与树对象联系起来, 从而可以对它们进行三路合并.

    在合并期间, 索引可能存储一个文件的多个版本(称为"stages"). 上面linkgit:git-ls-files[1]的第三栏输出就是stage号. 在出现合并冲突时, 这个号码会是其他值, 而不是0.

因此索引实际上是一种暂存区域(temporary staging area), 它装载了你正在使用的树对象.
