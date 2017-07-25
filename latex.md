
latex
---

### example

sdcamp

```
cd sdcamp/contents
make latex
```

### mac xetaex

```
/Library/TeX/Distributions/Programs/texbin
```

```
export PATH=$PATH:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin
```

### documentclass

```
\documentclass[11pt,twoside,a4paper]{article}
```

- article, 排版科技期刊、短报告、程序文档、邀请函等。
- report, 排版多章节的长报告、短篇的书籍、博士论文等。
- book, 排版书籍。
- slides, 排版幻灯片。其中使用了较大的 sans serif 字体。也可以考虑使用 FoilTEX 来得到相同的效果。


- 10pt, 11pt, 12pt: 设置文档所使用的字体的大小。如果没有声明任何选项，缺省将使用 10pt 字体。
- a4paper, letterpaper, . . .    定义纸张的大小，缺省的设置为letterpaper。此外，还可以使用a5paper，b5paper，executivepaper 和 legalpaper。

- fleqn: 设置该选项将使数学公式左对齐，而不是中间对齐。
- leqno: 设置该选项将使数学公式的编号防置于左侧。
- titlepage, notitlepage    指定是否在文档标题（document title）后开始一新页。article 文档类缺省不开始新页，而 book 文档类则相反。

- onecolumn, twocolumn: 指定 LaTeX 以单列（one column）或双列（two column）方式排版文档。
- twoside, oneside: 指定 LATEX 排版的文档为双面或单面格式。article 和 report 缺省使用单面格式，而 book 则缺省使用双面格式。需要注意的是该选项仅作用于文档的式样。twoside选项不会通知你的打印机让以得到双面的打印输出。
- openright, openany:   此选项决定新的章是仅仅在右边页（奇数页）还是在下一可用页开始。该选项对 article 文档类不起作用，因为该类中并没有定义“章”（Chapter）。report 类中新的一章开始于下一可用页，而 book 类中新的一章总是开始于右边页。

### 数学公式

```
--mathjax
```

example:

```
- Inline mode $e=mc^2$
- Display mode: $$\frac{df(x)}{dt}=lim_{x \to 0}{\frac{f(x+h)-f(x)}{h}}$$
```


### 导出pandoc默认tex

[参考](http://www.latexstudio.net/archives/9026
)
```
pandoc -D latex > my.tex
```

调整：定位到 % if luatex or xelatex，在 \fi 的下一行（下图白色箭头处）插入如下语句

```
% SUPPORT for Chinese
\usepackage[boldfont,slantfont,CJKchecksingle]{xeCJK}
\usepackage{fontspec,xltxtra,xunicode}
\defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
\punctstyle{quanjiao}
\setCJKmainfont{WenQuanYi Micro Hei}
\setCJKsansfont{KaiTi}
\setCJKmonofont{SimSun}
\defaultfontfeatures{Ligatures=TeX,Scale=MatchLowercase}
```

run

```
# --template=./mytemplate.tex
make latex
```


### install context

- install basicTex,install dir:`cd /usr/local/texlive/2017basic/`
- install

  ````
  sudo tlmgr update --self --all
  ## install context
  sudo tlmgr install collection-context
  ```

- other

  ```
  sudo tlmgr cjk
  ```
