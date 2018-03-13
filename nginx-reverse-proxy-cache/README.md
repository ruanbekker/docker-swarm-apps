## nginx-reverse-proxy-cache-alpine

Nginx Reverse Proxy with Caching on Alpine

## Usage:

Build, Push and Update the compose file:

```
$ docker build -t <user>/<image>:<tag> .
$ docker push <user>/<image>:<tag>
```

If you want to create the proxy seperate, and maybe via `service create`:

```
$ docker service create --name nginx_cache --network appnet --publish 80:80 <user>/<image>:<tag> .
```

Deploy the backend applications:

```
$ docker stack deploy -c docker-compose.yml apps
```

## Test it out:

Testing with the 2 server_name directives:

```
$ curl -i -H "Host:a.domain.co.za" http://127.0.0.1:80
HTTP/1.1 200 OK
Server: nginx
Date: Tue, 13 Mar 2018 19:35:47 GMT
Content-Type: text/plain; charset=utf-8
Content-Length: 263
Connection: keep-alive
X-Proxy-Cache: MISS

Hostname: 364d494df75d
IP: 127.0.0.1
IP: 10.0.0.8
IP: 10.0.0.7
IP: 172.18.0.6
GET / HTTP/1.1
Host: a.domain.co.za
User-Agent: curl/7.47.0
Accept: */*
Connection: close
X-Forwarded-For: 10.255.0.2
X-Forwarded-Host: a.domain.co.za
X-Real-Ip: 10.255.0.2

$ curl -i -H "Host:a.domain.co.za" http://127.0.0.1:80
HTTP/1.1 200 OK
Server: nginx
Date: Tue, 13 Mar 2018 19:35:49 GMT
Content-Type: text/plain; charset=utf-8
Content-Length: 263
Connection: keep-alive
X-Proxy-Cache: HIT

Hostname: 364d494df75d
IP: 127.0.0.1
IP: 10.0.0.8
IP: 10.0.0.7
IP: 172.18.0.6
GET / HTTP/1.1
Host: a.domain.co.za
User-Agent: curl/7.47.0
Accept: */*
Connection: close
X-Forwarded-For: 10.255.0.2
X-Forwarded-Host: a.domain.co.za
X-Real-Ip: 10.255.0.2

$ curl -i -H "Host:c.domain.co.za" http://127.0.0.1:80/
HTTP/1.1 200 OK
Server: nginx
Date: Tue, 13 Mar 2018 19:36:37 GMT
Content-Type: text/plain; charset=utf-8
Content-Length: 263
Connection: keep-alive
X-Proxy-Cache: MISS

Hostname: 85cfbffd644a
IP: 127.0.0.1
IP: 10.0.0.6
IP: 10.0.0.5
IP: 172.18.0.5
GET / HTTP/1.1
Host: c.domain.co.za
User-Agent: curl/7.47.0
Accept: */*
Connection: close
X-Forwarded-For: 10.255.0.2
X-Forwarded-Host: c.domain.co.za
X-Real-Ip: 10.255.0.2

$ curl -i -H "Host:c.domain.co.za" http://127.0.0.1:80/
HTTP/1.1 200 OK
Server: nginx
Date: Tue, 13 Mar 2018 19:36:39 GMT
Content-Type: text/plain; charset=utf-8
Content-Length: 263
Connection: keep-alive
X-Proxy-Cache: HIT

Hostname: 85cfbffd644a
IP: 127.0.0.1
IP: 10.0.0.6
IP: 10.0.0.5
IP: 172.18.0.5
GET / HTTP/1.1
Host: c.domain.co.za
User-Agent: curl/7.47.0
Accept: */*
Connection: close
X-Forwarded-For: 10.255.0.2
X-Forwarded-Host: c.domain.co.za
X-Real-Ip: 10.255.0.2
```

and for the backend with noe `server_name` directive, but with the `/scooby` location:

```
$ curl -i http://127.0.0.1:80
HTTP/1.1 404 Not Found
Server: nginx
Date: Tue, 13 Mar 2018 19:35:54 GMT
Content-Type: text/html
Content-Length: 162
Connection: keep-alive

<html>
<head><title>404 Not Found</title></head>
<body bgcolor="white">
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>

$ curl -i http://127.0.0.1:80/scooby
HTTP/1.1 200 OK
Server: nginx
Date: Tue, 13 Mar 2018 19:36:05 GMT
Content-Type: text/plain; charset=utf-8
Content-Length: 235
Connection: keep-alive
X-Proxy-Cache: MISS

Hostname: 794b98f1e307
IP: 127.0.0.1
IP: 10.0.0.10
IP: 10.0.0.9
IP: 172.18.0.7
GET /scooby HTTP/1.1
Host: b.domain.co.za
User-Agent: curl/7.47.0
Accept: */*
Connection: close
X-Forwarded-For: 10.255.0.2
X-Real-Ip: 10.255.0.2

$ curl -i http://127.0.0.1:80/scooby
HTTP/1.1 200 OK
Server: nginx
Date: Tue, 13 Mar 2018 19:36:13 GMT
Content-Type: text/plain; charset=utf-8
Content-Length: 235
Connection: keep-alive
X-Proxy-Cache: HIT

Hostname: 794b98f1e307
IP: 127.0.0.1
IP: 10.0.0.10
IP: 10.0.0.9
IP: 172.18.0.7
GET /scooby HTTP/1.1
Host: b.domain.co.za
User-Agent: curl/7.47.0
Accept: */*
Connection: close
X-Forwarded-For: 10.255.0.2
X-Real-Ip: 10.255.0.2
```
