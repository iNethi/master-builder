#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $DNSMASQ_VOLUME


echo
# Select domain namec
read -p 'IP address of this server: ' SERVERIP
echo

# Insert domain
sed -i "s/XXXX/$inethiDN/g"  dnsmasq.conf
# INSERT IP
sed -i "s/YYYY/$SERVERIP/g"  dnsmasq.conf


cp dnsmasq.conf /mnt/data/dnsmasq
docker-compose config
docker-compose up -d
