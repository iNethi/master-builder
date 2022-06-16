#!/bin/sh

# Setup remote sync system

sudo curl https://rclone.org/install.sh | sudo bash
rclone config

mkdir ~/.config/rclone
sudo mkdir /root/.config/rclone
sudo cp ./inethi_sync/rclone.conf /root/.config/rclone/
sudo cp ./inethi_sync/rclone.conf ~/.config/rclone

sudo mkdir /etc/inethi
sudo mkdir /etc/inethi/rclone
sudo cp ./inethi_sync/exclude-file.txt /etc/inethi/rclone

sudo cp ./inethi_sync/clone_nextcloud.sh /usr/local/bin
sudo chmod +x /usr/local/bin/clone_nextcloud.sh

sudo cp ./inethi_sync/rclone /etc/cron.d
