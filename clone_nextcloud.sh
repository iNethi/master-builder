#!/bin/sh
  
rclone -v  sync webdav:/Rshare /mnt/data/nextcloud/Rshare/   2>&1 | grep INFO | grep 'Delete\|Copied' >> /var/log/rclone.log
rclone -v  sync webdav:/Rvideo /mnt/data/nextcloud/Rvideo/   2>&1 | grep INFO | grep 'Delete\|Copied' >> /var/log/rclone.log
rclone -v  sync webdav:/Rmusic /mnt/data/nextcloud/Rmusic/   2>&1 | grep INFO | grep 'Delete\|Copied' >> /var/log/rclone.log