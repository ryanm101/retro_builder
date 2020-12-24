.PHONEY: download clean build_gbdk_release
GENDEV_VER := 0.5.0

all: download build_gbdk_release

download:
ifeq (,$(wildcard ./res/gendev_${GENDEV_VER}_all.deb))
	curl -Lo res/gendev_${GENDEV_VER}_all.deb https://github.com/kubilus1/gendev/releases/download/${GENDEV_VER}/gendev_${GENDEV_VER}_all.deb
endif

build_gbdk_release:
	docker build -t gendev --build-arg GENDEV_VER=${GENDEV_VER} .

clean:
	docker rmi gendev:latest