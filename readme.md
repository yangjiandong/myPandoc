pandoc - docs
===

pandoc to docx,html,pdf

```
make docx(pdf) f=xx
```

推荐方案
- make latex
- make docx_code
- make html_re
- make reveal

reveal
---

控制TeX公式渲染方式的选项有`--mathml，--webtex，--mathjax和--latexmathml`。（Chrome和Firefox均支持MathML）

控制代码高亮风格的选项有：

- --highlight-style pygments
- --highlight-style kate
- --highlight-style monochrome
- --highlight-style espresso
- --highlight-style haddock
- --highlight-style tango
- --highlight-style zenburn

### theme

- default：（默认）深灰色背景，白色文字
- beige：米色背景，深色文字
- sky：天蓝色背景，白色细文字
- night：黑色背景，白色粗文字
- serif：浅色背景，灰色衬线文字
- simple：白色背景，黑色文字
- solarized：奶油色背景，深青色文字

### 提示板

按 s 触发；增加小抄：

```
<aside class="notes">

  * 这里是提示1
  * 这里是提示2

</aside>
```

> 由于浏览器的本地安全策略，需使用该功能的幻灯片必须在HTTP服务器上运行

### 分级

`--slide-level` 选项默认2

example

```
# In the morning
 
## Getting up
 
- Turn off alarm
- Get out of bed
```

所以1级标题渲染为水平方向的幻灯片，2级标题渲染为竖直方向的幻灯片

latex
---

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

数学公式
---

```
--mathjax
```

example:

```
- Inline mode $e=mc^2$
- Display mode: $$\frac{df(x)}{dt}=lim_{x \to 0}{\frac{f(x+h)-f(x)}{h}}$$
```

06.14
---

### phD 论文

[phd_thesis_markdown](https://github.com/tompollard/phd_thesis_markdown)

demo/phd_thesis_markdown

可以用

2017.06.12
---

### 一个不错的样式

[mszep pandoc resume](https://github.com/mszep/pandoc_resume)

```
make resume.pdf
make resume.html
```

### 重庆大学论文

[Academia-Writing-with-Markdown-Using-Pandoc](https://github.com/zl810881283/Academia-Writing-with-Markdown-Using-Pandoc)

demo/Academia-Writing-with-Markdown-Using-Pandoc

install

```
brew install pandoc-crossref 
brew install pandoc-citeproc
```

pdf

```
pandoc --filter pandoc-crossref --filter pandoc-citeproc --biblio reference.bib --csl chinese-gb7714-2005-numeric.csl --latex-engine=xelatex --template=cqu.latex main.md -o main.pdf
```

> 字体问题没解决,已安装了windows字体

```
l.68 ...bold\zhttfont{[simfang.ttf]}{[simkai.ttf]}
```

docx

```
pandoc --filter pandoc-crossref --filter pandoc-citeproc --biblio reference.bib --csl chinese-gb7714-2005-numeric.csl --latex-engine=xelatex  main.md -o main.docx
```

2017.06.09
---

### 另外一套 reveal.js

[参考](https://gist.github.com/aaronwolen/5017084)

template-revealjs-2.html

````
pandoc -t html5 -s --template=template-revealjs-2.html \
    --standalone --section-divs \
    --variable theme="sky" \
    --variable transition="linear" \
    -o slides.html slides.md
```

or

```
make reveal2 f=demo/pandoc_setup.md
```

transition: default/cube/page/concave/zoom/linear/fade/none

如果slides里有公式，需要在编译命令里加上--mathml选项

### 技术docx 样式

templates/code.docx

```
docx_code:${f}
    pandoc -r markdown -w docx -s -S --csl=csl/chicago-author-date.csl --reference-docx=templates/code.docx ${f} --output=out/out.docx
```

### 一个毕业设计模版

pandoc-LaTeX.docx or bysj.latex

```
latex_bysj: 
    pandoc $(TOC) $(TITLE) $(CHAPTERS) --latex-engine=xelatex  \
    -o out/latex.pdf\
    --template=templates/bysj.latex
```

### dzslides

pandoc 默认幻灯片

07.16
---

[letter](http://mrzool.cc/writing/typesetting-automation/) `demo/letter`

07.14
---

[1](https://github.com/kjhealy/pandoc-templates)

```
make html_mark f=xx
```

07.02
---

## docx pagebreak

[use haskell for mac](https://ghcformacosx.github.io)

[参考](http://permalink.gmane.org/gmane.text.pandoc/12833)
[google group](https://groups.google.com/forum/#!topic/pandoc-discuss/FzLrhk0vVbU)

另外的方式是通过`reference.docx` 设计分页,还没测试

## Converting a web page to markdown:

```
pandoc -s -r html http://www.gnu.org/software/make/ -o example12.text
```

[pandoc demo](http://pandoc.org/demos.html)

## sdcamp 增加双列docx

07.01
---

## markdown 人员简历模板

https://github.com/geekcompany/ResumeSample.git

## DeerResume：在线MarkDown简历工具

https://github.com/geekcompany/DeerResume.git

## make html_re 增加 html table 样式处理

```
sed -i '' 's/<table>/<table class="table table-bordered table-condensed">/' out/out.html
```

## 增加docx 标准模版

```
make docx_base f=xxx
```

06.30
---

## [plain text, papers, pandoc](https://kieranhealy.org/blog/archives/2014/01/23/plain-text/)

[github](https://github.com/kjhealy/workflow-paper)

```
brew install pandoc-crossref
```

demo/workflow-paper

## sdcamp

增加 docx, html 输出

06.29
---

## pnadoc to docx style

[参考](https://github.com/jgm/pandoc-templates/issues/20)

templates/reference.docx

docx 样式主要通过 reference 控制

06.27
--

## 增加 sdcamp 示例

```
cd sdcamp
./mmd2bok
```

[参考](https://github.com/larrycai/kaiyuanbook/wiki)

06.25
---

## md.css

另一个html 样式

```
make html_md f=xx
```

## 参考一介布衣的样式

左侧带大纲菜单

```
make html_yi f=xx
```

2016.06.24
---

## latex pdf

不指定文件，需更改文件配置

```
make latex
```

可以生成效果不错的排版书

## epub

`make epub f=xx`

## reveal

输出需引用 `out/demo` 下 `css,js`

## html template: bootstrap

`make bootstrap f=xx`

create
---

```
make slide f=pandoc_setup.md 
make pdf f=pandoc_setup.md 
make reveal f=pandoc_setup.md
```

error:

```
! Undefined control sequence.
l.196 \tightlist

pandoc: Error producing PDF from TeX source
```

解决, mytemplate.tex

```
\newcommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}
```
