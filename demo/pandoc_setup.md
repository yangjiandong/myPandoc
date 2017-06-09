% MAC下利用pandoc+markdown来写slide
% 胡浩源 haoyuan.huhy@gmail.com
% 2015年1月16

# GOTO slider

## WHY

写一份markdown文件， 根据需要可以生成:

- slide pdf
- document pdf
- slide html

<aside class="notes">

  * 这里是提示1
  * 这里是提示2

</aside>

# Begin

## 安装

```shell
brew install pandoc
```

## 源码

```markdown
# today

## morning
- I want to have breakfast

## afternoon
- I want to have lunch
```

## PDF

```shell
pandoc -D latex > mytemplate.tex
```

```shell
pandoc test.md -o test.pdf -t beamer 
--latex-engine=xelatex 
--template=mytemplate.tex
```

直接执行是不成功的。

## 增加中文字体配置
修改mytemplate.tex
```tex
\ifxetex
\usepackage{hyperref}
\usepackage{fontspec,xltxtra,xunicode}
\defaultfontfeatures{Mapping=tex-text}
\usepackage{xeCJK}
\setCJKmainfont[BoldFont = Hiragino Sans GB W6]{Hiragino Sans GB W3}
\setCJKsansfont[BoldFont=SimHei]{SimHei}
\setCJKmonofont{SimHei}
\else
\usepackage[unicode=true]{hyperref}
\fi
```

## html5

- DZSlides
- Slidy
- S5
- Slideous
- reveal.js

## reveal.js

```shell
git clone https://github.com/hakimel/reveal.js

pandoc slides.md -o slides.html -t revealjs 
-s -V theme=beige
```

这样是执行不成功的

## fix

不要用reveal 3.0， 用reveal.js 2.6

## reveal.js背景

- default：（默认）深灰色背景，白色文字
- beige：米色背景，深色文字
- sky：天蓝色背景，白色细文字
- night：黑色背景，白色粗文字
- serif：浅色背景，灰色衬线文字
- simple：白色背景，黑色文字
- solarized：奶油色背景，深青色文字

## Makefile

利用makefile来自动化构建
```shell
slide:${f}
    pandoc ${f} -o pdf_slide/${f}.pdf -t beamer --latex-engine=xelatex --template=./mytemplate.tex

pdf:${f}
    pandoc ${f} -o pdf_doc/${f}.pdf  --latex-engine=xelatex --template=./mytemplate.tex

reveal:${f}
    pandoc ${f} -o html_slide/${f}.html -t revealjs -s -V theme=beige

all:${f} slide pdf reveal
    echo "ok"

print:${f}
    echo ${f}
```

## make usage

```shell
make slide f=pandoc_setup.md 
make pdf f=pandoc_setup.md 
make reveal f=pandoc_setup.md 
```


## 文件结构
```shell
.
├── Makefile
├── html_slide
│   ├── pandoc_setup.md.html
│   └── reveal.js
├── mytemplate.tex
├── pandoc_setup.md
├── pdf_doc
│   └── pandoc_setup.md.pdf
└── pdf_slide
    └── pandoc_setup.md.pdf
```

## thanks

[gitlab地址](https://github.com/haoyuan-hu/markdown_slide.git)
