#!/bin/sh

source ../root.conf
source ./env
export TRAEFIK_API_RULE_UNIFI=unifi.$inethiDN
sudo mkdir $UNIFI_VOLUME
docker-compose up -d
