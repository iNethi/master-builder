#!/bin/sh

# Build local docker of haproxy-cert
docker build ./docker-haproxy-certbot -t djohnson/haproxy-certbot-wildcard-test

# Make directory for letsecnrypt and haproxy cfg
mkdir -p /mnt/data/haproxyssl_test
cp ./haproxy.cfg /mnt/data/haproxyssl_test



# Build the docker container (dont run in background)
docker-compose up 



