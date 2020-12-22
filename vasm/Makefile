.PHONEY: download build_vasm clean


all: download build_vasm

download:
ifeq (,$(wildcard ./res/vasm.tar.gz))
	curl -Lo res/vasm.tar.gz http://sun.hasenbraten.de/vasm/release/vasm.tar.gz
endif

build_68k:
	docker build -t vasm .

clean: 
	docker rmi vasm