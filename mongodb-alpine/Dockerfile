FROM alpine:edge

MAINTAINER Ruan Bekker <ruan@ruanbekker.com>

RUN apk update && \
    apk add --no-cache mongodb && \
    rm /usr/bin/mongoperf && \
    rm -rf /var/cache/apk/*

COPY boot.sh /root/boot.sh
RUN chmod +x /root/boot.sh

#CMD ["sh", "/root/boot.sh", "mongod"]
ENTRYPOINT ["/root/boot.sh"]
CMD ["mongod"]
