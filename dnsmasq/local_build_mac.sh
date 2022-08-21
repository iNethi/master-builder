#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $DNSMASQ_VOLUME

cp ./dnsmasq_template.conf ./dnsmasq.conf

echo
# Select domain namec
read -p 'IP address of this server: ' SERVERIP
echo

# Insert domain
sed -i '' "s/XXXX/$inethiDN/g"  dnsmasq.conf
# INSERT IP
sed -i '' "s/YYYY/$SERVERIP/g"  dnsmasq.conf


#Stop the local dns server
#sudo systemctl disable systemd-resolved.service
#sudo service systemd-resolved stop

# replace the local dns nameserver
# sudo sed -i  's/nameserver.*/nameserver 8.8.8.8/g' /etc/resolv.conf

cp dnsmasq.conf /mnt/data/dnsmasq
docker-compose config
docker-compose up -d
