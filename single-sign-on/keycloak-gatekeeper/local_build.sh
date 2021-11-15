#!/bin/bash

sudo mkdir /mnt/data/keycloak_gatekeeper

sudo cp -r ./keycloak-gatekeeper.conf /mnt/data/keycloak_gatekeeper/
docker-compose up -d
