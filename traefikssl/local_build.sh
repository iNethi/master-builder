#!/bin/bash

source ../root.conf
source ./.env
sudo mkdir -p $TRAEFIKSSL_VOLUME
docker-compose config
#docker-compose up -d
