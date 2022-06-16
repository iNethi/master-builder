#!/bin/sh

rclone --filter-from /etc/inethi/rclone/exclude-file.txt -v --size-only sync inethi_nextcloud:/ZA_oceanview_RWshare/ /mnt/data/share 2>&1 | grep INFO | grep 'Delete\|Copied' >> /var/log/rclone.log
