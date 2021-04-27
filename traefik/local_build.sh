#!/bin/bash

source ../root.conf
TRAEFIK_API_RULE=traefik.$inethiDN
echo $TRAEFIK_API_RULE
#docker-compose up -d
docker-compose config
