
docker run \
  --rm -it \
  -v ${PWD}:/source \
  -p 4000:4000 \
  one/pandoc:2.x \
  /bin/bash