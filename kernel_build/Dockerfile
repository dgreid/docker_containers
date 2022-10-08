# RUN: podman run -v ~/src:/src -it kernel
# x86_64:
#
# menuconfig, make
# install modules make INSTALL_MOD_PATH=../amd64_rootfs modules install
#
# riscv:
# 
# make ARCH=riscv -j 9
# install modules make ARCH=riscv INSTALL_MOD_PATH=../riscv_rootfs modules install
#
# From outside the container:
# `qemu-system-riscv64 --kernel arch/riscv/boot/Image  -nographic -m 8G -M virt -append "console=ttyS0 root=fsRoot rw rootfstype=9p rootflags=trans=virtio,version=9p2000.L,msize=501M" -fsdev local,security_model=none,multidevs=remap,id=fsdev-fsRoot,path=../riscv_rootfs/    -device virtio-9p-pci,id=fsRoot,fsdev=fsdev-fsRoot,mount_tag=fsRoot`
from debian:sid

RUN apt-get -y update && \
	    apt-get install -y \
	    git \
	    make \
	    gcc \
	    g++ \
	    clang \
	    kmod \
	    llvm \
	    lld \
	    device-tree-compiler \
	    bc \
	    bison \
	    flex \
	    libelf-dev \
	    libssl-dev \
	    libncurses-dev \
	    python3-ply \
	    python3-git \
	    libgmp3-dev \
	    libmpc-dev \
	    wget
RUN apt-get clean

ENV RUSTUP_HOME=/usr/local/rustup \
    RUST_ARCH=aarch64-unknown-linux-gnu \
    RUSTUP_VERSION=1.25.1 \
    CARGO_HOME=/usr/local/cargo \
    RUST_VERSION=1.62.0 \
    rust_version=$RUST_VERSION \
    PATH=/usr/local/cargo/bin:$PATH
RUN set -eux; \
    url="https://static.rust-lang.org/rustup/archive/$RUSTUP_VERSION/$RUST_ARCH/rustup-init"; \
    wget -q "$url"; \
    chmod +x rustup-init;
RUN ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION --default-host $RUST_ARCH;
RUN rm rustup-init;
RUN rustup target add x86_64-unknown-linux-gnu
RUN rustup target add riscv64gc-unknown-linux-gnu
RUN rustup component add rust-src
RUN rustup component add rustfmt
RUN rustup component add clippy
RUN cargo install bindgen
RUN chmod -R a+w $RUSTUP_HOME $CARGO_HOME;

ENV ARCH=x86_64
ENV LLVM=1
VOLUME /src
WORKDIR /src
CMD /bin/bash
