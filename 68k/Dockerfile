FROM alpine:3 as builder

RUN apk add --no-cache build-base

WORKDIR /tmp
RUN wget http://sun.hasenbraten.de/vasm/release/vasm.tar.gz && tar xvzf vasm.tar.gz
WORKDIR /tmp/vasm
RUN for CPU in 6502 6800 arm c16x jagrisc m68k ppc test tr3200 vidcore x86 z80; do\
        for SYNTAX in std madmac mot oldstyle; do\
            make CPU=${CPU} SYNTAX=${SYNTAX};\
        done;\
    done

FROM alpine:3

RUN apk add --no-cache build-base
WORKDIR /workdir
COPY --from=builder /tmp/vasm/vasm*_* /usr/local/bin/
COPY --from=builder /tmp/vasm/vobjdump /usr/local/bin/
