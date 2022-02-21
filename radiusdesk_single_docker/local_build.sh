#!/bin/bash

source ../root.conf
source ./.env

docker-compose config
docker-compose build
docker-compose up -d