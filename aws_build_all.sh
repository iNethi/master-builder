#!/bin/sh

sudo docker network create --attachable -d bridge --subnet=172.18.0.0/16  inethi-bridge

# Need to add HA Proxy here


cd ./mysql
./aws_build.sh
cd ../nextcloud
./aws_build.sh
cd ../avideo
./aws_build.sh
cd ../plex
./aws_build.sh $2

