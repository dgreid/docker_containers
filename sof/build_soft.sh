#!/bin/sh
cd soft.git
./autogen.sh
./configure --prefix=/home/sof/bin
make
make install
cd ..
