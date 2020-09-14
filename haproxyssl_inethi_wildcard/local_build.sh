#!/bin/sh

# Build local docker of haproxy-cert
docker build ./docker-haproxy-certbot -t djohnson/haproxy-certbot-wildcard

# Make directory for letsecnrypt and haproxy cfg
mkdir -p /mnt/data/haproxyssl
cp ./haproxy.cfg /mnt/data/haproxyssl
cp -ra ./letsencrypt /mnt/data/haproxyssl

# Build the docker container
docker-compose up -d


