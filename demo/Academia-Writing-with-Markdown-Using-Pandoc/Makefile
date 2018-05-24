doc:
	pandoc --filter pandoc-crossref \
    --filter pandoc-citeproc \
    --biblio reference.bib \
    --csl chinese-gb7714-2005-numeric.csl \
    --pdf-engine=xelatex \
    --template=cqu.latex \
    main.md \
    -o main.docx

pdf:
	pandoc --filter pandoc-crossref \
    --filter pandoc-citeproc \
    --biblio reference.bib \
    --csl chinese-gb7714-2005-numeric.csl \
    --pdf-engine=xelatex \
    --template=cqu.latex \
    main.md \
    -o main.pdf
