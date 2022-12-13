#!/bin/bash
source ../../root.conf
source ./.env
mkdir -p $DJANGO_MNT
mkdir -p $MYSQL_MANAGEMENT_MNT
mkdir -p $DJANGO_MNT/app
cp ./manage.py $DJANGO_MNT/app
cp ./package.json $DJANGO_MNT/app
cp ./requirements.txt $DJANGO_MNT/app
cp -r ./inethi_management $DJANGO_MNT/app
docker-compose config
docker-compose up -d