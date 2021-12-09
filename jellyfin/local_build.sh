#!/bin/bash

source ../root.conf
export TRAEFIK_API_RULE=jellyfin.$inethiDN
docker-compose up -d
