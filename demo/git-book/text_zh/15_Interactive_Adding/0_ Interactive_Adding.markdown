## 交互式添加 ##

交互式添加提供友好的界面去操作Git索引（index），同时亦提供了可视化索引的能力。只需简单键入'git add -i'，即可使用此功能。Git会列出所有修改过的文件及它们的状态。

	$>git add -i
	           staged     unstaged path
	  1:    unchanged        +4/-0 assets/stylesheets/style.css
	  2:    unchanged      +23/-11 layout/book_index_template.html
	  3:    unchanged        +7/-7 layout/chapter_template.html
	  4:    unchanged        +3/-3 script/pdf.rb
	  5:    unchanged      +121/-0 text/14_Interactive_Rebasing/0_ Interactive_Rebasing.markdown

	*** Commands ***
	  1: status	  2: update	  3: revert	  4: add untracked
	  5: patch	  6: diff	  7: quit	  8: help
	What now> 

在这个例子中，我们可以看到有5个修改过的文件还没有被加入到索引中（unstaged），甚至可以看到每个文件增加和减少的行数。紧接着是一个交互式的菜单，列出了我们可以在此模式中使用的命令。

如果我们想要暂存（stage）这些文件，我们可以键入'2'或者'u'进入更新（update）模式。然后我们可以通过键入文件的范围（本例中是1-4）来决定把哪些文件加入到索引之中。

	What now> 2
	           staged     unstaged path
	  1:    unchanged        +4/-0 assets/stylesheets/style.css
	  2:    unchanged      +23/-11 layout/book_index_template.html
	  3:    unchanged        +7/-7 layout/chapter_template.html
	  4:    unchanged        +3/-3 script/pdf.rb
	  5:    unchanged      +121/-0 text/14_Interactive_Rebasing/0_ Interactive_Rebasing.markdown
	Update>> 1-4
	           staged     unstaged path
	* 1:    unchanged        +4/-0 assets/stylesheets/style.css
	* 2:    unchanged      +23/-11 layout/book_index_template.html
	* 3:    unchanged        +7/-7 layout/chapter_template.html
	* 4:    unchanged        +3/-3 script/pdf.rb
	  5:    unchanged      +121/-0 text/14_Interactive_Rebasing/0_ Interactive_Rebasing.markdown
	Update>> 

如果键入回车，我会回到主菜单中，同时可以看到那些指定文件的状态已经发生了改变：

	What now> status
	           staged     unstaged path
	  1:        +4/-0      nothing assets/stylesheets/style.css
	  2:      +23/-11      nothing layout/book_index_template.html
	  3:        +7/-7      nothing layout/chapter_template.html
	  4:        +3/-3      nothing script/pdf.rb
	  5:    unchanged      +121/-0 text/14_Interactive_Rebasing/0_ Interactive_Rebasing.markdown

现在我们可以看到前4个文件已经被暂存，但是最后一个没有。基本上，这是一个更加紧凑的查看状态的方式，实质上的信息与我们在命令行中运行'git status'是一致的：

	$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	modified:   assets/stylesheets/style.css
	#	modified:   layout/book_index_template.html
	#	modified:   layout/chapter_template.html
	#	modified:   script/pdf.rb
	#
	# Changed but not updated:
	#   (use "git add <file>..." to update what will be committed)
	#
	#	modified:   text/14_Interactive_Rebasing/0_ Interactive_Rebasing.markdown
	#

我们可以进行数个有用的操作，包括取消文件的暂存（3: revert），加入未跟踪的文件（4: add untracked）和查看差异（6: diff）。这些功能都很易懂。还有一个很“酷”的功能，就是暂存补丁（staging patches）（5: patch）。

如果你键入'5'或者'p'，git会一个一个补丁（一块一块）地显示出差异，然后询问是否对每一块进行暂存操作。通过这个方法，你可以暂存文件修改中的一部分。如果你编辑了一个文件，只想提交其中一部分而不包括其他未完成编辑的部分，或者把文档、空白字符从大量的修改中分开提交，你可以使用'git add -i'去相对轻松地完成任务。

这里我暂存了book_index_template.html的部分修改，而不是全部修改：

	         staged     unstaged path
	1:        +4/-0      nothing assets/stylesheets/style.css
	2:       +20/-7        +3/-4 layout/book_index_template.html
	3:        +7/-7      nothing layout/chapter_template.html
	4:        +3/-3      nothing script/pdf.rb
	5:    unchanged      +121/-0 text/14_Interactive_Rebasing/0_ Interactive_Rebasing.markdown
	6:    unchanged       +85/-0 text/15_Interactive_Adding/0_ Interactive_Adding.markdown

当你通过'git add -i'完成对索引的改动后，你只需要退出（7: quit），然后'git commit'去提交暂存的修改。切记**不要**运行'git commit -a'，它会忽视你刚才辛辛苦苦做的修改而把所有东西都提交到仓库中去。

[gitcast:c3_add_interactive]("GitCast #3: Interactive Adding")
