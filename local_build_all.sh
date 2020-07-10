#!/bin/sh

docker network create --attachable -d macvlan  --subnet=10.2.0.0/16  --gateway=10.2.0.1  -o parent=$1 inethihome-bridge

cd ./mysql
./local_build.sh
cd ../nextcloud
./local_build.sh
cd ../avideo
./local_build.sh
cd ../plex
./localbuild.sh $2
