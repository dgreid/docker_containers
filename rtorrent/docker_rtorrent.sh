#!/bin/sh
export LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib
docker run -i -v /home/chronos/user/Downloads/:/torrents -u "$(id -u):$(id -g)" -e TERM -t rtorrent
