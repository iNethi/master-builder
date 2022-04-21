#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $KIWIX_VOLUME
cp ./data/*.zim $KIWIX_VOLUME
cd ./data
files=$(find *.zim)
cd ..
echo COMMAND=$files >> ../.env
docker-compose config
docker-compose up -d
