html-default:
	pandoc --filter pandoc-citeproc --biblio paper.bib -t html5 -c assets/fonts/cm/cm.css -c assets/css/academic-pub.css --template assets/templates/academic-html5.template --highlight-style pygments --toc --standalone \
	-o out/paper.html paper.md

html-ieee:
	pandoc --filter pandoc-citeproc --biblio paper.bib -t html5 -c assets/fonts/cm/cm.css -c assets/css/academic-pub.css -c assets/css/ieee.css --template assets/templates/academic-html5.template --highlight-style pygments --toc --standalone --csl=assets/csl/ieee.csl \
	-o out/paper-ieee.html paper.md

pdf-ieee:
	pandoc --filter pandoc-citeproc --biblio paper.bib \
	--pdf-engine=xelatex \
	--highlight-style pygments \
	--standalone \
	--variable CJKmainfont=LXGWWenKai-Regular.ttf \
	--variable documentclass=assets/latex/ieee \
	--csl=assets/csl/ieee.csl \
	-o out/paper-ieee.pdf paper.md

pdf-article:
	pandoc --filter pandoc-citeproc --biblio paper.bib \
	-t latex --highlight-style pygments \
	--standalone --variable documentclass=article \
	--variable biblio-style=acm \
	-o out/paper-article.pdf paper.md

pdf-memoir:
	pandoc --filter pandoc-citeproc --biblio paper.bib -t latex --highlight-style pygments --standalone --variable documentclass=memoir --variable biblio-style=acm \
	-o out/paper-memoir.pdf paper.md


.PHONY:
clean:
	rm -f out/*.*
