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
  -v ${PWD}/klee/LXGWWenKai-Bold.ttf:/usr/share/fonts/LXGWWenKai-Bold.ttf \
  -v ${PWD}/klee/LXGWWenKai-Light.ttf:/usr/share/fonts/LXGWWenKai-Light.ttf \
  -v ${PWD}/klee/LXGWWenKai-Regular.ttf:/usr/share/fonts/LXGWWenKai-Regular.ttf \
  one/pandoc:2.xx \
  /bin/bash
