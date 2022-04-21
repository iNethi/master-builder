#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $DNSMASQ_VOLUME
# Insert domain
sed -i "s/XXXX/$inethiDN/g"  dnsmasq.conf 
cp dnsmasq.conf /mnt/data/dnsmasq
docker-compose config
docker-compose up -d
