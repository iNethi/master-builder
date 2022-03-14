#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $FDROID_VOLUME
mkdir $FDROID_VOLUME/config
cp -r ./repo $FDROID_VOLUME
cp config.py $FDROID_VOLUME/config
cp inethi-transparent.png $FDROID_VOLUME/config
docker-compose config
docker-compose up -d 
docker-compose run inethi-fdroid 