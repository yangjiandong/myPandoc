pandoc - docs
===

pandoc to docx,html,pdf

```
make docx(pdf) f=xx
```

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
