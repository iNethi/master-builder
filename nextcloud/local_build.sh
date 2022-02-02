#!/bin/bash

source ../root.conf
source ./.env
source ./secrets/secret_passwords.env
sudo mkdir -p $MYSQL_VOLUME
sudo mkdir -p $NEXTCLOUD_VOLUME
docker-compose config
docker-compose up -d