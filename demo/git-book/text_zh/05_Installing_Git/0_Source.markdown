### 从源代码开始安装 ###

如果你在一个其基于Unix的系统中，你可以从Git的官网上[Git Download Page](http://git-scm.com/download)下载它的源代码,并运行像下面的几行命令,你就可以安装:

    $ make prefix=/usr all ;# as yourself 
    $ make prefix=/usr install ;# 以root权限运行


你需一些库: [expat](http://expat.sourceforge.net/),[curl](http://curl.linux-mirror.org),
[zlib](http://www.zlib.net), 和 [openssl](http://www.openssl.org); 除了expat 外，其它的可能在你的机器上都安装了。




