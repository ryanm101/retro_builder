CFLAGS := -Wa-l -Wl-m -Wl-j

DOCKER = docker run --rm -e CFLAGS="${CFLAGS}" -itv ${PWD}:/workdir gbdk
CC	= ${DOCKER} lcc 
BINS	= space.gb

all:	$(BINS)

# Compile and link single file in one pass
%.gb:	%.s
	$(CC) -o $@ $<

clean:
	rm -f *.o *.lst *.map *.gb *~ *.rel *.cdb *.ihx *.lnk *.sym *.asm *.noi

