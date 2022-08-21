#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $NGINX_VOLUME/html/
docker-compose config
docker-compose up -d
bash ./generate_html.sh
cp index.html ../splash/generic-splash
cp -r ../splash/generic-splash/* $NGINX_VOLUME/html/
chmod -R 745 $NGINX_VOLUME
