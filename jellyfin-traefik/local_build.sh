#!/bin/sh

source ../root.conf
export TRAEFIK_API_RULE=traefik.$inethiDN
docker-compose up -d
