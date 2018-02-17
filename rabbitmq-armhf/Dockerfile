FROM rbekker87/armhf-alpine:3.7

RUN addgroup -S rabbitmq && adduser -S -h /var/lib/rabbitmq -G rabbitmq rabbitmq

RUN apk add --no-cache 'su-exec>=0.2'
RUN apk add --no-cache bash openssl procps erlang-asn1 erlang-hipe erlang-crypto erlang-eldap erlang-inets erlang-mnesia erlang erlang-os-mon erlang-public-key erlang-sasl erlang-ssl erlang-syntax-tools erlang-xmerl

ENV RABBITMQ_LOGS=- RABBITMQ_SASL_LOGS=-
ENV RABBITMQ_HOME=/opt/rabbitmq
ENV PATH=$RABBITMQ_HOME/sbin:$PATH
ENV RABBITMQ_VERSION=3.7.3
ENV RABBITMQ_GITHUB_TAG=v3.7.3

RUN apk add --no-cache --virtual .build-deps ca-certificates gnupg libressl xz
RUN wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.3/rabbitmq-server-generic-unix-3.7.3.tar.xz.asc
RUN wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.3/rabbitmq-server-generic-unix-3.7.3.tar.xz

ENV GNUPGHOME="$(mktemp -d)"

RUN rm -rf "$GNUPGHOME"
RUN mkdir -p "$RABBITMQ_HOME"
RUN tar --extract --file rabbitmq-server-generic-unix-3.7.3.tar.xz --directory "$RABBITMQ_HOME" --strip-components 1
RUN rm -rf rabbitmq-server-generic-unix-3.7.3.tar.xz
RUN grep -qE '^SYS_PREFIX=\$\{RABBITMQ_HOME\}$' "$RABBITMQ_HOME/sbin/rabbitmq-defaults"
RUN sed -ri 's!^(SYS_PREFIX=).*$!\1!g' "$RABBITMQ_HOME/sbin/rabbitmq-defaults"
RUN grep -qE '^SYS_PREFIX=$' "$RABBITMQ_HOME/sbin/rabbitmq-defaults"
RUN apk del .build-deps
ENV HOME /var/lib/rabbitmq
RUN mkdir -p /var/lib/rabbitmq /etc/rabbitmq /var/log/rabbitmq && chown -R rabbitmq:rabbitmq /var/lib/rabbitmq /etc/rabbitmq /var/log/rabbitmq && chmod -R 777 /var/lib/rabbitmq /etc/rabbitmq /var/log/rabbitmq
RUN ln -sf /var/lib/rabbitmq/.erlang.cookie /root/
RUN ln -sf "$RABBITMQ_HOME/plugins" /plugins

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 4369 5671 5672 25672
CMD ["rabbitmq-server"]
