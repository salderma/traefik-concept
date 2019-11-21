#!/bin/bash

if [ ! -d certs ]; then mkdir certs; fi
openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/privkey.key -x509 -days 365 -out certs/cert.crt
