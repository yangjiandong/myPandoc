# use pandoc 2.x
BUILD = build
BOOKNAME = my-book
TITLE = title.txt
METADATA = metadata.xml
CHAPTERS2 = ch01.md ch02.md
CHAPTERS = works/01.md works/02.md
# CHAPTERS = demo/my.md demo/devs/devs.md demo/SpringBootwithRedis.md
#demo/pandoc/pandoc.markdown
#demo/SpringBootwithRedis.md
TOC = --toc --toc-depth=3
COVER_IMAGE = cover.jpg
LATEX_CLASS = article
# report, article, book, memoir

#cat 00*.md > xxx.md

md22pdf:${f}
	./md2pdf ${f} -o out/md2.pdf

work-pdf:
	pandoc $(CHAPTERS) --pdf-engine=xelatex \
	-o out/work.pdf \
	--template=templates/my2.tex

book:
	pandoc $(TOC) $(TITLE) $(CHAPTERS) --pdf-engine=xelatex \
	-o out/book.pdf \
	--template=templates/my2.tex

latex:
	pandoc $(TOC) $(TITLE) $(CHAPTERS) --pdf-engine=xelatex \
	-V documentclass=$(LATEX_CLASS) \
	-V papersize=a4paper \
	-o out/$(LATEX_CLASS).pdf \
	--template=./mytemplate.tex

# --template=./mytemplate.tex
# --template=templates/my.tex

article:
	pandoc $(TOC) $(TITLE) $(CHAPTERS) --pdf-engine=xelatex  \
	-o out/article_bysj.pdf \
	--template=templates/bysj2.latex

ls:
	pandoc --toc --toc-depth=3  demo/ls.md --pdf-engine=xelatex \
	-o out/ls.pdf \
	--template=templates/my2.tex

ls_epub:
	pandoc -o out/ls.epub --toc --toc-depth=3 demo/ls.md \
	--epub-metadata=metadata.xml --css=style/epub.css

hisnew:
	pandoc demo/his_new.md -o out/demo/his_new_reveal.html \
	-t revealjs -s -V theme=night \
	--template=templates/reveal/reveal.js/template-revealjs.html \
	-i

hisupdate:
	pandoc demo/his_update.md -o out/demo/his_update_reveal.html \
	-t revealjs -s -V theme=night \
	--template=templates/reveal/reveal.js/template-revealjs.html \
	-i

html_github:${f}
	pandoc ${f} -t html5 -o out/out_github.html \
	--toc --toc-depth 4 \
	-s --self-contained \
	--metadata pagetitle="github" \
	--template=templates/GitHub.html5

html_re:${f}
	pandoc ${f} -t html5 -o out/out.html \
	--toc --toc-depth 2 \
	-s --self-contained \
	--template=templates/pm-template
	# add style to table
	sed -i '' 's/<table>/<table class="table table-bordered table-condensed">/' out/out.html

#
reveal3:${f}
	pandoc ${f} -o out/reveal.js-3.8.0/out_reveal3.html \
		-t revealjs -s -V theme=night \
		-V transition=slide \
		--template=templates/reveal/reveal.js-3.8.0/template.html \
		-i

reveal:${f}
	pandoc ${f} -o out/demo/out_reveal.html \
		-t revealjs -s -V theme=night \
		--self-contained \
		--resource-path=templates/reveal/reveal.js \
		--template=templates/reveal/reveal.js/template-revealjs.html \
		-i

reveal2:${f}
	pandoc -t html5 -s --template=templates/reveal/template-revealjs-2.html \
    	--standalone --section-divs \
    	--variable theme="night" \
    	--variable transition="cube" \
    	-o out/demo/out_reveal2.html ${f}

docx:${f}
	pandoc -r markdown -w docx --csl=csl/chicago-author-date.csl ${f} --output=out/out.docx

docx_code:${f}
	pandoc -r markdown -w docx --csl=csl/chicago-author-date.csl \
	--reference-doc=templates/code.docx \
	${f} \
	--output=out/out_code.docx

docx_base:${f}
	pandoc -r markdown -w docx --csl=csl/chicago-author-date.csl --reference-doc=templates/base.docx ${f} --output=out/out_base.docx

docx_re:${f}
	pandoc -r markdown -w docx --csl=csl/chicago-author-date.csl --reference-doc=templates/reference.docx ${f} --output=out/out_re.docx

docx_re2:${f}
	pandoc -r markdown -w docx -s -S --csl=csl/chicago-author-date.csl --reference-docx=templates/my.docx ${f} --output=out/out.docx

html_report:${f}
	pandoc ${f} -t html5 -o out/out.html --toc --toc-depth 2 --template=templates/report
	# add style to table
	# sed -i '' 's/<table>/<table class="table table-bordered table-condensed">/' out/out.html

html_mark:${f}
	pandoc ${f} -r markdown+simple_tables+table_captions+yaml_metadata_block -w html \
		--template=templates/html.template --css=style/marked/kultiad-serif.css \
		--filter pandoc-citeproc --csl=csl/apsa.csl --bibliography=bib/socbib-pandoc.bib -o out/out.html

bootstrap:${f}
	pandoc ${f} -o out/out.html --template templates/bootstrap-template/template.html --css templates/bootstrap-template/template.css --self-contained --toc --toc-depth 2
	sed -i '' 's/<table>/<table class="table table-bordered table-condensed">/' out/out.html

html_yi:${f}
	pandoc ${f} -t html5 -o out/out.html --toc --toc-depth 2 --template=templates/template

slide:${f}
	pandoc ${f} -o out/${f}.pdf -t beamer --pdf-engine=xelatex --template=./mytemplate.tex

pdf:${f}
	pandoc ${f} -o out/out.pdf  --pdf-engine=xelatex --template=./mytemplate.tex

docx2:${f}
	pandoc -r markdown -w docx -s -S --bibliography=Thesis.bib --csl=csl/chicago-author-date.csl ${f} --output=out/out.docx

html:${f}
	pandoc ${f} -o out/out.html --template templates/default.html --self-contained --toc --toc-depth 2

html_md:${f}
	pandoc ${f} -o out/out.html -c style/md.css --template templates/default.html --self-contained --toc --toc-depth 2

html5:${f}
	pandoc ${f} -o out/out.html --template templates/default.html5 --self-contained --toc --toc-depth 2

html_re2:${f}
	pandoc ${f} -t html5 -o out/out.html --toc --template=templates/pm2-template

epub:${f}
	pandoc -o out/out.epub title.txt ${f} --epub-cover-image=cover.jpg --epub-metadata=metadata.xml --toc --toc-depth=2 --epub-stylesheet=style/epub.css

dzslide:
	pandoc ${f} -o out/demo/out_dzslide.html \
		-t dzslides -s

resumepdf:
	pandoc --standalone --template style/style_chmduquesne.tex \
	--from markdown --to context \
	-V papersize=A4 \
	-o out/resume.tex demo/resume.md; \
	context out/resume.tex

resumehtml:
	pandoc --standalone -H style/style_chmduquesne.css \
        --from markdown --to html \
        -o out/resume.html demo/resume.md

resumedocx: resume.md
	pandoc -s -S resume.md -o resume.docx

resumertf: resume.md
	pandoc -s -S resume.md -o resume.rtf

all:${f} slide pdf reveal
	echo "ok"

print:${f}
	echo ${f}
