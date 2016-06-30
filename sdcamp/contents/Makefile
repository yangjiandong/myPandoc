BUILD = build
BOOKNAME = my-book
TITLE = title.txt
METADATA = metadata.xml
CHAPTERS = 0-preface1-preface.markdown 0-preface2-changes.markdown \
		   0-preface3-acknowledge.markdown \
		   1-chapter1-agile-scrum.markdown \
		   1-chapter2-git-gerrit.markdown \
		   1-chapter3-ci.markdown \
		   1-chapter4-java.markdown \
		   1-chapter5-sbe.markdown \
		   1-chapter6-cucumber.markdown \
		   1-chapter7-workshop.markdown \
		   2-appendix1-sample.markdown \
		   2-appendix2-cc2git.markdown
TOC = --toc --toc-depth=2
COVER_IMAGE = latex/img/cover.pdf
LATEX_CLASS = book
# report

latex: 
	pandoc $(TOC) $(TITLE) $(CHAPTERS) --latex-engine=xelatex -V documentclass=$(LATEX_CLASS) -o out/latex.pdf --template=./mytemplate.tex

docx:
	pandoc -r markdown -w docx -s -S --csl=csl/chicago-author-date.csl $(TOC) $(CHAPTERS) --output=out/out.docx

html:
	pandoc $(TOC) $(CHAPTERS) -t html5 -o out/out.html --toc --toc-depth 2 --template=templates/pm-template

bootstrap:${f}
	pandoc ${f} -o out/out.html --template templates/bootstrap-template/template.html --css templates/bootstrap-template/template.css --self-contained --toc --toc-depth 2

html_yi:${f}
	pandoc ${f} -t html5 -o out/out.html --toc --toc-depth 2 --template=templates/template

slide:${f}
	pandoc ${f} -o out/${f}.pdf -t beamer --latex-engine=xelatex --template=./mytemplate.tex

pdf:${f}
	pandoc ${f} -o out/out.pdf  --latex-engine=xelatex --template=./mytemplate.tex

reveal:${f}
	pandoc ${f} -o out/out_reveal.html -t revealjs -s -V theme=night --template=template-revealjs.html

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
