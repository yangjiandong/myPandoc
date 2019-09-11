### Git 配置 ###

使用Git的第一件事就是设置你的名字和email,这些就是你在提交commit时的签名。

    $ git config --global user.name "Scott Chacon"
    $ git config --global user.email "schacon@gmail.com"


执行了上面的命令后,会在你的主目录(home directory)建立一个叫 *~/.gitconfig*  的文件.
内容一般像下面这样:

    [user]
            name = Scott Chacon
            email = schacon@gmail.com

译者注:这样的设置是全局设置,会影响此用户建立的每个项目.
            

如果你想使项目里的某个值与前面的全局设置有区别(例如把私人邮箱地址改为工作邮箱);你可以在项目中使用git config 命令不带 *--global* 选项来设置. 这会在你项目目录下的 *.git/config* 文件增加一节[user]内容(如上所示).
