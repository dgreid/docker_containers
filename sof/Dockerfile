# Copyright 2018 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Defines a docker image that can build sound open firmware
#
# Usage:
# check out sof
# build docker image: 
# docker build --build-arg UID=$(id -u) -t sof .
# docker run -it  -v <insert sof dir here>:/home/sof/workdir -v <soft git dir>:/home/sof/work/soft.git --user `id -u` sof
#
# For incremental builds:
# docker run -it  -v <insert sof dir here>:/home/sof/work/sof.git -v <soft git dir>:/home/sof/work/soft.git --user `id -u` sof ./incremental.sh
#

FROM ubuntu
ARG UID=1000

RUN apt-get -y update && \
	    apt-get install -y \
	    	autoconf \
		bison \
		build-essential \
		flex \
		gawk \
		gettext \
		git \
		gperf \
		help2man \
		libncurses5-dev \
		libncurses5-dev \
		libssl-dev \
		libtool \
		libtool \
		libtool-bin \
		pkg-config \
		software-properties-common \
		texinfo \
		udev \
		wget
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN apt-get -y update
RUN apt-get install -y gcc-7 g++-7
RUN apt-get clean
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 --slave /usr/bin/g++ g++ /usr/bin/g++-7

# Use ToT alsa utils for the latest topology patches.
# Need to build and install alsa so there is a static lib.
RUN mkdir -p /root/alsa-build
RUN cd /root/alsa-build && git clone git://git.alsa-project.org/alsa-lib.git
RUN cd /root/alsa-build && git clone git://git.alsa-project.org/alsa-utils.git
RUN cd /root/alsa-build/alsa-lib && ./gitcompile &&  make install
RUN cd /root/alsa-build/alsa-utils && ./gitcompile &&  make install

RUN useradd --create-home -d /home/sof -u $UID -G sudo sof
RUN echo "sof:test0000" | chpasswd
ENV HOME /home/sof

USER sof
RUN git clone git://git.alsa-project.org/sound-open-firmware.git /home/sof/sof.git
RUN git clone git://git.alsa-project.org/sound-open-firmware-tools.git /home/sof/soft.git
RUN git clone https://github.com/01org/osadsp-crosstool-ng.git /home/sof/ct-ng.git
RUN git clone https://github.com/jcmvbkbc/newlib-xtensa.git /home/sof/newlib-xtensa.git

USER sof
RUN mkdir -p /home/sof/bin
WORKDIR /home/sof/soft.git 
RUN ./autogen.sh
RUN ./configure --prefix=/home/sof/bin
RUN make
RUN make install

ENV PATH="/home/sof/bin/bin:${PATH}"

USER sof
WORKDIR /home/sof/ct-ng.git
RUN ./bootstrap
RUN ./configure --prefix=`pwd`
RUN make
RUN make install
RUN ./ct-ng xtensa-byt-elf
RUN ./ct-ng build

ENV PATH="/home/sof/ct-ng.git/builds/xtensa-byt-elf/bin:${PATH}"

USER sof
WORKDIR /home/sof/newlib-xtensa.git
RUN git checkout -b xtensa origin/xtensa
RUN ./configure --target=xtensa-byt-elf --prefix=/home/sof/sof-sdk/xtensa-root
RUN make
RUN make install

USER sof
WORKDIR /home/sof/sof.git
RUN ./autogen.sh
RUN ./configure --enable-rimage
RUN make
USER root
RUN make install

USER sof
RUN mkdir -p /home/sof/work/sof
RUN mkdir -p /home/sof/work/soft

USER root
COPY build_sof.sh build_soft.sh full_build.sh incremental.sh /home/sof/work/
RUN chown -R sof /home/sof/work
RUN chmod +x /home/sof/work/*.sh

USER sof
WORKDIR /home/sof/work
CMD ./full_build.sh
