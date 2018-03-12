FROM alpine:edge
RUN apk add --no-cache python2 py2-pip && pip install flask
ADD exporter.py /exporter.py
ADD boot.sh /boot.sh
ADD app.py /app.py
CMD ["/bin/sh", "/boot.sh"]
