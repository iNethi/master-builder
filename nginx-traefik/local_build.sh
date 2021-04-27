#!/bin/bash

source ../root.conf
export TRAEFIK_API_RULE=traefik.$inethiDN
docker-compose up -d
#docker-compose config

sudo cp -r ../splash/generic-splash/* /mnt/data/traefik-nginx/html/
sudo chmod -R 645 /mnt/data/traefik-nginx
