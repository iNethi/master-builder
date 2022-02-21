#!/bin/bash

FLAG="/firstboot.log"

if [[ ! -f $FLAG ]]; then
   #Put here your initialization sentences
   sleep 10

   # /proc/1/fd/1 sends output to docker logs
   echo BUILDING RD DATABASE ...| tee /proc/1/fd/1  /var/log/init.log 

   # configure database
   mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root  mysql  >> /var/log/init.log 2>&1 
   mysql -u root < /db_setup.sql  >> /var/log/init.log 2>&1

   # Populate database
   mysql -u root rd < /var/www/html/cake3/rd_cake/setup/db/rd.sql  >> /var/log/init.log 2>&1
   #the next line creates an empty file so it won't run the next boot
   touch "$FLAG"

   echo COMPLETED DATABASE BUILD ...| tee /proc/1/fd/1 /var/log/init.log 
fi

echo
echo STARTING FREERADIUS ... > /proc/1/fd/1 
freeradius -X
