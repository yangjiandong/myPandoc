
# ppt, reveal 方案

- keynote
  - demo/reveal/keynote
- remote 方案
  - [](https://github.com/dmitry-korolev/remeal)
- [中文参考](https://vxhly.github.io/archives/8bdf06de.html)
- [reveal 案例](https://github.com/hakimel/reveal.js/wiki/Example-Presentations)
- demo, reveal3 效果不是很好

  ```
  make reveal f=demo/reveal/demo.md
  make reveal3 f=demo/reveal/demo.md
  ```

  pandoc -t revealjs -s \
	   -V revealjs-url=https://cdn.jsdelivr.net/reveal.js/3.0.0 \
       ./demo/reveal/demo.md  -o my_slides.html


  pandoc -t revealjs -s \
	   -V revealjs-url=https://cdn.bootcss.com/reveal.js/3.8.0 \
     -V theme=beige \
       ./demo/reveal/demo.md  -o my_slides.html

  pandoc demo/reveal/demo.md -o out/demo/out_reveal.html \
		-t revealjs -s -V theme=night \
		--template=templates/reveal/template-revealjs.html \
		-i


### style

copy templates/reveal/reveal.js to out dir

### 提示板

按 s 触发；增加小抄：

```
<aside class="notes">

  * 这里是提示1
  * 这里是提示2

</aside>
```

> 由于浏览器的本地安全策略，需使用该功能的幻灯片必须在HTTP服务器上运行

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

transition: default/cube/page/concave/zoom/linear/fade/none

如果slides里有公式，需要在编译命令里加上--mathml选项

### reveal font

updat `fonts.useso.com` to `fonts.lug.ustc.edu.cn`

reveal.js/theme
- begin.css
- default.css
- moon.css
- night.css
- simple.css
- sky.css
- solarized.css

直接改造 night.css 引用的字体，下载到本地

### run in http server

```
python3 -m http.server
```

in http server mode, use note, key `s`

### tip

逐条显示

```
::: incremental

- Eat spaghetti
- Drink wine

:::
```

小抄提示

```
::: notes

- It can contain Markdown
- like this list
- 技术架构方案，需验证

:::
```
