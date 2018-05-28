#!/bin/bash

pandoc devs.md -t html5 -o ../../out/devs-zhtw.html --toc --template=pm-template
pandoc devs.md -o ../../out/devs-zhtw.pdf --toc --template=pm-template --pdf-engine=xelatex -V mainfont='LiHei Pro'

# add style to table
sed -i '' 's/<table>/<table class="table table-bordered table-condensed">/' ../../out/devs-zhtw.html
