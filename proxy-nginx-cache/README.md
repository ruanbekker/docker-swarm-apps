## Build the Image:

```
$ docker build -t registry.gitlab.com/<user>/<repo>/proxy-nginx:<tag> .
$ docker push registry.gitlab.com/<user>/<repo>/proxy-nginx:<tag>
```

## Deploy:

```
$ service create --name proxy_nginx \
--network appnet \
--update-delay 2s \
--replicas 1 \
--publish 80:80 \
--publish 443:443 \
--with-registry-auth \
registry.gitlab.com/<user>/<repo>/proxy-nginx:<tag>
```

or using stacks:

```
$ docker stack deploy --compose-file docker-compose.yml loadbalancer
```
