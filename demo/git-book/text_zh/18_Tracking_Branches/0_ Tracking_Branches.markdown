## 追踪分支 ##

在Git中‘追踪分支’是用与联系本地分支和远程分支的. 如果你在’追踪分支'(Tracking Branches)上执行推送(push)或拉取(pull)时,　它会自动推送(push)或拉取(pull)到关联的远程分支上.


如果你经常要从远程仓库里拉取(pull)分支到本地,并且不想很麻烦的使用"git pull <repository> <refspec>"这种格式; 那么就应当使用‘追踪分支'(Tracking Branches).

‘git clone‘命令会自动在本地建立一个'master'分支，它是'origin/master'的‘追踪分支’. 而'origin/master'就是被克隆(clone)仓库的'master'分支.
	
译者注: origin一般是指原始仓库地址的别名.


你可以在使用'git branch'命令时加上'--track'参数, 来手动创建一个'追踪分支'.

	git branch --track experimental origin/experimental


当你运行下命令时:

	$ git pull experimental
	

它会自动从‘origin'抓取(fetch)内容，再把远程的'origin/experimental'分支合并进(merge)本地的'experimental'分支.


当要把修改推送(push)到origin时, 它会将你本地的'experimental'分支中的修改推送到origin的‘experimental'分支里,　而无需指定它(origin).