#!/bin/sh

docker network create --attachable -d macvlan  --subnet=10.2.0.0/16  --gateway=10.2.0.1  -o parent=$1 inethi-bridge

./mysql/local_build.sh
./nextcloud/local_build.sh
./avideo/local_build.sh
./plex/localbuild.sh $2