#!/bin/bash

source ../root.conf
source ./.env

mkdir -p $RADIUSDESK_VOLUME
mkdir -p $RADIUSDESK_VOLUME/web
mkdir -p $RADIUSDESK_VOLUME/web_conf
mkdir -p $RADIUSDESK_VOLUME/db
mkdir -p $RADIUSDESK_VOLUME/db_conf
mkdir -p $RADIUSDESK_VOLUME/db_startup
mkdir -p $RADIUSDESK_VOLUME/freeradius
mkdir -p $RADIUSDESK_VOLUME/freeradius_conf

# Prepare directories for radiusdesk nginx and php
sh ./setup_radius_local.sh
cp ./default.conf $RADIUSDESK_VOLUME/web_conf

# Prepare database configuration
cp ./my_custom.cnf $RADIUSDESK_VOLUME/db_conf

# Prepare database startup files
# Note this directory will be mounted as /docker-entrypoint-initdb.d on docker - docker instance will 
# execute all sql files in this directory the first time in alphabetical order
cp $RADIUSDESK_VOLUME/web/rdcore/cake3/rd_cake/setup/db/rd.sql $RADIUSDESK_VOLUME/db_startup
cp ./db_priveleges.sql $RADIUSDESK_VOLUME/db_startup

# Prepare files for freeradius
# See Dockerfile-freeradius - custome image built for freeradius
# tar xzf $RADIUSDESK_VOLUME/web/rdcore/cake3/rd_cake/setup/radius/freeradius-3-radiusdesk.tar.gz -C $RADIUSDESK_VOLUME/freeradius --strip-components=1
# cp ./freeradius.service $RADIUSDESK_VOLUME/freeradius_conf


sed  -i '' 's/server = \"localhost\"/server = \"rdmariadb\"/g'  ./freeradius/mods-available/sql 


docker-compose config
docker-compose build
docker-compose up -d