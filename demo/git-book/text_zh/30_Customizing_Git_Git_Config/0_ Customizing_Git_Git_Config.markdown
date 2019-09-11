## 定制Git ##

linkgit:git-config[1]

### 更改你的编辑器 ###

	$ git config --global core.editor emacs

### 添加别名 ###

	$ git config --global alias.last 'cat-file commit HEAD'

	$ git last
	tree c85fbd1996b8e7e5eda1288b56042c0cdb91836b
	parent cdc9a0a28173b6ba4aca00eb34f5aabb39980735
	author Scott Chacon <schacon@gmail.com> 1220473867 -0700
	committer Scott Chacon <schacon@gmail.com> 1220473867 -0700

	fixed a weird formatting problem

	$ git cat-file commit HEAD
	tree c85fbd1996b8e7e5eda1288b56042c0cdb91836b
	parent cdc9a0a28173b6ba4aca00eb34f5aabb39980735
	author Scott Chacon <schacon@gmail.com> 1220473867 -0700
	committer Scott Chacon <schacon@gmail.com> 1220473867 -0700

	fixed a weird formatting problem

### 添加颜色 ###

所有的color.*选项请参见linkgit:git-config[1]的文档

	$ git config color.branch auto
	$ git config color.diff auto
	$ git config color.interactive auto
	$ git config color.status auto

或者你可以通过color.ui选项把颜色全部打开:

	$ git config color.ui true

### 提交模板 ###

	$ git config commit.template '/etc/git-commit-template'

### 日志格式 ###

	$ git config format.pretty oneline


### 其他配置选项 ###

除上面提到的选项外, 还有很多很有趣的选项去配置打包, 垃圾回收, 合并, 分支, http传输, diff, 分页, 空白字符等等的行为. 如果你需要更加深入地调教git, 请阅读linkgit:git-config[1]文档.
