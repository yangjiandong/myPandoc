# 介绍

来自 Git 团队的 Brandon Williams 今天在博客上宣布推出了 Git 协议的 v2 版本(Git protocol version 2)，v2 协议又叫做 Git Wire Protocol，Git 协议 2.0 版本效率更高，并拥有显著的性能优势，旨在改进 Git 的传输过程。

新的 Git 线协议为 reference 提供服务端过滤、让扩展新特性变得更容易以及简化 HTTP 传输的客户端处理。

谷歌已经在内部使用新版本的 Git 协议来提升速度。Brandon Williams 解释道：“对于包含 500k references 的仓库中的单个分支的无操作读取，性能提升了 3 倍。新版本协议还使得从 googlesource.com 服务器发送出来的开销字节数减少到原先的八分之一。这种改进主要是由于只返回客户端需要的 reference。”

Git protocol-v2 的开发成果在不到两周前合并到了 Git 2.18 的 mainline 上。凭借着显著的优势，谷歌已经在 Google Source 和 Cloud Source 仓库的 Git 服务器上支持这项新协议。

# Method

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,
no sea takimata sanctus est Lorem ipsum dolor sit amet.

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,
no sea takimata sanctus est Lorem ipsum dolor sit amet.

# Footnotes

Example of footnote^[A footnote example]. Lorem ipsum dolor sit amet, consectetur
adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim
id est laborum.

# Cites

Zotero + Better BibTex. All cites are on the file bibliography.bib. This is
a cite[@djangoproject_models_2016].

# Conclusion

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,
no sea takimata sanctus est Lorem ipsum dolor sit amet.

# References

