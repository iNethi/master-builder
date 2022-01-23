#!/bin/bash

source ../root.conf
source ./.env
sudo mkdir -p $UNIFI_VOLUME
docker-compose config
docker-compose up -d
