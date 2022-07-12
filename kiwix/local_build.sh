#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $KIWIX_VOLUME

if [ -f ./data/*.zim ] ; then
	echo Moving zim files to iNethi folders
	mv ./data/*.zim $KIWIX_VOLUME

	files=$(find $KIWIX_VOLUME/*.zim -printf '%f ')
	export COMMAND=$files 
	echo $files
	docker-compose config
	docker-compose up -d
else
	echo No zim files to process - nothing to do
fi

