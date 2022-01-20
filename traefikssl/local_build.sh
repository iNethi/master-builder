#!/bin/bash

source ../root.conf
source ./.env
sudo mkdir -p $TRAEFIKSSL_VOLUME
docker-compose up -d
#docker-compose config
