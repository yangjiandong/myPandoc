
reveal
---

###  文件说明

打包输出路径 `out\demo`, reveal 样式 `reveal.js`, 拷贝到 `out\demo`

### font

no use google font `https://fonts.googleapis.com`

```
http://fonts.useso.com
```

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

另外一套 reveal.js
---

[参考](https://gist.github.com/aaronwolen/5017084)

template-revealjs-2.html

```
pandoc -t html5 -s --template=template-revealjs-2.html \
    --standalone --section-divs \
    --variable theme="sky" \
    --variable transition="cube" \
    -o slides.html slides.md
```

or

```
make reveal2 f=demo/pandoc_setup.md
```

transition: default/cube/page/concave/zoom/linear/fade/none

如果slides里有公式，需要在编译命令里加上--mathml选项

