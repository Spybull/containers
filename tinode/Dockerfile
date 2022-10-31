FROM alpine:3.14

ARG VERSION=0.20.0
ARG TARGET_DB=alldbs
ARG BINVERS=$VERSION

ENV VERSION=$VERSION
ENV TARGET_DB=$TARGET_DB

LABEL org.opencontainers.image.authors="https://github.com/Spybull" \
      org.opencontainers.image.description="Tinode Chat Server" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.source="https://github.com/Spybull/containers/tree/main/tinode" \
      org.opencontainers.image.title="tinode" \
      org.opencontainers.image.vendor="Tinode Team <info@tinode.co>" \
      org.opencontainers.image.version="0.0.1"

RUN apk update && \
    apk add --no-cache ca-certificates bash grep su-exec && \
    mkdir -p /opt/tinode/data && \ 
    mkdir /botdata && cd /opt/tinode && \
    wget https://github.com/tinode/chat/releases/download/v$BINVERS/tinode-$TARGET_DB.linux-amd64.tar.gz && \
    tar -zxf tinode-$TARGET_DB.linux-amd64.tar.gz . && \
    rm -rf tinode-$TARGET_DB.linux-amd64.tar.gz && \
    mv *.jpg data.json ./data/

WORKDIR /opt/tinode
COPY tinode/ .

RUN adduser -D tinode && \
    chmod -R 0770 /opt/tinode/scripts

ENTRYPOINT [ "/opt/tinode/scripts/entrypoint.sh" ]
CMD [ "/opt/tinode/scripts/run.sh" ]