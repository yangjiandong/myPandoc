pandoc - docs
===

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
