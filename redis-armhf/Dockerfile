FROM rbekker87/armhf-alpine:3.7

RUN addgroup -S redis && adduser -S -G redis redis
RUN apk add --no-cache 'su-exec>=0.2'
RUN apk update && apk add redis

RUN mkdir /data && chown redis:redis /var/lib/redis /data
WORKDIR /data

EXPOSE 6379

CMD ["su-exec", "redis", "/usr/bin/redis-server"]
