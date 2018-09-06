FROM lerwys/iverilog

ENV LITEX_VERSION 20d6fcac61f16ab8b794e8cf556bafd5ab374321
ENV BINUTILS_VERSION 2.31

LABEL \
      com.github.lerwys.docker.dockerfile="Dockerfile" \
      com.github.lerwys.vcs-type="Git" \
      com.github.lerwys.vcs-url="https://github.com/lerwys/docker-litex.git"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get install -y \
        python3 \
        python3-setuptools \
        wget \
        tar \
        gzip && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir litex && \
    cd litex && \
    wget https://raw.githubusercontent.com/enjoy-digital/litex/${LITEX_VERSION}/litex_setup.py && \
    python3 litex_setup.py init install && \
    rm -rf litex_setup.py

RUN wget http://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.gz && \
    tar xvf binutils-${BINUTILS_VERSION}.tar.gz && \
    cd binutils-${BINUTILS_VERSION} && \
    mkdir build && \
    cd build && \
    ../configure --target=lm32-elf && \
    make && \
    make install && \
    cd / && \
    rm -rf /binutils-${BINUTILS_VERSION} /binutils-${BINUTILS_VERSION}.tar.gz