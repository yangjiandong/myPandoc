slide:${f}
	pandoc ${f} -o out/${f}.pdf -t beamer --latex-engine=xelatex --template=./mytemplate.tex


pdf:${f}
	pandoc ${f} -o out/${f}.pdf  --latex-engine=xelatex --template=./mytemplate.tex

reveal:${f}
	pandoc ${f} -o out/${f}.html -t revealjs -s -V theme=beige --template=template-revealjs.html

all:${f} slide pdf reveal
	echo "ok"


print:${f}
	echo ${f}
