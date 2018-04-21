#!/bin/sh
cd sof.git
./autogen.sh
./configure --with-arch=xtensa --with-platform=cherrytrail --with-root-dir=~/sof-sdk/xtensa-root/xtensa-byt-elf --host=xtensa-byt-elf
make
make bin
cd ..
