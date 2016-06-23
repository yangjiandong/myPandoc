slide:${f}
	pandoc ${f} -o out/${f}.pdf -t beamer --latex-engine=xelatex --template=./mytemplate.tex


pdf:${f}
	pandoc ${f} -o out/${f}.pdf  --latex-engine=xelatex --template=./mytemplate.tex

reveal:${f}
	pandoc ${f} -o out/${f}.html -t revealjs -s -V theme=night --template=template-revealjs.html

docx:${f}
	pandoc -r markdown -w docx -s -S --csl=csl/chicago-author-date.csl ${f} --output=out/out.docx

docx2:${f}
	pandoc -r markdown -w docx -s -S --bibliography=Thesis.bib --csl=csl/chicago-author-date.csl ${f} --output=out/out.docx


all:${f} slide pdf reveal
	echo "ok"


print:${f}
	echo ${f}
