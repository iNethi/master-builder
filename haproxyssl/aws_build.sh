#!/bin/sh

# Build local docker of haproxy-cert
docker build ./docker-haproxy-certbot -t djohnson/haproxy-certbot-wildcard-test

# Make directory for letsecnrypt and haproxy cfg
mkdir -p /mnt/data/haproxyssl_test
cp ./haproxy.cfg /mnt/data/haproxyssl_test

# Build the docker container (dont run in background)
HAPROXYSSL_IPV4=172.18.0.60 docker-compose up
docker-compose exec -it inethi-haproxyssl-test /certs.sh

