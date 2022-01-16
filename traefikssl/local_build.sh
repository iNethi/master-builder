#!/bin/bash

source ../root.conf
sudo mkdir -p /mnt/data/traefikssl
export TRAEFIK_API_RULE=traefik.$inethiDN
docker-compose up -d
#docker-compose config
