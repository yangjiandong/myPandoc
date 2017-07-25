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

参考 reveal.js

07.19
---

### 中文pandoc

demo/pandoc

- 提供 html
- 提供 latex to pdf， 需安装

```
sudo tlmgr install titling
sudo tlmgr install lastpage
```

### fc-list show fonts

```
brew install fontconfig
```

use

```
fc-list :lang=zh-cn
or
fc-list :outline -f "%{family}\n"
```

06.16
---

### [pandoc demo](http://pandoc.org/demos.html)

### simple.md

[完整的template](https://github.com/lauritzsh/pandoc-markdown-template)

06.14
---

### phD 论文

[phd_thesis_markdown](https://github.com/tompollard/phd_thesis_markdown)

demo/phd_thesis_markdown, 可以用

2017.06.12
---

### 一个不错的样式, 个人简历

- [mszep pandoc resume](https://github.com/mszep/pandoc_resume)
- `demo/mszep.pandoc-templates`

```
make resume.pdf
make resume.html
```

> 中文字体问题没解决

install context

- install basicTex,install dir:`cd /usr/local/texlive/2017basic/`
- install

  ````
  sudo tlmgr update --self --all
  ## install context
  sudo tlmgr install collection-context
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
