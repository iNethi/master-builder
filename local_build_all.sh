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

sudo apt-get update
curl https://rclone.org/install.sh | sudo bash

mkdir ~/.config/rclone
mkidr /root/.config/rclone
sudo cp ./rclone.conf /root/.config/rclone/
sudo cp ./rclone.conf ~/.config/rclone

sudo mkdir /etc/inethi
sudo mkdir /etc/inethi/rclone
sudo cp ./exclude-file.txt /etc/inethi/rclone

chown -R www-data:www-data /mnt/data/nextcloud

sudo cp ./nextcloud_clone.sh /usr/local/bin
sudo chmod +x /usr/local/bin/nextcloud_clone.sh

sudo cp ./rclone /etc/cron.d

