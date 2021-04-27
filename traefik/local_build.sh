#!/bin/bash

source ../root.conf
export TRAEFIK_API_RULE=traefik.$inethiDN
docker-compose up -d
#docker-compose config
