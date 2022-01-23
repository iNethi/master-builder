#!/bin/bash
source ../root.conf
source ./.env
sudo mkdir -p $NGINX_VOLUME/html/
docker-compose config
docker-compose up -d
sudo cp -r ../splash/generic-splash/* /mnt/data/traefik-nginx/html/
sudo chmod -R 645 /mnt/data/traefik-nginx
