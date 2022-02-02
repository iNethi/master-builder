#!/bin/bash

source ../root.conf
source ./.env
source ./secrets/secret_passwords.env
sudo mkdir -p $WORDPRESS_MOUNT
sudo mkdir -p $MARIADB_MOUNT
docker-compose config
docker-compose up -d