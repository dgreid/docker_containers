from ubuntu:14.04

RUN apt-get -y update
RUN apt-get -y install build-essential vim git libasound-dev libspeexdsp-dev libgtest-dev libtool automake libdbus-1-dev libudev-dev g++ ladspa-sdk libsndfile-dev libsbc-dev cmake tmux gdb man libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi g++-arm-linux-gnueabi libncurses5-dev
RUN apt-get clean
RUN cd /tmp && git clone https://github.com/ndevilla/iniparser.git && \
	    cd iniparser && \
	    make && \
	    cp libiniparser.* /usr/local/lib && \
	    cp src/dictionary.h src/iniparser.h /usr/local/include && \
	    chmod 644 /usr/local/include/dictionary.h /usr/local/include/iniparser.h && \
	    chmod 644 /usr/local/lib/libiniparser.a && \
	    chmod 755 /usr/local/lib/libiniparser.so.0
RUN cd /usr/src/gtest && \
	    cmake . && \
	    make && \
	    chmod 644 *.a && \
	    cp *.a /usr/local/lib
VOLUME /src
RUN useradd --create-home -d /home/dgreid -G sudo dgreid
RUN echo "dgreid:test0000" | chpasswd
ENV HOME /home/dgreid
USER dgreid
RUN git clone http://github.com/dgreid/HomeDir /home/dgreid/HomeDir
RUN cd /home/dgreid/HomeDir && ./setup.sh
