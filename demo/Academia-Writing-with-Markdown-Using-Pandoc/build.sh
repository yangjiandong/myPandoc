pandoc --filter pandoc-crossref \
    --filter pandoc-citeproc \
    --biblio reference.bib \
    --csl chinese-gb7714-2005-numeric.csl \
    --latex-engine=xelatex \
    --template=cqu.latex \
    main.md \
    -o main.pdf
