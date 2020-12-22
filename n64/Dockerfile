FROM ubuntu:20.04

ENV TZ=Europe/London

WORKDIR /workdir
RUN useradd builder -d /workdir && chown -R builder:builder /workdir

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y build-essential bison flex texinfo \
	libgmp-dev libmpfr-dev libmpc-dev libisl-dev libzstd-dev && \
	rm -rf /var/lib/apt/lists/*

COPY --from=n64_mips:latest /opt/* /opt/n64
COPY --from=n64_spicy:latest /src/n64sdk/ultra/usr/include /opt/n64/sdk/include
COPY --from=n64_spicy:latest /src/n64sdk/ultra/usr/lib /opt/n64/sdk/lib
COPY --from=n64_spicy:latest /src/spicy /opt/n64/bin
COPY res/entrypoint.sh /
RUN chown -R builder:builder /opt /entrypoint.sh
RUN chmod u+x /entrypoint.sh

USER builder

ENTRYPOINT [ "/entrypoint.sh" ]