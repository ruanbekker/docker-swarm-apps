## Other MongoDB Resources:

Docker:

```
$ docker run -itd --name mongo \
  -p 27017:27017 \
  -v workspace/docker/volumes/mongodb:/data/db \
  mvertes/alpine-mongo:3.6.3-0
```

Docker Swarm:

```
$ docker service create \
  --name mongodb \
  --replicas 1 \
  --mount "type=bind,src=/mnt/docker/volumes/redis,target=/data,readonly=false" \
  --publish 27017:27017 \
  --network appnet \
  mvertes/alpine-mongo:3.6.3-0
```
