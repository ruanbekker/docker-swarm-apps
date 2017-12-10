FROM rbekker87/armhf-alpine:3.5

RUN apk add --no-cache \
    bash \
    pwgen \
    su-exec \
    tzdata \
    mysql \
    mysql-client \
    && mkdir /run/mysqld \
    && chmod 777 /run/mysqld

COPY ./boot.sh /boot.sh
RUN chmod +x /boot.sh

EXPOSE 3306

ENTRYPOINT ["/boot.sh"]
CMD ["mysqld"]
