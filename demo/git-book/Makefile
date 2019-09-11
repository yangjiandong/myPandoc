TITLE = title.txt
CHAPTERS = output/full_book.markdown
#demo/SpringBootwithRedis.md
TOC = --toc --toc-depth=3
LATEX_CLASS = book

latex:
	pandoc $(CHAPTERS) --pdf-engine=xelatex \
    -V documentclass=$(LATEX_CLASS) \
    -o output/latex.pdf \
    --template=assets/my2.tex

