#!/bin/bash

source ./.env

# Build local docker of haproxy-cert
docker build ./docker-haproxy-certbot -t djohnson/haproxy-certbot-wildcard-test

# Make directory for letsecnrypt and haproxy cfg
mkdir -p $HAPROXYSSL_VOLUME
cp ./haproxy.cfg $HAPROXYSSL_VOLUME
# Build the docker container (dont run in background)
docker-compose up -d

echo 
echo Waiting for docker instance to boot ...
echo

sleep 30

echo Starting CERTIFICATE generation with letsencrypt ....
echo 

docker exec -it -e CERTS=$HAPROXYSSL_DOMAIN -e EMAIL=$HAPROXYSSL_EMAIL inethi-haproxyssl-test /certs.sh