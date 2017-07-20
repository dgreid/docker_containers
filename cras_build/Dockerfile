from ubuntu

RUN apt-get -y update && \
	    apt-get install -y \
	    automake \
	    binutils-arm-linux-gnueabi \
	    build-essential \
	    cmake \
	    ctags \
	    g++ \
	    g++-arm-linux-gnueabi \
	    gdb \
	    git \
	    ladspa-sdk \
	    libasound-dev \
	    libc6-armel-cross \
	    libc6-dev-armel-cross \
	    libdbus-1-dev \
	    libgtest-dev \
	    libncurses5-dev \
	    libsbc-dev \
	    libsndfile-dev \
	    libspeexdsp-dev \
	    libtool \
	    libudev-dev \
	    man \
	    tmux \
	    vim
RUN apt-get clean
RUN cd /tmp && git clone https://github.com/ndevilla/iniparser.git && \
	    cd iniparser && \
	    make && \
	    cp libiniparser.* /usr/local/lib && \
	    cp src/dictionary.h src/iniparser.h /usr/local/include && \
	    chmod 644 /usr/local/include/dictionary.h /usr/local/include/iniparser.h && \
	    chmod 644 /usr/local/lib/libiniparser.a && \
	    chmod 755 /usr/local/lib/libiniparser.so.*
RUN cd /usr/src/gtest && \
	    cmake . && \
	    make && \
	    chmod 644 *.a && \
	    cp *.a /usr/local/lib
RUN useradd --create-home -d /home/cbuild -G sudo cbuild
RUN echo "cbuild:test0000" | chpasswd
ENV HOME /home/cbuild
RUN su cbuild -c "git clone https://chromium.googlesource.com/chromiumos/third_party/adhd /home/cbuild/adhd"
USER cbuild
