FROM alpine:edge

RUN apk update \
    && apk add lighttpd \
    && rm -rf /etc/lighttpd/lighttpd.conf \
    && rm -rf /var/cache/apk/*

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf

ADD content /var/www/localhost/htdocs

CMD ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
