.PHONEY: download clean build_gbdk_release
GBDK_VER := 4.0.1


all: download build_gbdk_release

download:
ifeq (,$(wildcard ./res/gbdk-${GBDK_VER}.tar.gz))
	curl -Lo res/gbdk-${GBDK_VER}.tar.gz https://github.com/Zal0/gbdk-2020/releases/download/${GBDK_VER}/gbdk-linux64.tar.gz
endif

build_gbdk_release:
	docker build -t gbdk --build-arg GBDK_VER=${GBDK_VER} .

clean:
	docker rmi gbdk:latest