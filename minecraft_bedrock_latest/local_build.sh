#!/bin/bash
source ../root.conf
source ./.env
docker-compose config
docker-compose up -d