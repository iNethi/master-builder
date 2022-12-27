#!/bin/bash

source ../root.conf
source ./.env
mkdir -p $TRAEFIKSSL_VOLUME
mkdir -p $TRAEFIKSSL_VOLUME/letsencrypt
mkdir -p $TRAEFIKSSL_VOLUME_SECRETS
if test -f ../my-certificates/acme.json; then
	echo Copying existing https certificate to traefik
	cp ../my-certificates/acme.json $TRAEFIKSSL_VOLUME/letsencrypt
	chmod 600 $TRAEFIKSSL_VOLUME/letsencrypt/acme.json
	docker-compose -f docker-compose-noFetchCert.yml config
	docker-compose -f docker-compose-noFetchCert.yml up -d --force-recreate
else
	cp ./secrets/* $TRAEFIKSSL_VOLUME_SECRETS
	mkdir -p $TRAEFIKSSL_VOLUME/letsencrypt
	docker-compose config
	docker-compose up -d --force-recreate
	echo
	echo Waiting for your DNS host to respond to build certificate - waiting for 6 minutes
	echo Go make some cofee ... 
	echo
	sleep 300
	docker-compose up -d --force-recreate
	sleep 60
	echo Done with certificate setup
	echo
fi
