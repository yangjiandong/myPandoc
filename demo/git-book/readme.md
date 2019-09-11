git book 社区版
===

构建
---

## prince

```
cd /Users/youngjaindong/workspace/tools/prince-11.3-macosx
sh install.sh
```

## rake

```shell
sudo gem install rake ultraviolet discount rdiscount builder
rake html
rake pdf
```

## pandoc

use docker one/pandoc:2.0

```shell
sh run-docker.sh
cd source
make
```