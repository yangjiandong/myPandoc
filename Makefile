BUILD = build
BOOKNAME = my-book
TITLE = title.txt
METADATA = metadata.xml
CHAPTERS2 = ch01.md ch02.md
CHAPTERS = demo/my.md
TOC = --toc --toc-depth=2
COVER_IMAGE = cover.jpg
LATEX_CLASS = book
# report

latex: 
	pandoc $(TOC) $(TITLE) $(CHAPTERS) --latex-engine=xelatex -V documentclass=$(LATEX_CLASS) -o out/latex.pdf --template=./mytemplate.tex

docx:${f}
	pandoc -r markdown -w docx -s -S --csl=csl/chicago-author-date.csl ${f} --output=out/out.docx

docx_code:${f}
	pandoc -r markdown -w docx -s -S --csl=csl/chicago-author-date.csl --reference-docx=templates/code.docx ${f} --output=out/out.docx

docx_base:${f}
	pandoc -r markdown -w docx -s -S --csl=csl/chicago-author-date.csl --reference-docx=templates/base.docx ${f} --output=out/out.docx

docx_re:${f}
	pandoc -r markdown -w docx -s -S --csl=csl/chicago-author-date.csl --reference-docx=templates/reference.docx ${f} --output=out/out.docx

docx_re2:${f}
	pandoc -r markdown -w docx -s -S --csl=csl/chicago-author-date.csl --reference-docx=templates/my.docx ${f} --output=out/out.docx

html_re:${f}
	pandoc ${f} -t html5 -o out/out.html --toc --toc-depth 2 --template=templates/pm-template
	# add style to table
	sed -i '' 's/<table>/<table class="table table-bordered table-condensed">/' out/out.html

html_report:${f}
	pandoc ${f} -t html5 -o out/out.html --toc --toc-depth 2 --template=templates/report
	# add style to table
	# sed -i '' 's/<table>/<table class="table table-bordered table-condensed">/' out/out.html

html_mark:${f}
	pandoc ${f} -r markdown+simple_tables+table_captions+yaml_metadata_block -w html -S \
		--template=templates/html.template --css=style/marked/kultiad-serif.css \
		--filter pandoc-citeproc --csl=csl/apsa.csl --bibliography=bib/socbib-pandoc.bib -o out/out.html

bootstrap:${f}
	pandoc ${f} -o out/out.html --template templates/bootstrap-template/template.html --css templates/bootstrap-template/template.css --self-contained --toc --toc-depth 2 
	sed -i '' 's/<table>/<table class="table table-bordered table-condensed">/' out/out.html

html_yi:${f}
	pandoc ${f} -t html5 -o out/out.html --toc --toc-depth 2 --template=templates/template

slide:${f}
	pandoc ${f} -o out/${f}.pdf -t beamer --latex-engine=xelatex --template=./mytemplate.tex

pdf:${f}
	pandoc ${f} -o out/out.pdf  --latex-engine=xelatex --template=./mytemplate.tex

reveal:${f}
	pandoc ${f} -o out/demo/out_reveal.html -t revealjs -s -V theme=night --template=template-revealjs.html

reveal2:${f}
	pandoc -t html5 -s --template=template-revealjs-2.html \
    	--standalone --section-divs \
    	--variable theme="night" \
    	--variable transition="page" \
    	-o out/demo/out_reveal.html ${f}

docx2:${f}
	pandoc -r markdown -w docx -s -S --bibliography=Thesis.bib --csl=csl/chicago-author-date.csl ${f} --output=out/out.docx

html:${f}
	pandoc ${f} -o out/out.html --template templates/default.html --self-contained --toc --toc-depth 2

html_md:${f}
	pandoc ${f} -o out/out.html -c style/md.css --template templates/default.html --self-contained --toc --toc-depth 2

html5:${f}
	pandoc ${f} -o out/out.html --template templates/default.html5 --self-contained --toc --toc-depth 2

html_re2:${f}
	pandoc ${f} -t html5 -o out/out.html --toc --smart --template=templates/pm2-template

epub:${f}
	pandoc -o out/out.epub title.txt ${f} --epub-cover-image=cover.jpg --epub-metadata=metadata.xml --toc --toc-depth=2 --epub-stylesheet=style/epub.css

all:${f} slide pdf reveal
	echo "ok"

print:${f}
	echo ${f}
