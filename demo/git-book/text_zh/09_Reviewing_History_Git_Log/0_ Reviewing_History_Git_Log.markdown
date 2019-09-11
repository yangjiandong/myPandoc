## 查看历史 －Git日志 ##

linkgit:git-log[1]命令可以显示所有的提交(commit)。 ......

    $ git log v2.5..	    # commits since (not reachable from) v2.5
    $ git log test..master	# commits reachable from master but not test
    $ git log master..test	# commits reachable from test but not master
    $ git log master...test	# commits reachable from either test or
    			            #    master, but not both
    $ git log --since="2 weeks ago" # commits from the last 2 weeks
    $ git log Makefile      # commits that modify Makefile
    $ git log fs/		    # commits that modify any file under fs/
    $ git log -S'foo()'	    # commits that add or remove any file data
    			            # matching the string 'foo()'
    $ git log --no-merges	# dont show merge commits

当然你也可以组合上面的命令选项；下面的命令就是找出所有从"v2.5“开
始在fs目录下的所有Makefile的修改.

    $ git log v2.5.. Makefile fs/

Git会根据git log命令的参数，按时间顺序显示相关的提交(commit)。

	commit f491239170cb1463c7c3cd970862d6de636ba787
	Author: Matt McCutchen <matt@mattmccutchen.net>
	Date:   Thu Aug 14 13:37:41 2008 -0400

	    git format-patch documentation: clarify what --cover-letter does
    
	commit 7950659dc9ef7f2b50b18010622299c508bfdfc3
	Author: Eric Raible <raible@gmail.com>
	Date:   Thu Aug 14 10:12:54 2008 -0700

	    bash completion: 'git apply' should use 'fix' not 'strip'
	    Bring completion up to date with the man page.
   
你也可以让git log显示补丁(patchs):

    $ git log -p

	commit da9973c6f9600d90e64aac647f3ed22dfd692f70
	Author: Robert Schiele <rschiele@gmail.com>
	Date:   Mon Aug 18 16:17:04 2008 +0200

	    adapt git-cvsserver manpage to dash-free syntax

	diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
	index c2d3c90..785779e 100644
	--- a/Documentation/git-cvsserver.txt
	+++ b/Documentation/git-cvsserver.txt
	@@ -11,7 +11,7 @@ SYNOPSIS
	 SSH:

	 [verse]
	-export CVS_SERVER=git-cvsserver
	+export CVS_SERVER="git cvsserver"
	 'cvs' -d :ext:user@server/path/repo.git co <HEAD_name>

	 pserver (/etc/inetd.conf):


### 日志统计 ###

如果用<code>--stat</code>选项使用'git log',它会显示在每个提交(commit)中哪些文件被修改了, 这些文件分别添加或删除了多少行内容.

	$ git log --stat
	
	commit dba9194a49452b5f093b96872e19c91b50e526aa
	Author: Junio C Hamano <gitster@pobox.com>
	Date:   Sun Aug 17 15:44:11 2008 -0700

	    Start 1.6.0.X maintenance series
    
	 Documentation/RelNotes-1.6.0.1.txt |   15 +++++++++++++++
	 RelNotes                           |    2 +-
	 2 files changed, 16 insertions(+), 1 deletions(-)


### 格式化日志 ###

你可以按你的要求来格式化日志输出。‘--pretty'参数可以使用若干表现格式，如‘oneline':

	$ git log --pretty=oneline
	a6b444f570558a5f31ab508dc2a24dc34773825f dammit, this is the second time this has reverted
	49d77f72783e4e9f12d1bbcacc45e7a15c800240 modified index to create refs/heads if it is not 
	9764edd90cf9a423c9698a2f1e814f16f0111238 Add diff-lcs dependency
	e1ba1e3ca83d53a2f16b39c453fad33380f8d1cc Add dependency for Open4
	0f87b4d9020fff756c18323106b3fd4e2f422135 merged recent changes: * accepts relative alt pat
	f0ce7d5979dfb0f415799d086e14a8d2f9653300 updated the Manifest file


或者你也可以使用 'short' 格式:

	$ git log --pretty=short
	commit a6b444f570558a5f31ab508dc2a24dc34773825f
	Author: Scott Chacon <schacon@gmail.com>

	    dammit, this is the second time this has reverted

	commit 49d77f72783e4e9f12d1bbcacc45e7a15c800240
	Author: Scott Chacon <schacon@gmail.com>

	    modified index to create refs/heads if it is not there

	commit 9764edd90cf9a423c9698a2f1e814f16f0111238
	Author: Hans Engel <engel@engel.uk.to>

	    Add diff-lcs dependency

你也可用‘medium','full','fuller','email' 或‘raw'. 如果这些格式不完全符合你的相求，
你也可以用‘--pretty=format'参数(参见：linkgit:git-log[1])来创建你自己的"格式“.

	$ git log --pretty=format:'%h was %an, %ar, message: %s'
	a6b444f was Scott Chacon, 5 days ago, message: dammit, this is the second time this has re
	49d77f7 was Scott Chacon, 8 days ago, message: modified index to create refs/heads if it i
	9764edd was Hans Engel, 11 days ago, message: Add diff-lcs dependency
	e1ba1e3 was Hans Engel, 11 days ago, message: Add dependency for Open4
	0f87b4d was Scott Chacon, 12 days ago, message: merged recent changes:
	
另一个有趣的事是：你可以用'--graph'选项来可视化你的提交图(commit graph),就像下面这样:

	$ git log --pretty=format:'%h : %s' --graph
	* 2d3acf9 : ignore errors from SIGCHLD on trap
	*   5e3ee11 : Merge branch 'master' of git://github.com/dustin/grit
	|\  
	| * 420eac9 : Added a method for getting the current branch.
	* | 30e367c : timeout code and tests
	* | 5a09431 : add timeout protection to grit
	* | e1193f8 : support for heads with slashes in them
	|/  
	* d6016bc : require time for xmlschema

它会用ASCII字符来画出一个很漂亮的提交历史(commit history)线。


### 日志排序 ###


你也可以把日志记录按一些不同的顺序来显示。注意，git日志从最近的提交(commit)开始，并且从这里开始向它们父分支回溯。然而git历史可能包括多个互不关联的开发线路，这样有时提交(commits)显示出来就有点杂乱。


如果你要指定一个特定的顺序，可以为git log命令添加顺序参数(ordering option).

按默认情况，提交(commits)会按逆时间(reverse chronological)顺序显示。


但是你也可以指定‘--topo-order'参数，这就会让提交(commits)按拓朴顺序来显示(就是子提交在它们的父提交前显示). 如果你用git log命令按拓朴顺序来显示git仓库的提交日志，你会看到“开发线"(development lines)都会集合在一起.

	$ git log --pretty=format:'%h : %s' --topo-order --graph
	*   4a904d7 : Merge branch 'idx2'
	|\  
	| *   dfeffce : merged in bryces changes and fixed some testing issues
	| |\  
	| | * 23f4ecf : Clarify how to get a full count out of Repo#commits
	| | *   9d6d250 : Appropriate time-zone test fix from halorgium
	| | |\  
	| | | * cec36f7 : Fix the to_hash test to run in US/Pacific time
	| | * | decfe7b : fixed manifest and grit.rb to make correct gemspec
	| | * | cd27d57 : added lib/grit/commit_stats.rb to the big list o' files
	| | * | 823a9d9 : cleared out errors by adding in Grit::Git#run method
	| | * |   4eb3bf0 : resolved merge conflicts, hopefully amicably
	| | |\ \  
	| | | * | d065e76 : empty commit to push project to runcoderun
	| | | * | 3fa3284 : whitespace
	| | | * | d01cffd : whitespace
	| | | * | 7c74272 : oops, update version here too
	| | | * | 13f8cc3 : push 0.8.3
	| | | * | 06bae5a : capture stderr and log it if debug is true when running commands
	| | | * | 0b5bedf : update history
	| | | * | d40e1f0 : some docs
	| | | * | ef8a23c : update gemspec to include the newly added files to manifest
	| | | * | 15dd347 : add missing files to manifest; add grit test
	| | | * | 3dabb6a : allow sending debug messages to a user defined logger if provided; tes
	| | | * | eac1c37 : pull out the date in this assertion and compare as xmlschemaw, to avoi
	| | | * | 0a7d387 : Removed debug print.
	| | | * | 4d6b69c : Fixed to close opened file description.


你也可以用'--date-order'参数，这样显示提交日志的顺序主要按提交日期来排序. 这个参数和'--topo-order'有一点像，没有父分支会在它们的子分支前显示，但是其它的东东还是按交时间来排序显示。你会看到"开发线"(development lines)没有集合一起，它们会像并行开发(parallel development)一样跳来跳去的：

	$ git log --pretty=format:'%h : %s' --date-order --graph
	*   4a904d7 : Merge branch 'idx2'
	|\  
	* | 81a3e0d : updated packfile code to recognize index v2
	| *   dfeffce : merged in bryces changes and fixed some testing issues
	| |\  
	| * | c615d80 : fixed a log issue
	|/ /  
	| * 23f4ecf : Clarify how to get a full count out of Repo#commits
	| *   9d6d250 : Appropriate time-zone test fix from halorgium
	| |\  
	| * | decfe7b : fixed manifest and grit.rb to make correct gemspec
	| * | cd27d57 : added lib/grit/commit_stats.rb to the big list o' file
	| * | 823a9d9 : cleared out errors by adding in Grit::Git#run method
	| * |   4eb3bf0 : resolved merge conflicts, hopefully amicably
	| |\ \  
	| * | | ba23640 : Fix CommitDb errors in test (was this the right fix?
	| * | | 4d8873e : test_commit no longer fails if you're not in PDT
	| * | | b3285ad : Use the appropriate method to find a first occurrenc
	| * | | 44dda6c : more cleanly accept separate options for initializin
	| * | | 839ba9f : needed to be able to ask Repo.new to work with a bar
	| | * | d065e76 : empty commit to push project to runcoderun
	* | | | 791ec6b : updated grit gemspec
	* | | | 756a947 : including code from github updates
	| | * | 3fa3284 : whitespace
	| | * | d01cffd : whitespace
	| * | | a0e4a3d : updated grit gemspec
	| * | | 7569d0d : including code from github updates


最后，你也可以用 ‘--reverse'参数来逆向显示所有日志。

[gitcast:c4-git-log]("GitCast #4: Git Log")
