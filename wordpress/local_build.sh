#!/bin/bash

source ../root.conf
source ./.env
source ./.secrets
sudo mkdir -p $WORDPRESS_MOUNT
sudo mkdir -p $MARIADB_MOUNT
docker-compose config
#docker-compose up -d