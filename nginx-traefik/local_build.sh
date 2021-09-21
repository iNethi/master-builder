#!/bin/bash

sudo mkdir /mnt/data/traefik-nginx
sudo mkdir /mnt/data/traefik-nginx/html/

source ../root.conf
export TRAEFIK_API_RULE=splash.$inethiDN
docker-compose up -d

sudo cp -r ../splash/generic-splash/* /mnt/data/traefik-nginx/html/
sudo chmod -R 645 /mnt/data/traefik-nginx
