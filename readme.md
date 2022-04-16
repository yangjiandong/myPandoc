# pandoc2.x - docs

pandoc to docx, html, pdf

```
make docx(pdf) f=xx
```

## 推荐方案

- mindoc 通过 pandoc 导出方案
  - make work-pdf, work-html
- make book
  ```
  sh run-docker.sh
  cd source
  make book
  ```
- make latex，注意风格
  - book, 书籍风格
  - article, 文档
  - latex, 需指定 LATEX_CLASS = book # report, article, book,
  - memoir 有问题
- make article
- make docx_code
- make html_re(html_github)
- make reveal(reveal2)
- 中文 pandoc
  - demo/pandoc
- demo/git-book, use docker one/pandoc

### PanBook

- 最完美的 BOOK 方案
  - [PanBook](https://github.com/annProg/PanBook)，Pandoc LaTeX，Epub 模板，用于生成书籍，幻灯片(beamer)，简历，论文等（cv, thesis, ebook, beamer)，pdf 效果可比印刷
  - 参考 [PanBook-Demo](http://58.216.212.154:10080/yangjiandong/PanBook-Demo) 网上示例项目
  ```shell
  docker run \
    --rm -it \
    -v ${PWD}/:/data \
    one/panbook
  # in container
  cd article
  make
  ```

### ppt, reveal

- reveal.md

### cssprint

- use phantomjs and price, create html,pdf book
- [cssprint-sample's github](https://github.com/Shyujikou/cssprint-sample)
  - use [han.js](https://github.com/ethantw/Han)
- from html to pdf
- demo/cssprint
- ? 没有提供 markdown 格式文档，只能编辑 html

### other markdown tools

- [git book](https://github.com/liuhui998/gitbook), use `rake`, `price` create pdf
- [distsysbook](https://github.com/mixu/distsysbook/), 比较简洁

### sdcamp

- ./sdcamp, use docker, 安装参考 (https://github.com/larrycai/sdcamp)

  - ./mmd2bok
  - use pandoc

    ```
    cd contents
    make pdf
    ```

## 论文

- [重庆大学论文](demo/Academia-Writing-with-Markdown-Using-Pandoc)

## 2022.04.16

- add pandoc-latex-template [Eisvogel template](https://github.com/Wandmalfarbe/pandoc-latex-template)
  - make eisvogel

## 07.20

- 中文字体，`-V CJKmainfont=$(mainfont) \`
  - make book-usefont
  - make ls
- md2pdf，取消 `--template=$template_home/default.latex`
- my2.tex 目录后增加分页

## 07.19

- my2.tex 取消水纹，docker 没有安装
- use [LXGW WenKai/霞鹜文楷](https://github.com/lxgw/LxgwWenKai)

  - in docker container, use `fc-list :lang=zh-cn` show font name
  - font

  ````
    mainfont="LXGWWenKai-Regular.ttf"
    sansfont="LXGWWenKai-Light.ttf"
    monofont="LXGWWenKai-Light.ttf"
    ```
  - make md22pdf f=demo/ls.md
  ````

## 07.12

- znd
  `make znd f=demo/znd/znd-01.md`

## 07.03

- ThinkPython2-CN

## 2021.05.15

- [编写高质量 Python 的九个建议](http://58.216.212.154:10080/yangjiandong/writing_solid_python_code_gitbook.git)

  - writing_solid_python_code_gitbook
    use ebook, no gitbook
    `sh run-docker.sh cd /source/ebook sh mmd2bok`

## 2020.02.13

- one/pandoc:2.x, 中文字体采用 `Songti TC`，也可以动态加载字体
  run-docker.sh

  ```
  -v ${PWD}/font/Songti.ttc:/usr/share/fonts/Songti.ttc \
  ```

## 2020.01.17

- [Wandmalfarbe latext template](https://github.com/Wandmalfarbe/pandoc-latex-template)

  A clean pandoc LaTeX template to convert your markdown files to PDF or LaTeX. It is designed for lecture notes and exercises with a focus on computer science. The template is compatible with pandoc 2.

  感觉这个比较强

## 12.04

- add jgm templates
  - ./jgm-templates
- latex 打水印, templates/my2.tex
- markdown css

  - han.css
  - markdownhere.css, 李笑来提供，可以用于 chrome 插件

## 11.13

- sdcamp

  ```
  \lstset{
  %language=C++,
  basicstyle=\small\ttfamily,
  numbers=left,
  numbersep=5pt,
  xleftmargin=20pt,
  frame=tb,
  framexleftmargin=20pt,
  keywordstyle=\color{blue}
  }
  ```

  多层缩进会出现 ` \begin{lstlisting}[language=```python] `，采用替换脚本

  ````
  find ./chapters.tex -type f -exec sed -i 's/```//g' {} \;
  ````

## 09.11

- demo/git-book

  - rake, prince

## 05.17

- relaxedjs
  - install Chromium, edit .npmrc, `puppeteer_download_host=https://npm.taobao.org/mirrors`
  - install `npm i -g relaxedjs`
  - 可以采用 docker 方案, `one/relaxedjs:node10-stable`
    - use
    - create alias
    ```
    alias relaxed-docker="docker run -it --rm -u $(id -u):$(id -g) -v $(pwd):$(pwd) -w $(pwd) --name relaxed one/relaxedjs:node10-stable $@"
    ```
    - goto examples dir
    ```
    relaxed-docker book.pug
    ```
  - 主要解决 html 演示文档，其他支持的格式不多

## 03.10

- `demo/academic_test.txt`, 采用引用

  make html_github demo/academic_test.txt

- TeX to markdown

  ```
  pandoc -s --bibliography "/home/sd44/xueshu/dingjia/ref/refs.bib" --filter pandoc-citeproc --csl "/home/sd44/.cls/chinese-gb7714-2005-numeric.csl" --metadata link-citations=true --metadata reference-section-title="参考文献" test.tex -o test.md
  ```

## 03.07

### pandoc to docx

- [](https://zhuanlan.zhihu.com/p/49530707)

## 02.28

### github html template

- [Pandoc-Goodies](https://github.com/tajmone/pandoc-goodies)
- run, `make html_github f=demo/my.md`

## 2019.02.26

### use docker, one/pandoc:2.0

- use

  ```
  sh run-docker.sh
  cd source
  make html_github f=demo/xx.md
  ```

- 取消 `PingFang` 字体
- 中文字体 - `WenQuanYi Zen Hei` - zhhei - `AR PL UMing CN` - zhsong - `AR PL UKai CN` - zhkai

## 06.02

### 傲慢与偏见

demo/pandoc-ebook

### 重新整理 sdcamp

- `brew intall multimarkdown`
- 保持原有 文鼎ＰＬ简报宋 字体

      ```
      \setromanfont[Mapping=tex-text,BoldFont=WenQuanYi Micro Hei]{AR PL SungtiL GB}
      ```

## 05.28

### 字体

```
sudo tlmgr install collection-fontsrecommended
brew install fontconfig
fc-list :lang=zh-cn
```

### 更新 pandoc2.x template

### mac 下利用 Pandoc、LaTeX 转换 markdown 成 html,pdf

- [参考](https://my.oschina.net/u/923974/blog/495733)
- `make md22pdf f=demo/pandoc.md`

效果一般

### devs

- 仿 pandoc 文档
- demo/devs

## 05.24

### ieee-pandoc-template, IEEE latex 模板

- [github](https://github.com/stsewd/ieee-pandoc-template)
- demo/ieee-pandoc-template
- 支持中文，专门设置 `-V CJKmainfont=SimSun`

### pandoc-academic-publication, IEEE latex 模板

- [github](https://github.com/claymcleod/pandoc-academic-publication)
- demo/pandoc-academic-publication

### 手工安装 IEEEtran

```
download `https://www.ctan.org/pkg/ieeetran?lang=en`
unzip
sudo cp -R ./IEEEtran /usr/local/texlive/2017basic/texmf-dist/tex/latex
# 更新模板
sudo texhash
```

## 05.23

### [中文竖排](https://www.zhihu.com/question/20544732/answer/376414732)

### [清华大学论文模版 latex](https://github.com/xueruini/thuthesis)

暂时不知道怎么进行 pandoc 处理

```
sudo tlmgl install thuthesis, ctex, environ, trimspaces, zhnumber, newtx, fontaxes, enumitem, cjk-ko, cjk, ntheorem, notoccite
```

没成功

### [国科大学位论文 LaTeX 模板](https://github.com/mohuangrui/ucasthesis)

```
sudo tlmgr install cjkpunct, algorithmicx, algorithms, boondox
```

run: `sh artratex.sh xa`

## 05.19

### resume 个人简历中文字体问题

### demo/pandoc-latex-template

几套模版

### 个人简历的 docker 方案

- [github markdown-resume](https://github.com/there4/markdown-resume)
- docker run

  ```
  docker run \
      -v ${PWD}:/resume \
      there4/markdown-resume \
      md2resume html demo/markdown-resume/sample.md out/
  ```

  - pdf 有点问题，暂时采用进入 docker 容器

  ```
  xvfb-run md2resume pdf demo/markdown-resume/sample.md out/
  ```

- pdf 中文有问题

## 05.18

### error

- `--latex-engine has been removed. Use --pdf-engine instead`

  是 pandoc 升级到 2.2 后发生的问题

- `sudo tlmgr update --self --all`, 提示升级 2018

  ```
  tlmgr: Remote repository is newer than local (2017 < 2018)
  Cross release updates are only supported with
  update-tlmgr-latest(.sh/.exe) --update
  Please see https://tug.org/texlive/upgrade.html for details.
  ```

  误删除，只能重新安装 2018 版

### markdown-latex-boilerplate

- [github](https://github.com/davecap/markdown-latex-boilerplate)

## 05.02

### NUDT 硕士博士论文 Latex 模板

- [github](https://github.com/TomHeaven/nudt_thesis)
- word 模版, demo/nudt/word

## 03.26

解决重庆论文中文字体问题

## 02.10

### rfc 草稿文档制作

[pandoc2rfc](https://github.com/miekg/pandoc2rfc)

## 2018.01.22

### 历史重现评说

ls.md

自动增加回车行 `awk '{print $0 "\n"}' ls.md>ls2.md`

## 09.22

### reveal font

## 07.19

### 中文 pandoc

demo/pandoc

- 提供 html
- 提供 latex to pdf， 需安装

```
sudo tlmgr install titling
sudo tlmgr install lastpage
# tlmgr update --self --repository http://mirrors.aliyun.com/CTAN/systems/texlive/tlnet/
# tlmgr update --all --repository http://mirrors.aliyun.com/CTAN/systems/texlive/tlnet/
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

## 06.16

### [pandoc demo](http://pandoc.org/demos.html)

### simple.md

[完整的 template](https://github.com/lauritzsh/pandoc-markdown-template)

## 06.14

### phD 论文

[phd_thesis_markdown](https://github.com/tompollard/phd_thesis_markdown)

demo/phd_thesis_markdown, 可以用

## 2017.06.12

### 一个不错的样式, 个人简历

- [mszep pandoc resume](https://github.com/mszep/pandoc_resume)
- `demo/mszep.pandoc-templates`

```
make resumepdf
make resumehtml
```

> 中文字体问题解决

- [参考](http://www.annhe.net/article-3169.html)

```
\usemodule[simplefonts]
\setupsimplefonts[size=11pt]

\setcjkmainfont[AdobeSongStd][regularfont={* Light},italicfont={AdobeKaitiStd Regular},boldfont={AdobeHeitiStd Regular},bolditalicfont={AdobeHeitiStd Regular}]
\setcjksansfont[AdobeKaitiStd][boldfont={AdobeHeitiStd Regular},bolditalicfont={AdobeHeitiStd Regular}]
\setcjkmonofont[SimFang][boldfont={AdobeHeitiStd Regular},bolditalicfont={AdobeHeitiStd Regular}]

% 启用中文断行

\setscript[hanzi]

...

\setupbodyfont[11pt, AdobeHeitiStd]
```

install context

- install basicTex,install dir:`cd /usr/local/texlive/2017basic/`
- install

  ```
  sudo tlmgr update --self --all
  ## install context
  sudo tlmgr install collection-context
  ```

- 字体

  - Adobe 的四款字体(AdobeFangsongStd-Regular.otf AdobeHeitiStd-Regular.otf AdobeKaitiStd-Regular.otf AdobeSongStd-Light.otf)
  - `luatools --generate`
  - ? `export OSFONTDIR=/Library/Fonts:/System/Library/Fonts:~/Library/Fonts`

    2017.06.09

---

### 技术 docx 样式

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

## 07.16

[letter](http://mrzool.cc/writing/typesetting-automation/) `demo/letter`

## 07.14

[1](https://github.com/kjhealy/pandoc-templates)

```
make html_mark f=xx
```

## 07.02

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

## sdcamp 增加双列 docx

## 07.01

## markdown 人员简历模板

https://github.com/geekcompany/ResumeSample.git

## DeerResume：在线 MarkDown 简历工具

https://github.com/geekcompany/DeerResume.git

## make html_re 增加 html table 样式处理

```
sed -i '' 's/<table>/<table class="table table-bordered table-condensed">/' out/out.html
```

## 增加 docx 标准模版

```
make docx_base f=xxx
```

## 06.30

## [plain text, papers, pandoc](https://kieranhealy.org/blog/archives/2014/01/23/plain-text/)

[github](https://github.com/kjhealy/workflow-paper)

```
brew install pandoc-crossref
```

demo/workflow-paper

## sdcamp

增加 docx, html 输出

## 06.29

## pnadoc to docx style

[参考](https://github.com/jgm/pandoc-templates/issues/20)

templates/reference.docx

docx 样式主要通过 reference 控制

## 06.27

## 增加 sdcamp 示例

```
cd sdcamp
./mmd2bok
```

[参考](https://github.com/larrycai/kaiyuanbook/wiki)

## 06.25

## md.css

另一个 html 样式

```
make html_md f=xx
```

## 参考一介布衣的样式

左侧带大纲菜单

```
make html_yi f=xx
```

## 2016.06.24

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

## q

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
