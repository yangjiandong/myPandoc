# docker run \
#   -v $(pwd)/works:/source \
#   one/pandoc:1.9 \
#   -f markdown -t html5 \
#   readme.md \
#   -o myfile.html
#   -v ${PWD}/font/Songti.ttc:/usr/share/fonts/Songti.ttc \
docker run \
  --rm -it \
  -v ${PWD}:/source \
  -v ${PWD}/font/PingFang.ttc:/usr/share/fonts/PingFang.ttc \
  one/pandoc:2.x \
  /bin/bash
