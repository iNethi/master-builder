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
echo Pulling up user management MYSQL service ....
docker-compose up -d inethi-user-management-mysql
sleep 30
echo Pulling up user management API ....
docker-compose up -d inethi-user-management-api
sleep 30
echo Carrying out database migrations ....
docker exec -it inethi-user-management-api python manage.py makemigrations inethi_management
docker exec -it inethi-user-management-api python manage.py migrate
echo ALL DONE!