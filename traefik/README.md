## Resources:

- https://github.com/containous/traefik/blob/master/docs/user-guide/swarm-mode.md

## List Traefik Dir:

```
$ ls
Dockerfile  traefik.toml  docker-compose.yml
```

## Build and Push:

Docker Hub:

```
docker login
docker build -t {user}/{repo}/{image}:{tag} .
docker push {user}/{repo}/{image}:{tag}
```

Gitlab Registry

```
docker login registry.gitlab.com
docker build -t registry.gitlab.com/{user}/{repo}/{image}:{tag} .
docker push registry.gitlab.com/{user}/{repo}/{image}:{tag}
```

## Deploy Stack:

```
docker stack deploy --compose-file docker-compose.yml proxy --with-registry-auth
```
