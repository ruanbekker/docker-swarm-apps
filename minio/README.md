# Minio Server on Docker
- https://docs.minio.io/docs/minio-quickstart-guide

## Running Minio Server on Swarm

```bash
$ docker stack deploy -c minio-server.yml apps
```

## Running Minio Server as a Docker Container

```bash
$ docker run -p 9000:9000 \
-e "MINIO_ACCESS_KEY=AKIAJASDHASDASDASDEESDACCESS" \
-e "MINIO_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" \
minio/minio server /data

Browser Access:
   http://172.17.0.4:9000  http://127.0.0.1:9000

Command-line Access: https://docs.minio.io/docs/minio-client-quickstart-guide
   $ mc config host add myminio http://172.17.0.4:9000 AKIAJASDHASDASDASDEESDACCESS wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

## Setting up the MC Client

```
$ docker run -it --entrypoint=/bin/sh minio/mc
mc config host add myminio http://172.17.0.4:9000 AKIAJASDHASDASDASDEESDACCESS wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Added `myminio` successfully. (/root/.mc/config.json)
```

## MC Client Usage

```bash
# make bucket
$ mc mb myminio/test
Bucket created successfully `myminio/test`.

# list buckets under profile myminio
$ mc ls myminio
[2018-01-23 07:45:00 UTC]     0B test/

# copy object to bucket
$ mc cp test.txt myminio/test/

# list recursive
$ mc ls --recursive myminio/
[2018-01-23 07:45:51 UTC]     0B test/test.txt

# download object locally
$ mc cp myminio/test/test.txt .

# get presigned share url
$ mc share download myminio/test/test.txt
URL: http://172.17.0.4:9000/test/test.txt
Expire: 7 days 0 hours 0 minutes 0 seconds
Share: http://172.17.0.4:9000/test/test.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJASDHASDASDASDEESDACCESS%2F20180123%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20180123T074758Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=5efb260bfba8f3730cff6db66b4be21d134eaa46ab48bb4d5993a88c751ff87e

# list shares
$ mc share list download myminio
URL: http://172.17.0.4:9000/test/test.txt
Expire: 6 days 23 hours 59 minutes 28 seconds
Share: http://172.17.0.4:9000/test/test.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJASDHASDASDASDEESDACCESS%2F20180123%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20180123T074758Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=5efb260bfba8f3730cff6db66b4be21d134eaa46ab48bb4d5993a88c751ff87e

# delete object
$ mc rm myminio/test/test.txt
Removing `myminio/test/test.txt`.

# delete bucket and all objects
$ mc rm --recursive --dangerous --force myminio
Removing `myminio/test`.
```
