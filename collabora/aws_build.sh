#!/bin/sh


docker run -t -d -p 127.0.0.1:9980:9980 -e "domain=nextcloudg\\.inethi\\.net" -e "username=admin" -e "password=iNethi#2018"  -e "extra_params=--o:ssl.enable=false --o:ssl.termination=true" --restart always --name="inethi-collabora" --network="inethi-bridge" --ip="172.18.0.63"  collabora/code
#ONLYOFFICE_IPV4=172.18.0.59  docker-compose up -d
