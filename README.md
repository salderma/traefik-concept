# Traefik Docker POC

## Concepts

1. run docker-compose to create a traefik container listening for http on port 9080
2. setup a whoami container
3. put the whoami container behind /whoami URL path
4. add SSL, traefik container listens on port 9443
5. add SSL Redirect

## Setup

1. clone repo
2. execute `mkcerts.sh` to setup local certificates, use whoami.docker.local as CN.
3. execute `docker-compose up -d`

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
4. failure, so far.
```
$ curl -k -H Host:whoami.docker.local https://127.0.0.1:9443/whoami
404 page not found
```
