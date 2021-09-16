#!/bin/bash

source ../root.conf
export TRAEFIK_API_RULE_ADMINER=adminer.$inethiDN
export TRAEFIK_API_RULE_MARIADB_MOODLE=mariadb-moodle.$inethiDN
sudo mkdir /mnt/data/moodle
sudo chmod -R 775 /mnt/data/moodle
docker-compose up -d
