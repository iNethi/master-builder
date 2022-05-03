#!/bin/bash

#docker run   -p 8080:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=iNethi#2018 quay.io/keycloak/keycloak:11.0.2
source ../root.conf
export KEYCLOAK_TRAEFIK_API_RULE=keycloak.$inethiDN
export MYSQL_KEYCLOAK_TRAEFIK_API_RULE=mysql-keycloak.$inethiDN
docker-compose config
docker-compose up -d

