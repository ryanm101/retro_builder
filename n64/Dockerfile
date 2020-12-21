FROM ubuntu:20.04 as builder

ARG BINUTILS_VER=2.35
ARG GCC_VER=10.2.0

ENV target=mips64-elf
ENV prefix=/opt/n64
ENV PATH=$prefix/bin:$PATH
ENV MAKEOPTS=-j4
ENV TZ=Europe/London

WORKDIR /build

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y build-essential bison flex texinfo \
	curl wget libgmp-dev libmpfr-dev libmpc-dev libisl-dev libzstd-dev xz-utils

RUN curl https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VER}.tar.xz > binutils.tar.xz && \
	xz -d binutils.tar.xz && tar xf binutils.tar && \
	mkdir build-binutils && cd build-binutils && \
	../binutils-${BINUTILS_VER}/configure \
  		--target=$target --prefix=$prefix \
  		--program-prefix=mips64- --with-cpu=vr4300 \
  		--with-sysroot --disable-nls --disable-werror && \
	make && \
	make install

RUN curl ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-${GCC_VER}/gcc-${GCC_VER}.tar.xz > gcc.tar.xz && \
	xz -d gcc.tar.xz && tar xf gcc.tar && \
	mkdir build-gcc && cd build-gcc && \
	../gcc-10.2.0/configure \
		--target=$target --prefix=$prefix \
		--program-prefix=mips64- --with-arch=vr4300 \
		-with-languages=c,c++ --disable-threads \
		--disable-nls --without-headers && \
	make all-gcc && \
	make all-target-libgcc && \
	make install-gcc && \
	make install-target-libgcc

FROM ubuntu:20.04

ENV TZ=Europe/London

WORKDIR /build

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y build-essential bison flex texinfo \
	curl wget libgmp-dev libmpfr-dev libmpc-dev libisl-dev libzstd-dev p7zip-full unzip

COPY --from=builder /opt* /opt/

#RUN curl http://ultra64.ca/files/software/other/sdks/n64sdk.7z
#RUN curl http://ultra64.ca/files/software/other/sdks/n64dev.zip