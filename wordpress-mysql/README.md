## Setup

Setup Overlay Network:

```
$ docker network create --driver overlay appnet
```

Setup Secrets:

```
$ openssl rand -base64 12 | docker secret create wordpress_db_password
$ openssl rand -base64 12 | docker secret create root_db_password
```

## Deploy

Deploy the Stack:

```
$ docker stack deploy --compose-file docker-compose.yml wordpress
```
