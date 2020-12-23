FROM ubuntu:20.04

ENV TZ=Europe/London
ARG GBDK_VER

WORKDIR /workdir

COPY res/gbdk-${GBDK_VER}.tar.gz gbdk.tar.gz
COPY res/entrypoint.sh /

RUN useradd builder -r && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    tar xvzf gbdk.tar.gz && \
    mkdir -p /opt/gbdk && \
    cp -r ./gbdk/include /opt/gbdk/ && \
    cp -r ./gbdk/lib /opt/gbdk/ && \
    cp -r ./gbdk/bin /opt/gbdk/ && \
    rm -rf ./gbdk && \
    chown -R builder:builder  /entrypoint.sh /workdir /opt/gbdk && \
    chmod u+x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]