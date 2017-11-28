## Resources:

- https://github.com/ulsmith/alpine-apache-php7
- https://hub.docker.com/r/ulsmith/alpine-apache-php7/
- https://docs.traefik.io/user-guide/swarm-mode/

## Notes about the Upstream Image:

- Web Root sits on `/app/public`
- List of [Environment Variables](https://github.com/ulsmith/alpine-apache-php7#environment-variables)

## Build the Image:

```
$ docker login registry.domain.com
$ docker build -t registry.domain.com/user/repo/image:tag .
$ docker push registry.domain.com/user/repo/image:tag
```

## Deploy the Stack:

```
$ docker stack deploy --compose-file app.yml web --with-registry-auth
```

## Traefik Config:

FQDN for Root Path:

```
...
    deploy:
      labels:
        - "traefik.port=80"
        - "traefik.docker.network=appnet" 
        - "traefik.frontend.rule=Host:domain.com,www.domain.com; PathPrefix: /"
...
```

FQDN with Path:

```
...
    deploy:
      labels:
        - "traefik.port=80"
        - "traefik.docker.network=appnet" 
        - "traefik.frontend.rule=Host:domain.com; PathPrefix: /test/"
...
```
