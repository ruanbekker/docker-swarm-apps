FROM alpine:edge

MAINTAINER Ruan Bekker <ruan@ruanbekker.com>

RUN apk add --no-cache mongodb && \
    rm /usr/bin/mongoperf && \
    rm -rf /var/cache/apk/*

COPY run.sh /root/run.sh

CMD [ "sh", "/root/run.sh", "mongod" ]
