#!/bin/bash

source ../root.conf
source ./.env
source ./secrets/secret_passwords.env
mkdir -p $MYSQL_VOLUME
mkdir -p $NEXTCLOUD_VOLUME
docker-compose config
docker-compose up -d