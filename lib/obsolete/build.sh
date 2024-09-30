cd ~/projects/tree
cd ./_/c/src

gcc \
  -fverbose-asm \
  -save-temps \
  -o /tmp/pro.bin \
  -Wall -Wextra \
  -Og \
  -ggdb \
  3.2.basic.strings.c 3.basic.c

sleep 1

/tmp/pro.bin
