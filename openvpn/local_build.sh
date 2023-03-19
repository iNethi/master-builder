#!/bin/bash

#docker run   -p 8080:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=iNethi#2018 quay.io/keycloak/keycloak:11.0.2
source ../root.conf
source ./.env


docker run -v $OPENVPN_VOLUME:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://openvpn.inethicloud.net
docker run -v $OPENVPN_VOLUME:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki

#Start OpenVPN server process

#docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
#Generate a client certificate without a passphrase

#docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass
#Retrieve the client configuration with embedded certificates

#docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn

#docker-compose config
#docker-compose up -d

