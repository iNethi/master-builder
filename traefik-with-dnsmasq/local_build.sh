#!/bin/bash

source ../root.conf
export TRAEFIK_API_RULE=traefik.$inethiDN
sudo mkdir /mnt/data/dnsmasq
sudo mkdir /mnt/data/traefik
sudo cp -r ./dnsmasq/* /mnt/data/dnsmasq

docker-compose up -d
