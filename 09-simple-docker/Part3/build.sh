#!/bin/bash

docker pull nginx
docker run -d -p 81:81 --name part3 nginx
docker cp ./server.c part3:etc/nginx/
docker cp ./nginx.conf part3:/etc/nginx/
docker exec part3 apt-get update
docker exec part3 apt-get install -y gcc spawn-fcgi libfcgi-dev
docker exec part3 gcc /etc/nginx/server.c -o /etc/nginx/part3 -l fcgi
docker exec part3 spawn-fcgi -p 8080 /etc/nginx/part3
docker exec part3 nginx -s reload