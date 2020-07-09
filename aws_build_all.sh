#!/bin/sh

sudo docker network create --attachable -d bridge --subnet=172.18.0.0/16  inethi-bridge

# Need to add HA Proxy here


./mysql/aws_build.sh
./nextcloud/aws_build.sh
./avideo/aws_build.sh
./plex/aws_build.sh


