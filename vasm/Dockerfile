FROM alpine:3 as builder

RUN apk add --no-cache build-base

WORKDIR /tmp
COPY res/vasm.tar.gz vasm.tar.gz 
RUN tar xvzf vasm.tar.gz && \
    cd vasm && \
    for CPU in 6502 6800 arm c16x jagrisc m68k ppc tr3200 vidcore x86 z80; do\
        for SYNTAX in std madmac mot oldstyle; do\
            make CPU=${CPU} SYNTAX=${SYNTAX};\
        done;\
    done

FROM alpine:3

RUN apk add --no-cache build-base
WORKDIR /workdir
RUN addgroup -S builder && adduser -S builder -G builder

COPY --from=builder /tmp/vasm/vasm*_* /usr/local/bin/
COPY --from=builder /tmp/vasm/vobjdump /usr/local/bin/

COPY res/entrypoint.sh /
RUN chown -R builder:builder /entrypoint.sh /workdir && \
    chmod u+x /entrypoint.sh
USER builder

ENTRYPOINT [ "/entrypoint.sh" ]