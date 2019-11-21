# Traefik Docker POC

## Setup

1. clone repo
2. execute `mkcerts.sh` to setup local certificates, use `whoami.docker.local` as CN.
3. add hosts file entry for `whoami.docker.local` on `127.0.0.1`
4. execute `CURRENT_UID=$(id -u):$(id -g) docker-compose up -d`  **NOTE** setting the UID variable so root won't own files in the `logs/` directory.

## Cleanup

1. execute `CURRENT_UID=$(id -u):$(id -g) docker-compose down`

## Concepts

1. run docker-compose to create a traefik container listening for http on port 9080
2. setup a whoami container
3. put the whoami container behind /whoami URL path
4. add SSL, traefik container listens on port 9443
5. add SSL Redirect

## Results

1. success
2. success
```
$ docker-compose up -d
$ curl -H Host:whoami.docker.local http://127.0.0.1:9080
Hostname: 3c56c2ddb127
IP: 127.0.0.1
IP: 172.24.0.2
RemoteAddr: 172.24.0.3:39272
GET / HTTP/1.1
Host: whoami.docker.local
User-Agent: curl/7.58.0
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 172.24.0.1
X-Forwarded-Host: whoami.docker.local
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: 3f8bd604a311
X-Real-Ip: 172.24.0.1
```
3. success
```
$ curl -H Host:whoami.docker.local http://127.0.0.1:9080/whoami
Hostname: df380fbef56c
IP: 127.0.0.1
IP: 192.168.64.2
RemoteAddr: 192.168.64.3:45636
GET /whoami HTTP/1.1
Host: whoami.docker.local
User-Agent: curl/7.58.0
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 192.168.64.1
X-Forwarded-Host: whoami.docker.local
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: 7f9f9786c434
X-Real-Ip: 192.168.64.1
```
4. success
```
$ curl -k -H Host:whoami.docker.local https://127.0.0.1:9443/whoami/
Hostname: 15fd271e4dd9
IP: 127.0.0.1
IP: 192.168.96.2
RemoteAddr: 192.168.96.3:49958
GET /whoami/ HTTP/1.1
Host: whoami.docker.local
User-Agent: curl/7.58.0
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 192.168.96.1
X-Forwarded-Host: whoami.docker.local
X-Forwarded-Port: 443
X-Forwarded-Proto: https
X-Forwarded-Server: c7b79a851f71
X-Real-Ip: 192.168.96.1

```
5. success
```
$ curl -v -k -H Host:whoami.docker.local http://whoami.docker.local:9080/whoami/
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to whoami.docker.local (127.0.0.1) port 9080 (#0)
> GET /whoami/ HTTP/1.1
> Host:whoami.docker.local
> User-Agent: curl/7.58.0
> Accept: */*
> 
< HTTP/1.1 302 Found
< Location: https://whoami.docker.local:9443/whoami/
< Date: Thu, 21 Nov 2019 19:28:44 GMT
< Content-Length: 5
< Content-Type: text/plain; charset=utf-8
< 
* Connection #0 to host whoami.docker.local left intact
Found
```
