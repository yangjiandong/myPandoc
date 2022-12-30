pandoc --toc --toc-depth=3 title.txt 04.md 02.md 03.md --pdf-engine=xelatex \
    --template=my.tex \
    -V mainfont="Georgia" \
    -o dev3.pdf
