#!/bin/bash

source ../root.conf
export TRAEFIK_API_RULE_MOODLE=moodle.$inethiDN
export TRAEFIK_API_RULE_MARIADB=mariadb.$inethiDN
sudo mkdir /mnt/data/mariadb
sudo chmod -R 775 /mnt/data/mariadb
docker-compose up -d
