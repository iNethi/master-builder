#!/bin/bash

source ../root.conf
source ./.env
sudo mkdir -p $TRAEFIKSSL_VOLUME
sudo mkdir -p $TRAEFIKSSL_VOLUME_SECRETS
sudo cp ./secrets/* $TRAEFIKSSL_VOLUME_SECRETS
sudo mkdir -p $TRAEFIKSSL_VOLUME/letsencrypt
sudo cp ./acme.json $TRAEFIKSSL_VOLUME/letsencrypt
docker-compose config
docker-compose up -d
