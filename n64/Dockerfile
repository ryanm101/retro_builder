FROM ubuntu:20.04 as builder

ARG BINUTILS_VER
ARG GCC_VER
ARG SPICY_VER

ENV target=mips32-elf
ENV prefix=/opt/n64
ENV PATH=$prefix/bin:$PATH
ENV MAKEOPTS=-j4
ENV TZ=Europe/London

WORKDIR /tmp

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y build-essential bison flex texinfo \
	curl wget libgmp-dev libmpfr-dev libmpc-dev libisl-dev libzstd-dev xz-utils file && \
	rm -rf /var/lib/apt/lists/*

COPY res/binutils-${BINUTILS_VER}.tar.xz binutils-${BINUTILS_VER}.tar.xz
RUN xz -d binutils-${BINUTILS_VER}.tar.xz && tar xf binutils-${BINUTILS_VER}.tar && \
	mkdir build-binutils && cd build-binutils && \
	../binutils-${BINUTILS_VER}/configure \
		--target=${target} --prefix=${prefix} \
		--program-prefix=${target}- --with-cpu=vr4300 \
		--with-sysroot --disable-nls --disable-werror && \
	make && \
	make install && \
	make clean && rm -rf ./*

COPY res/gcc-${GCC_VER}.tar.xz gcc-${GCC_VER}.tar.xz
RUN xz -d gcc-${GCC_VER}.tar.xz && tar xf gcc-${GCC_VER}.tar && \
	mkdir build-gcc && cd build-gcc && \
	../gcc-${GCC_VER}/configure \
		--target=${target} --prefix=${prefix} \
		--program-prefix=${target}- --with-arch=vr4300 \
		--with-languages=c,c++ --disable-threads \
		--disable-nls --without-headers --with-newlib && \
	make all-gcc && \
	make all-target-libgcc && \
	make install-gcc && \
	make install-target-libgcc && \
	make clean && rm -rf ./*

FROM golang:1.15.3-alpine as gobuilder
# Use this for extracting zips to reduce the need for additional images
ENV CGO_ENABLED=0
ENV GOARCH=amd64
ENV GOOS=linux

WORKDIR /src

RUN apk --no-cache add git p7zip

RUN mkdir -p ${GOPATH}/src/github.com/depp/ && \
    git clone https://github.com/depp/spicy.git ${GOPATH}/src/github.com/depp/spicy

RUN cd ${GOPATH}/src/github.com/depp/spicy && \
    go mod init cmd/spicy && \
    go get -d cmd/spicy && \
    go build -o /src/spicy ./cmd/spicy/main.go && \
	rm -rf ${GOPATH}/src/*

COPY res/n64* /src/
RUN mkdir n64sdk && 7z x ./n64sdk.7z -o./n64sdk && rm ./n64sdk.7z

FROM ubuntu:20.04

ENV TZ=Europe/London
ENV CFLAGS=" -mabi=32 -ffreestanding -mfix4300 -G 0"

WORKDIR /workdir
RUN useradd builder -d /workdir && chown -R builder:builder /workdir

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y build-essential bison flex texinfo \
	libgmp-dev libmpfr-dev libmpc-dev libisl-dev libzstd-dev && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/n64sdk/include /opt/n64sdk/lib
COPY --from=builder /opt/* /opt/n64
COPY --from=gobuilder /src/n64sdk/ultra/usr/include /opt/n64sdk/include
COPY --from=gobuilder /src/n64sdk/ultra/usr/lib /opt/n64sdk/lib
COPY --from=gobuilder /src/spicy /usr/local/bin
COPY res/entrypoint.sh /
RUN chown -R builder:builder /opt /entrypoint.sh
RUN chmod u+x /entrypoint.sh

USER builder

ENTRYPOINT [ "/entrypoint.sh" ]