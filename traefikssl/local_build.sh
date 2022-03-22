#!/bin/bash

source ../root.conf
source ./.env
sudo mkdir -p $TRAEFIKSSL_VOLUME
sudo mkdir -p $TRAEFIKSSL_VOLUME_SECRETS
sudo cp ./secrets/* $TRAEFIKSSL_VOLUME_SECRETS
docker-compose config
docker-compose up -d
