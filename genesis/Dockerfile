FROM ubuntu:20.04

ENV TZ=Europe/London
ARG GENDEV_VER

WORKDIR /workdir

COPY res/gendev_${GENDEV_VER}_all.deb gendev.deb
COPY res/entrypoint.sh /

RUN useradd builder -r && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt update && apt install -y build-essential bison flex texinfo \
	default-jre && \
	rm -rf /var/lib/apt/lists/* && \
    dpkg -i ./gendev.deb && \
    rm -rf ./gendev.deb && \
    chown -R builder:builder  /entrypoint.sh /workdir && \
    chmod u+x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]