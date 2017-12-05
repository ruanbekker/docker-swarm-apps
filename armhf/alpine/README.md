## Mini Root Filesystem 
- https://nl.alpinelinux.org/alpine/v3.5/releases/armhf/

Download:

```
$ wget https://nl.alpinelinux.org/alpine/v3.5/releases/armhf/alpine-minirootfs-3.5.1-armhf.tar.gz
```

Dockerfile:

```
FROM scratch

ADD alpine-minirootfs-3.5.1-armhf.tar.gz /

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
