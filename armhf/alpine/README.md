## Mini Root Filesystem 
- https://alpinelinux.org/downloads/

Download:

```
$ wget http://dl-cdn.alpinelinux.org/alpine/v3.8/releases/armhf/alpine-minirootfs-3.8.0-armhf.tar.gz
```

Dockerfile:

```
FROM scratch

ADD alpine-minirootfs-3.8.0-armhf.tar.gz /

CMD ["/bin/sh"]
```

Build:

```
$ docker build -t image:version .
```

Run:

```
$ docker run -it image:version sh
```

Dockerhub:
- https://hub.docker.com/r/rbekker87/armhf-alpine/
