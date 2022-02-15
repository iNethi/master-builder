#!/bin/sh

# Activate php (seems docekr does this for you)
#systemctl enable php7.4-fpm
#systemctl start php7.4-fpm

# Fetch radiusdesk
cd /usr/share/nginx
mkdir -p /usr/share/nginx/html
git clone https://github.com/RADIUSdesk/rdcore.git
    
# We will create soft links in the directory where Nginx will serve the RdCore contents.
cd /usr/share/nginx/html
ln -s ../rdcore/rd ./rd
ln -s ../rdcore/cake3 ./cake3
ln -s ../rdcore/login ./login
ln -s ../rdcore/AmpConf/build/production/AmpConf ./conf_dev
ln -s ../rdcore/login/rd_client/build/production/AmpConf ./usage
ln -s ../rdcore/cake3/rd_cake/setup/scripts/reporting ./reporting

# Change the ownership of the following files to www-data so Nginx can make changes to the files/directories
mkdir -p /usr/share/nginx/html/cake3/rd_cake/logs
mkdir -p /usr/share/nginx/html/cake3/rd_cake/webroot/files/imagecache
mkdir -p /usr/share/nginx/html/cake3/rd_cake/tmp
chown -R www-data. /usr/share/nginx/html/cake3/rd_cake/tmp
chown -R www-data. /usr/share/nginx/html/cake3/rd_cake/logs
chown -R www-data. /usr/share/nginx/html/cake3/rd_cake/webroot/img/realms
chown -R www-data. /usr/share/nginx/html/cake3/rd_cake/webroot/img/dynamic_details
chown -R www-data. /usr/share/nginx/html/cake3/rd_cake/webroot/img/dynamic_photos
chown -R www-data. /usr/share/nginx/html/cake3/rd_cake/webroot/img/access_providers
chown -R www-data. /usr/share/nginx/html/cake3/rd_cake/webroot/img/hardwares
chown -R www-data. /usr/share/nginx/html/cake3/rd_cake/webroot/files/imagecache  
