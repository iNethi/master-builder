#!/bin/bash

FLAG="/firstboot.log"
if [[ ! -f $FLAG ]]; then
   #Put here your initialization sentences
   mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root  mysql
   #the next line creates an empty file so it won't run the next boot
   touch "$FLAG"
fi

