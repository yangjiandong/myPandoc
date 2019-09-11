## 更底层的Git ##

这一章我们会学习如何在更低的层次操作Git, 以防你需要自己写一个新工具去人工生成blob(块), tree(树)或者commit(提交)对象. 如果你想使用更加底层的Git命令去写脚本, 你会需要用到以下的命令.

### 创建blob对象 ###

在你的Git仓库中创建一个blob对象并且得到它的SHA值是很容易的, 使用linkgit:git-hash-object[1]就足够了. 要使用一个现有的文件去创建新blob, 使用'-w'选项去运行前面提到的命令('-w'选项告诉Git要生成blob, 而不是仅仅计算SHA值).

	$ git hash-object -w myfile.txt
	6ff87c4664981e4397625791c8ea3bbb5f2279a3

	$ git hash-object -w myfile2.txt
	3bb0e8592a41ae3185ee32266c860714980dbed7

标准输出中显示的值就是创建的blob的SHA值.

### 创建tree对象 ###

假设你要使用你创建的一些对象去组建一棵树, 按照linkgit:git-ls-tree[1]的格式组织好输入, linkgit:git-mktree[1]就可以为你生成需要的tree对象. 例如, 如果你把下面的信息写入到'/tmp/tree.txt'中:

	100644 blob 6ff87c4664981e4397625791c8ea3bbb5f2279a3	file1
	100644 blob 3bb0e8592a41ae3185ee32266c860714980dbed7	file2

然后通过管道把这些信息输入到linkgit:git-mktree[1]中, Git会生成一个新的tree对象, 把它写入到对象数据库(object database)中, 然后返回tree对象的SHA值.

	$ cat /tmp/tree.txt | git mk-tree
	f66a66ab6a7bfe86d52a66516ace212efa00fe1f

然后, 我们可以把刚才生成的tree作为另外一个tree的子目录, 等等等等. 如果我们需要创建一个带子树的树对象(这个子树就是前面生成的tree对象), 只需创建一个新文件(/tmp/newtree.txt), 把前面的tree对象的SHA值写入:

	100644 blob 6ff87c4664981e4397625791c8ea3bbb5f2279a3	file1-copy
	040000 tree f66a66ab6a7bfe86d52a66516ace212efa00fe1f	our_files

然后再次调用linkgit:git-mk-tree[1]:

	$ cat /tmp/newtree.txt | git mk-tree
	5bac6559179bd543a024d6d187692343e2d8ae83

现在我们有了一个人工创建的目录结构:

	.
	|-- file1-copy
	`-- our_files
	    |-- file1
	    `-- file2

	1 directory, 3 files
	
但是上面的结构并不在磁盘上存在. 另外, 我们使用SHA值去指向它(<code>5bac6559</code>).

### 重新组织树 ###

我们也可以使用索引文件把树嵌入到新的结构中. 举个简单的例子, 我们使用一个临时索引文件创建一棵新的树, 其中包含了<code>5bac6559</code>这棵树的两个副本. (设置GIT_INDEX_FILE环境变量使之指向临时索引文件)

首先, 用linkgit:git-read-tree[1]把树对象读入到临时索引文件中, 并给每个副本一个新的前缀; 然后再用linkgit:git-write-tree[1]把索引中的内容生成一棵新的树:

	$ export GIT_INDEX_FILE=/tmp/index
	$ git read-tree --prefix=copy1/  5bac6559
	$ git read-tree --prefix=copy2/  5bac6559
	$ git write-tree 
	bb2fa6de7625322322382215d9ea78cfe76508c1
	
	$>git ls-tree bb2fa
	040000 tree 5bac6559179bd543a024d6d187692343e2d8ae83	copy1
	040000 tree 5bac6559179bd543a024d6d187692343e2d8ae83	copy2
	
现在我们可以看到, 通过操纵索引文件可以得到一棵新的树. 你也可以在临时索引文件中做合并等操作 - 请参见linkgit:git-read-tree[1]取得更多信息.

### 创建commit对象 ###

现在我们有了一棵树的SHA值, 我们可以使用linkgit:git-commit-tree[1]命令创建一个指向它的commit对象. 大部分commit对象的数据都是通过环境变量来设定的, 你需要设置下面的环境变量:

	GIT_AUTHOR_NAME
	GIT_AUTHOR_EMAIL
	GIT_AUTHOR_DATE
	GIT_COMMITTER_NAME
	GIT_COMMITTER_EMAIL
	GIT_COMMITTER_DATE

然后你把你的提交信息写入到一个文件中并且通过管道传送给linkgit:git-commit-tree[1], 即可得到一个commit对象.

	$ git commit-tree bb2fa < /tmp/message
	a5f85ba5875917319471dfd98dfc636c1dc65650
	
如果你需要指定一个或多个父commit对象, 只需要使用'-p'参数一个一个指定父commit对象. 同样的, 新对象的SHA值通过STDOUT返回.

### 更新分支的引用 ###

现在我得拿到了新的commit对象的SHA值, 如有需要, 我们可以使用一个分支指向它. 比如说我们需要更新'master'分支的引用, 使其指向刚刚创建的新对象, 我们可以使用linkgit:git-update-ref[1]去完成这个工作:

	$ git update-ref refs/heads/master a5f85ba5875917319471dfd98dfc636c1dc65650

