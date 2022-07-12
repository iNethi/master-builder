#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $JDJANGO_MNT
docker-compose config
docker-compose up -d