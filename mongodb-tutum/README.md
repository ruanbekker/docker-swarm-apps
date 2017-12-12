## Resource

https://hub.docker.com/r/tutum/mongodb/

### No Auth:

```bash
$ docker run -d --network docknet -p 27017:27017 -p 28017:28017 -e AUTH=no -e OPLOG_SIZE=50 tutum/mongodb
```

### Setting Auth:

```bash
docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_USER="user" -e MONGODB_DATABASE="mydatabase" -e MONGODB_PASS="mypass" tutum/mongodb
```

### Self Generated Auth:

```bash
docker run -d -p 27017:27017 -p 28017:28017 tutum/mongodb
```

Get the Password:

```bash
docker logs {container_id}
```
