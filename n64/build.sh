#!/bin/bash

BINUTILS_VER=2.35
GCC_VER=10.2.0
SPICY_VER=0.5.0

mkdir -p res

if [ ! -f res/binutils-${BINUTILS_VER}.tar.xz ]; then
    curl -Lo res/binutils-${BINUTILS_VER}.tar.xz https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VER}.tar.xz
fi

if [ ! -f res/gcc-${GCC_VER}.tar.xz ]; then
    curl -Lo res/gcc-${GCC_VER}.tar.xz ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-${GCC_VER}/gcc-${GCC_VER}.tar.xz
fi

if [ ! -f res/n64sdk.7z ]; then
    curl -Lo res/n64sdk.7z http://ultra64.ca/files/software/other/sdks/n64sdk.7z
fi

if [ ! -f res/n64dev.zip ]; then
    curl -Lo res/n64dev.zip http://ultra64.ca/files/software/other/sdks/n64dev.zip
fi

if [ ! -f res/spicy-${SPICY_VER}.tar.gz ]; then
    curl -Lo res/spicy-${SPICY_VER}.tar.gz https://github.com/trhodeos/spicy/releases/download/v${SPICY_VER}/spicy_${SPICY_VER}_linux_amd64.tar.gz
fi

docker build -t n64 --build-arg	BINUTILS_VER=${BINUTILS_VER} --build-arg SPICY_VER=${SPICY_VER} --build-arg GCC_VER=${GCC_VER}	 .