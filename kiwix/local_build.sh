#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $KIWIX_VOLUME

<<<<<<< HEAD
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
=======



cd ./data
files=$(find *.zim)
mv *.zim $KIWIX_VOLUME
cd ..
echo COMMAND=$files >> .env
docker-compose config
docker-compose up -d
>>>>>>> 41831df5937a0c1ab5aad20051c35a095795b014
