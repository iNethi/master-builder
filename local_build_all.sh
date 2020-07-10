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


sleep 10

chown -R www-data:www-data /mnt/data/nextcloud

sudo cp ./nextcloud_clone.sh /usr/local/bin
sudo chmod +x /usr/local/bin/nextcloud_clone.sh

sudo cp ./rclone /etc/cron.d

