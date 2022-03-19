#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $JELLYFIN_VOLUME/html/
docker-compose config
docker-compose up -d