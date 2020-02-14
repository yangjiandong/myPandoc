# Markdown 学术写作例子. 重庆大学论文

- 详细用法请查看[我的博客](http://zale.site/articles/2016/05/Academia-Writing-Using-Markdown-and-Pandoc.html)
- [Academia-Writing-with-Markdown-Using-Pandoc](https://github.com/zl810881283/Academia-Writing-with-Markdown-Using-Pandoc)
- [参考](http://www.zale.site/articles/2016/05/Academia-Writing-Using-Markdown-and-Pandoc.html)


install

```
brew install pandoc-crossref
brew install pandoc-citeproc
sudo tlmgr  install epstopdf
sudo tlmgr install bbding
sudo tlmgr install mathcomp
sudo tlmgr install multirow
sudo tlmgr install zhspacing
sudo tlmgr install footnpag
```

pdf

```
pandoc --filter pandoc-crossref --filter pandoc-citeproc --biblio reference.bib --csl chinese-gb7714-2005-numeric.csl --latex-engine=xelatex --template=cqu.latex main.md -o main.pdf
```

error:
```
l.68 ...bold\zhttfont{[simfang.ttf]}{[simkai.ttf]}
```

edit:
```
/usr/local/texlive/2017basic/texmf-dist/tex/xelatex/zhspacing/zhfont.sty
```

暂时注释掉
```
\ifzhfont@fakebold
  \newfontfamilywithslant\zhrmfont{SimSun}
  \newfontfamilywithslant\zhsffont{SimHei}
  % \newfontfamilywithslant\zhttfont{[simfang.ttf]}
\else
  \newfontfamilywithslantandbold\zhrmfont{SimSun}{SimHei}
  \newfontfamilywithslant\zhsffont{SimHei}
  % \newfontfamilywithslantandbold\zhttfont{[simfang.ttf]}{[simkai.ttf]}
\fi
```

[参考](https://github.com/CTeX-org/ctex-kit/blob/master/zhspacing/zhfont.sty)

>个别环境下报 `The font "文泉驿等宽正黑" cannot be found.`, 替换 cqu.cls 中所有相关字体，比如 `冬青黑体简体中文`，有可能只能用系统字体，用户安装的字体总是报找不到

docx

```
pandoc --filter pandoc-crossref --filter pandoc-citeproc --biblio reference.bib --csl chinese-gb7714-2005-numeric.csl --latex-engine=xelatex  main.md -o main.docx
```

>2018.03.26 解决以上问题, ok

针对 2015版 texlatex, use `tlmgr option repository ftp://tug.org/historic/systems/texlive/2015/tlnet-final` 升级
