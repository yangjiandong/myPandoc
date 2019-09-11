# docker run \
#   -v $(pwd)/works:/source \
#   one/pandoc:1.9 \
#   -f markdown -t html5 \
#   readme.md \
#   -o myfile.html
docker run \
  --rm -it \
  -v ${PWD}:/source \
  one/pandoc:2.0 \
  /bin/bash
