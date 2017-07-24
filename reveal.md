
reveal
---

###  文件说明

打包输出路径 `out\demo`, reveal 样式 `reveal.js`, 拷贝到 `out\demo`

### TeX公式渲染方式

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

另外一套 reveal.js
---

[参考](https://gist.github.com/aaronwolen/5017084)

template-revealjs-2.html

````
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

