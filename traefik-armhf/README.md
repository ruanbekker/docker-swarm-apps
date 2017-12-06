## Traefik on RaspberryPi

Create the Overlay Network

```
$ docker network create --driver overlay traefik-net
```

Create the Traefik Service

```
$ docker service create \
  --name traefik \
  --constraint 'node.role==manager' \
  --publish 80:80 \
  --publish 8080:8080 \
  --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
  --network docknet \
  hypriot/rpi-traefik \
  --docker \
  --docker.swarmmode \
  --docker.watch \
  --logLevel=DEBUG \
  --web
```

Create a Web Application with Traefik that only has a `/` directory:

```
$ docker service create \
  --name landing \
  --label 'traefik.port=80' \
  --label traefik.frontend.rule="Host:web.domain.com; Path: /" \
  --network traefik-net \
  hypriot/rpi-busybox-httpd
```

Create a Web Application with Traefik that has multiple domains:

```
$ docker service create \
  --name landing \
  --label 'traefik.port=80' \
  --label traefik.frontend.rule="Host:web.domain.com,web2.domain.com; Path: /" \
  --network traefik-net \
  hypriot/rpi-busybox-httpd
```

Create a Web Application with Traefik that has recursive paths:

```
$ docker service create \
  --name landing \
  --label 'traefik.port=80' \
  --label traefik.frontend.rule="Host:sub.domain.com, PathPrefix: /web/" \
  --network traefik-net \
  hypriot/rpi-busybox-httpd
```

Create a Web Application with Ghost and Traefik that reverse proxies to a port:

```
$ docker service create \
  --name blog \
  --label traefik.frontend.rule="Host:blog.domain.com" \
  --label traefik.port=2368  \
  --network docknet \
  --mount "type=bind,source=/mnt/volumes/ghost/content/data,target=/var/www/ghost/content/data,readonly=false" \
  --replicas 1 \
  alexellis2/ghost-on-docker:armv7
```
