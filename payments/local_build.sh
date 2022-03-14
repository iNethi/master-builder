source ../root.conf
source ./.env
source ./secrets/secret_passwords.env
mkdir -p $PAYMENTAPI_VOLUME_DEV
mkdir -p $PAYMENTAPI_VOLUME_PROD
mkdir -p $VOUCHER_VOLUME/html/
cp -r ./services/web/* $PAYMENTAPI_VOLUME_DEV
cp -r ./webtest/* $VOUCHER_VOLUME/html/


#docker-compose config
#docker-compose up -d --build

#docker-compose -f docker-compose.prod.yml config

#docker-compose config
#docker-compose -f docker-compose.yml  up  -d --build
docker-compose -f docker-compose-prod.yml  up  -d --build 



