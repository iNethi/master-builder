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
sudo mkdir -p $TRAEFIKSSL_VOLUME/letsencrypt
sudo cp ./acme.json $TRAEFIKSSL_VOLUME/letsencrypt
docker-compose config
docker-compose up -d
echo
echo Waiting for your DNS host to respond to build certificate - waiting for 6 minutes
echo Go make some cofee ... 
echo
sleep 300
docker-compose up -d --force-recreate
sleep 60
echo Done with certificate setup
echo