#!/bin/sh

docker-compose up -d
sudo cp ../splash/generic-splash/* /mnt/data/traefik-nginx/html/
sudo chmod -R 645 /mnt/data/traefik-nginx
