## 交互式rebase ##

你亦可以选择进行交互式的rebase。这种方法通常用于在向别处推送提交之前对它们进行重写。交互式rebase提供了一个简单易用的途径让你在和别人分享提交之前对你的提交进行分割、合并或者重排序。在把从其他开发者处拉取的提交应用到本地时，你也可以使用交互式rebase对它们进行清理。

如果你想在rebase的过程中对一部分提交进行修改，你可以在'git rebase'命令中加入'-i'或'--interactive'参数去调用交互模式。

	$ git rebase -i origin/master

这个命令会执行交互式rebase操作，操作对象是那些自最后一次从origin仓库拉取或者向origin推送之后的所有提交。

若想查看一下将被rebase的提交，可以用如下的log命令：

	$ git log github/master..

一旦运行了'rebase -i'命令，你所预设的编辑器会被调用，其中含有如下的内容：

	pick fc62e55 added file_size
	pick 9824bf4 fixed little thing
	pick 21d80a5 added number to log
	pick 76b9da6 added the apply command
	pick c264051 Revert "added file_size" - not implemented correctly

	# Rebase f408319..b04dc3d onto f408319
	#
	# Commands:
	#  p, pick = use commit
	#  e, edit = use commit, but stop for amending
	#  s, squash = use commit, but meld into previous commit
	#
	# If you remove a line here THAT COMMIT WILL BE LOST.
	# However, if you remove everything, the rebase will be aborted.
	#

这些信息表示从你上一次推送操作起有5个提交。每个提交都用一行来表示，行格式如下：

	(action) (partial-sha) (short commit message)

现在你可以将操作（action）改为'edit'（使用提交，但是暂停以便进行修正）或者'squash'（使用提交，但是把它与前一提交合并），默认是'pick'（使用提交）。你可以对这些行上下移动从而对提交进行重排序。当你退出编辑器时，git会按照你指定的顺序去应用提交，并且做出相应的操作（action）。

如果指定进行'pick'操作，git会应用这个补丁，以同样的提交信息（commit message）保存提交。

如果指定进行'squash'操作，git会把这个提交和前一个提交合并成为一个新的提交。这会再次调用编辑器，你在里面合并这两个提交的提交信息。所以，如果你（在上一步）以如下的内容离开编辑器：

	pick   fc62e55 added file_size
	squash 9824bf4 fixed little thing
	squash 21d80a5 added number to log
	squash 76b9da6 added the apply command
	squash c264051 Revert "added file_size" - not implemented correctly

你必须基于以下的提交信息创建一个新的提交信息：

	# This is a combination of 5 commits.
	# The first commit's message is:
	added file_size

	# This is the 2nd commit message:

	fixed little thing

	# This is the 3rd commit message:

	added number to log

	# This is the 4th commit message:

	added the apply command

	# This is the 5th commit message:

	Revert "added file_size" - not implemented correctly

	This reverts commit fc62e5543b195f18391886b9f663d5a7eca38e84.

一旦你完成对提交信息的编辑并且退出编辑器，这个新的提交及提交信息会被保存起来。

如果指定进行'edit'操作，git会完成同样的工作，但是在对下一提交进行操作之前，它会返回到命令行让你对提交进行修正，或者对提交内容进行修改。

例如你想要分割一个提交，你需要对那个提交指定'edit'操作：

	pick   fc62e55 added file_size
	pick   9824bf4 fixed little thing
	edit   21d80a5 added number to log
	pick   76b9da6 added the apply command
	pick   c264051 Revert "added file_size" - not implemented correctly

你会进入到命令行，撤消（revert）该提交，然后创建两个（或者更多个）新提交。假设提交21d80a5修改了两个文件，file1和file2，你想把这两个修改放到不同的提交里。你可以在进入命令行之后进行如下的操作：

	$ git reset HEAD^
	$ git add file1
	$ git commit 'first part of split commit'
	$ git add file2
	$ git commit 'second part of split commit'
	$ git rebase --continue

现在你有6个提交了，而不是5个。

交互式rebase的最后一个作用是丢弃提交。如果把一行删除而不是指定'pick'、'squash'和'edit'中的任何一个，git会从历史中移除该提交。
