#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $KOLIBRI
docker-compose config
docker-compose up -d
