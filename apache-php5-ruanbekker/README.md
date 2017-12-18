## About:

Docker Resource for ruanbekker.com Website

## Usage:

Build the Image:

```
$ docker build -t apache_ruanbekker .
```

Login to registrar, tag and push to registry:

```
$ docker login registry.gitlab.com
$ docker tag apache_ruanbekker registry.gitlab.com/rbekker87/docker/php-ruanbekker:alpine
$ docker push registry.gitlab.com/rbekker87/docker/php-ruanbekker:alpine
```

Create The Service:

```
$ docker service create --name web_ruanbekker 
--replicas 1 \
--network appnet \
--constraint 'node.role==worker' \
--with-registry-auth registry.gitlab.com/rbekker87/docker/php-ruanbekker:alpine
```

Update the Service:

```
$ docker service update \
--image registry.gitlab.com/rbekker87/docker/php-ruanbekker:alpine \
web_ruanbekker
```
