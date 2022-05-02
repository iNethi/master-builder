#!/bin/sh

source ../root.conf
source ./.env
mkdir -p $ONLYOFFICE_VOLUME
docker-compose config
docker-compose up -d

