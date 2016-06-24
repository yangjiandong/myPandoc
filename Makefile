slide:${f}
	pandoc ${f} -o out/${f}.pdf -t beamer --latex-engine=xelatex --template=./mytemplate.tex


pdf:${f}
	pandoc ${f} -o out/out.pdf  --latex-engine=xelatex --template=./mytemplate.tex

reveal:${f}
	pandoc ${f} -o out/out_reveal.html -t revealjs -s -V theme=night --template=template-revealjs.html

docx:${f}
	pandoc -r markdown -w docx -s -S --csl=csl/chicago-author-date.csl ${f} --output=out/out.docx

docx2:${f}
	pandoc -r markdown -w docx -s -S --bibliography=Thesis.bib --csl=csl/chicago-author-date.csl ${f} --output=out/out.docx

bootstrap:${f}
	pandoc ${f} -o out/out.html --template templates/bootstrap-template/template.html --css templates/bootstrap-template/template.css --self-contained --toc --toc-depth 2

html:${f}
	pandoc ${f} -o out/out.html --template templates/default.html --self-contained --toc --toc-depth 2

html5:${f}
	pandoc ${f} -o out/out.html --template templates/default.html5 --self-contained --toc --toc-depth 2

epub:${f}
	pandoc -o out/out.epub title.txt ${f} --epub-cover-image=cover.jpg --epub-metadata=metadata.xml --toc --toc-depth=2 --epub-stylesheet=style/epub.css

all:${f} slide pdf reveal
	echo "ok"


print:${f}
	echo ${f}