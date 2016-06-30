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
	pandoc $(TOC) $(TITLE) $(CHAPTERS) --latex-engine=xelatex -V documentclass=$(LATEX_CLASS) -o out/latex.pdf --template=templates/mytemplate.tex

docx:
	pandoc -r markdown -w docx -s -S --csl=csl/chicago-author-date.csl $(TOC) $(CHAPTERS) --output=out/out.docx

html:
	pandoc $(TOC) $(CHAPTERS) -t html5 -o out/out.html --toc --toc-depth 2 --template=templates/pm-template

pdf:${f}
	pandoc $(TOC) $(TITLE) $(CHAPTERS)  -o out/out.pdf  --latex-engine=xelatex --template=templates/mytemplate.tex

epub:
	pandoc -o out/out.epub title.txt $(TOC) $(TITLE) $(CHAPTERS) --epub-cover-image=cover.jpg --epub-metadata=metadata.xml --epub-stylesheet=style/epub.css


