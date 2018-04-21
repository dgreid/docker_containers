#!/bin/sh
cd soft.git
make
make install
cd ..

cd sof.git
./configure --with-arch=xtensa --with-platform=cherrytrail --with-root-dir=${SOF_ROOTDIR}/sof-sdk/xtensa-root/xtensa-byt-elf --host=xtensa-byt-elf
make
make bin
cd ..
