#!/bin/bash

source ../root.conf
source ./.env
sudo mkdir -p $TRAEFIKSSL_VOLUME
sudo mkdir -p $TRAEFIKSSL_VOLUME/letsencrypt
sudo mkdir -p $TRAEFIKSSL_VOLUME_SECRETS
if test -f ../acme.json; then
	echo Copying existing https certificate to traefik
	sudo cp ../acme.json $TRAEFIKSSL_VOLUME/letsencrypt
	sudo chmod 600 $TRAEFIKSSL_VOLUME/letsencrypt/acme.json
fi
sudo cp ./secrets/* $TRAEFIKSSL_VOLUME_SECRETS
docker-compose config
docker-compose up -d
