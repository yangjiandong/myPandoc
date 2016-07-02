pandoc - docs
===

pandoc to docx,html,pdf

```
make docx(pdf) f=xx
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
