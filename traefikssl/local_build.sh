#!/bin/bash

source ../root.conf
touch /mnt/data/traefikssl/acme.json && chmod 600 /mnt/data/traefikssl/acme.json
cp -a ./traefik.toml /mnt/data/traefikssl/
export TRAEFIK_API_RULE=traefik.$inethiDN
docker-compose up -d
#docker-compose config
