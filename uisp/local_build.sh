#!/bin/bash

source ../root.conf
source ./.env
export TRAEFIK_API_RULE_UISP=uisp.$inethiDN
sudo mkdir -p $UISP_VOLUME
docker-compose up -d
