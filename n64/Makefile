.PHONEY: download build_mips build_spicy build_n64 clean_buildcache clean
BINUTILS_VER := 2.35
GCC_VER := 10.2.0
SPICY_VER := 0.5.0

all: download

download:
ifeq (,$(wildcard ./res/binutils-${BINUTILS_VER}.tar.xz))
	curl -Lo res/binutils-${BINUTILS_VER}.tar.xz https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VER}.tar.xz
endif
ifeq (,$(wildcard res/gcc-${GCC_VER}.tar.xz))
	curl -Lo res/gcc-${GCC_VER}.tar.xz ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-${GCC_VER}/gcc-${GCC_VER}.tar.xz
endif
ifeq (,$(wildcard res/n64sdk.7z))
	curl -Lo res/n64sdk.7z http://ultra64.ca/files/software/other/sdks/n64sdk.7z
endif
ifeq (,$(wildcard res/n64dev.zip))
	curl -Lo res/n64dev.zip http://ultra64.ca/files/software/other/sdks/n64dev.zip
endif
ifeq (,$(wildcard res/spicy-${SPICY_VER}.tar.gz))
	curl -Lo res/spicy-${SPICY_VER}.tar.gz https://github.com/trhodeos/spicy/releases/download/v${SPICY_VER}/spicy_${SPICY_VER}_linux_amd64.tar.gz
endif

build_mips:
	docker build -f Dockerfile_mips -t n64_mips --build-arg BINUTILS_VER=${BINUTILS_VER} --build-arg GCC_VER=${GCC_VER} .

build_spicy:
	docker build -f Dockerfile_spicy -t n64_spicy .

build_n64:
	docker build -t n64 .

clean_buildcache:
	docker rmi n64_mips
	docker rmi n64_spicy

clean: clean_buildcache
	docker rmi n64