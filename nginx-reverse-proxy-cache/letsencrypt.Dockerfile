FROM nginx:alpine

MAINTAINER Ruan Bekker

RUN rm -rf /etc/nginx/nginx.conf
RUN rm -rf /etc/nginx/conf.d/*

RUN apk add --update  \
  python python-dev py-pip bash \
  curl tar gcc musl-dev linux-headers \
  augeas-dev openssl openssl-dev libffi-dev ca-certificates dialog \
  && rm -rf /var/cache/apk/*

RUN pip install -U letsencrypt
RUN mkdir /etc/letsencrypt /etc/nginx/certs

ADD letsencrypt /etc/letsencrypt/
ADD nginx.conf /etc/nginx/
ADD credentials /etc/nginx/
ADD conf.d /etc/nginx/conf.d/
ADD certs /etc/nginx/certs
ADD html/403_es.html /usr/share/nginx/html/

EXPOSE 80 443
