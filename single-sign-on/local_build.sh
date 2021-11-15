#!/bin/bash

sudo mkdir /mnt/data/postgress_keycloak
cd ./keycloak
docker-compose up -d
cd ..
