FROM alpine:3.6

RUN apk update && \
    apk add apache2 php5-apache2

RUN rm -rf /etc/apache2/httpd.conf \
    && rm -rf /etc/php5/php.ini

COPY httpd.conf /etc/apache2/httpd.conf
COPY php.ini /etc/php5/php.ini

RUN mkdir -p /run/apache2 \
    && mkdir -p /var/www/ruanbekker \
    && chown -R apache:apache /run/apache2 \
    && chown -R apache:apache /etc/apache2/httpd.conf

ADD html /var/www/ruanbekker
RUN chown -R apache:apache /var/www/ruanbekker

CMD ["httpd", "-DFOREGROUND"]
