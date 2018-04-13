## Other MongoDB Resources:

```
$ docker run -itd --name mongo \
  -p 27017:27017 \
  -v workspace/docker/volumes/mongodb:/data/db \
  mvertes/alpine-mongo:3.6.3-0
```
