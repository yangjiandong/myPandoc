pandoc - docs
===

2016.06.24
---

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
