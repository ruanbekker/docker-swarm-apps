## Docker Secrets Exporter to Environment Variable

Populate Environment Variables from Docker Secrets

## Usage:

Create Docker Secrets:

```
$ echo 5001 | docker secret create flask_port -
$ echo 0.0.0.0 | docker secret create flask_host -
```

Build and Push and Create Service:

```
$ docker build -t registry.gitlab.com/<user>/<repo>/<image>:<tag>
$ docker push registry.gitlab.com/<user>/<repo>/<image>:<tag>
$ docker service create --name webapp \
--secret source=flask_host,target=flask_host \
--secret source=flask_port,target=flask_port \
registry.gitlab.com/<user>/<repo>/<image>:<tag>
```

Exec into the container, list to see where the secrets populated:

```
$ ls /run/secrets/
flask_host  flask_port
```

Do a netstat, to see that the value from the created secret is listening:

```
$ netstat -tulpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:5001            0.0.0.0:*               LISTEN      7/python
```

Do a GET request on the Flask Application:

```
$ curl http://0.0.0.0:5001/
ok
```
