#!/bin/bash
echo
echo "Welcome to the iNethi builder system for Ubuntu"
sleep 1
# Detect OS
# 1 = LINUX
# 2 = MACOS
myos=1
res=$(echo $OSTYPE)
res3=${res:0:3}
if [ "$res3" = "dar" ]; then
    myos=2
    echo "Operating System discovered: MACOSX"
else
    echo "Operating System discovered: LINUX"
fi



# install all dependencies
echo "Docker and Docker compose are needed to build this system (note docker needs to be able to run as non-root)"
sleep 2
echo "Do you wish to set this up now? (Yes=1/No=2)"
select yn in "Yes" "No"; do
    case $yn in
        Yes )   sudo apt-get update || exit 1;
                sudo apt-get install -y \
                   ca-certificates \
                   curl \
                   gnupg \
                   lsb-release || exit 1;

                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg || exit 1;

                echo \
                    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
                    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || exit 1;

                sudo apt-get update || exit 1;
                # For Raspberry PI
                echo "Is this a Raspberry PI setup (Yes=1/No=2)"
                select yn in "Yes" "No"; do
                    case $yn in
                        Yes )   curl -fsSL https://get.docker.com -o get-docker.sh || exit 1
                                sudo sh get-docker.sh || exit 1
                                break;;
                        No )    sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin || exit 1;
                                break;;
                    esac
                done
                sudo apt-get -y install docker-compose || exit 1;

                # Make docker run as non root
                sudo usermod -aG docker $USER || echo "Cannot change permissions..."; exit 1;
                sudo chmod 666 /var/run/docker.sock; echo "Please restart your machine now and rerun the script"; sleep 5; exit 0; break;;
        No ) echo; break;;
    esac
done

# customize with your own.
STORAGE_FOLDER=/mnt/data
echo "/mnt/data is set as the main storage directory"
echo "Do you wish to change this? (Yes=1/No=2)"
select yn in "Yes" "No"; do
    case $yn in
        Yes )  read -p 'storage folder: '  STORAGE_FOLDER; break;;
        No ) echo "Default storage folder selected"; break;;
    esac
done
echo "$STORAGE_FOLDER" "is being used as the storage folder"
sudo mkdir -p "$STORAGE_FOLDER"
sleep 2
# make sure all future data in this folder can be created as non root
if [ "$myos" = 1 ]; then
    sudo chown  $USER:$USER "$STORAGE_FOLDER" || exit 1;
else
    sudo chown  $USER:staff "$STORAGE_FOLDER" || exit 1;
fi

## NOTES

options=("Nginx-Splash" "Keycloak" "Nextcloud" "Jellyfin" "Wordpress" "Payment and User Management")
entrypoint=web
echo
menu() {
    echo "iNethi version 0.1.0 builder"
    echo "Available options:"
    for i in ${!options[@]}; do
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
    done
    if [[ "$msg" ]]; then echo "$msg"; fi
}

prompt="Select which iNethi components you want (again to uncheck, ENTER when done): "
while menu && read -rp "$prompt" num && [[ "$num" ]]; do
    [[ "$num" != *[![:digit:]]* ]] &&
    (( num > 0 && num <= ${#options[@]} )) ||
    { msg="Invalid option: $num"; continue; }
    ((num--));
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
done


echo
echo Set General master secure password for all services
read -p 'master password: '  MASTER_PASSWORD



# Select default email address
read -p 'Default email address: ' emailAddress


# Select https or http
echo "Do you wish to deploy a secure site with https?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) entrypoint=websecure; break;;
        No ) entrypoint=web; break;;
    esac
done

# Check if using default domain


echo "Do you wish to use the default iNethi domain: inethilocal.net?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) defaultDomain=1; domainName=inethilocal.net; wget https://splash.inethicloud.net/acme.json -P ./my-certificates; break;;
        No ) defaultDomain=0; read -p 'Domain name: ' domainName; break;;
    esac
done

if [ "$defaultDomain" = 0 ];
then
  echo "You are using a custom domain"
  echo "Please ensure your acme.json file is in the ./my-certificates/ folder..."
  echo "Is your file present? (yes=1/no=2)"
  select yn in "Yes" "No"; do
      case $yn in
          Yes ) echo "Your domain is "; echo "$domainName"; break;;
      esac
  done
  if test -f ./my-certificates/acme.json; then
    echo "acme.json exists"
  else
    echo "ERROR: acme.json does not exist"
    exit 1
  fi
else
  echo "You are using the default iNethi domain"
fi


echo "Would you like iNethi to run a DNS to redirect hosts to your inethi domain"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) installDNS=1; break;;
        No ) installDNS=0; break;;
    esac
done

echo
printf "You selected"; msg=" nothing"
for i in ${!options[@]}; do
    [[ "${choices[i]}" ]] && {
        printf " %s" "[${options[i]}]"; msg="";
    }
done


echo "$msg"

if [ "$entrypoint" = websecure ]; then
    echo You chose secure Domain Name: https://$domainName
    echo

    if test -f traefikssl/secrets/secret_keys.env; then
        echo API key file exists
        cat traefikssl/secrets/secret_keys.env
    else
    	if [ "$defaultDomain" = 1 ]; then
	    AWS_ACCESS_KEY_ID=xxx
	    AWS_SECRET_ACCESS_KEY=xxx
	    AWS_HOSTED_ZONE_ID=xxx
    	else
            echo API keys are needed to setup https certificates
            read -p 'AWS_ACCESS_KEY_ID: '  AWS_ACCESS_KEY_ID
            read -p 'AWS_SECRET_ACCESS_KEY: ' AWS_SECRET_ACCESS_KEY
            read -p 'AWS_HOSTED_ZONE_ID: ' AWS_HOSTED_ZONE_ID
	fi
        mkdir -p ./traefikssl/secrets/
        echo AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID > ./traefikssl/secrets/secret_keys.env
        echo AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY >> ./traefikssl/secrets/secret_keys.env
        echo AWS_HOSTED_ZONE_ID=$AWS_HOSTED_ZONE_ID >> ./traefikssl/secrets/secret_keys.env
    fi
else
    echo You chose insecure Domain Name: http://$domainName
fi

echo
printf "Starting to build dockers ... "
echo
sleep 1

# Send the environmental variables to other scripts
echo export inethiDN=$domainName > ./root.conf
echo export TRAEFIK_ENTRYPOINT=$entrypoint >> ./root.conf
echo export email=$emailAddress >> ./root.conf

printf "Create docker traefik bridge: traefik-bridge ..."
echo
docker network create --attachable -d bridge inethi-bridge-traefik

# Build traefik - compulsory docker

[ "$entrypoint" = websecure ] && {
    printf "Building Traefik docker... "
        cd ./traefikssl
        ./local_build.sh
        cd ..
}

[ "$entrypoint" = web ] && {
    printf "Building Traefik docker... "
        cd ./traefik
        ./local_build.sh
        cd ..
}




[[ "${choices[0]}" ]] && {
    printf "Building nginx(splash) docker ... "
    splash_storage="NGINX_VOLUME=${STORAGE_FOLDER}/nginx"
    echo export $splash_storage >> ./root.conf || exit 1
    cd ./nginx-splash
    ./local_build.sh
    cd ..
}

[[ "${choices[1]}" ]] && {
    printf "Building keycloak docker ... with admin user and inethi user"
    my_sql_storage="MYSQLDB_VOLUME=${STORAGE_FOLDER}/mysql_keycloak"
    mysql_root_pass="KEYCLOAK_ADMIN_PASSWORD=${MASTER_PASSWORD}"
    mysql_pass="KEYCLOAK_PASSWORD=${MASTER_PASSWORD}"
    mysql_storage="MYSQLDB_VOLUME=${STORAGE_FOLDER}/keycloak"
    echo export $mysql_storage >> ./root.conf || exit 1
    echo export $mysql_root_pass >> ./root.conf || exit 1
    echo export $mysql_pass >> ./root.conf || exit 1

    cd ./keycloak
    ./local_build.sh
    cd ..
}

[[ "${choices[2]}" ]] && {
    printf "Building Nextcloud docker ... "
    # Set passwords for Nextcloud
    mkdir -p ./nextcloud/secrets
    echo export MYSQL_ROOT_PASSWORD=$MASTER_PASSWORD > ./nextcloud/secrets/secret_passwords.env
    echo export MYSQL_PASSWORD=$MASTER_PASSWORD >> ./nextcloud/secrets/secret_passwords.env

    nextcloud_volume="NEXTCLOUD_VOLUME=${STORAGE_FOLDER}/nextcloud"
    mysql_volume="MYSQL_VOLUME=${STORAGE_FOLDER}/nextcloud-mysql"
    share_volume="NEXTCLOUD_SHARE_VOLUME=${STORAGE_FOLDER}/share"
    rshare_volume="NEXTCLOUD_RSHARE_VOLUME=${STORAGE_FOLDER}/share/Rshare"
    rvideo_volume="NEXTCLOUD_RVIDEO_VOLUME=${STORAGE_FOLDER}/share/Rvideo"
    rphoto_volume="NEXTCLOUD_RPHOTO_VOLUME=${STORAGE_FOLDER}/share/Rphoto"
    rmusic_volume="NEXTCLOUD_RMUSIC_VOLUME=${STORAGE_FOLDER}/share/Rmusic"
    echo export $nextcloud_volume >> ./root.conf || exit 1
    echo export $mysql_volume >> ./root.conf || exit 1
    echo export $rshare_volume >> ./root.conf || exit 1
    echo export $share_volume >> ./root.conf || exit 1
    echo export $rvideo_volume >> ./root.conf || exit 1
    echo export $rphoto_volume >> ./root.conf || exit 1
    echo export $rmusic_volume >> ./root.conf || exit 1

    cd ./nextcloud
    ./local_build.sh
    cd ..
}

[[ "${choices[3]}" ]] && {
    printf "Building Jellyfin docker ... "

    jellyfin_volume="JELLYFIN_VOLUME=${STORAGE_FOLDER}/jellyfin"
    rshare_volume="NEXTCLOUD_RSHARE_VOLUME=${STORAGE_FOLDER}/share/Rshare"
    rvideo_volume="NEXTCLOUD_RVIDEO_VOLUME=${STORAGE_FOLDER}/share/Rvideo"
    rphoto_volume="NEXTCLOUD_RPHOTO_VOLUME=${STORAGE_FOLDER}/share/Rphoto"
    rmusic_volume="NEXTCLOUD_RMUSIC_VOLUME=${STORAGE_FOLDER}/share/Rmusic"
    echo export $jellyfin_volume >> ./root.conf || exit 1
    echo export $rshare_volume >> ./root.conf || exit 1
    echo export $rvideo_volume >> ./root.conf || exit 1
    echo export $rphoto_volume >> ./root.conf || exit 1
    echo export $rmusic_volume >> ./root.conf || exit 1

    cd ./jellyfin
    ./local_build.sh
    cd ..
}

[[ "${choices[4]}" ]] && {
    printf "Building wordpress docker ... "

    wordpress_volume="WORDPRESS_MOUNT=${STORAGE_FOLDER}/wordpress"
    mariadb_volume="MARIADB_MOUNT=${STORAGE_FOLDER}/wordpress-mariadb"
    db_pass="WORDPRESS_DB_PASSWORD=${MASTER_PASSWORD}"
    mysql_pass="MYSQL_ROOT_PASSWORD=${MASTER_PASSWORD}"
    echo export $wordpress_volume >> ./root.conf || exit 1
    echo export $mariadb_volume >> ./root.conf || exit 1
    echo export $db_pass >> ./root.conf || exit 1
    echo export $mysql_pass >> ./root.conf || exit 1

    cd ./wordpress
    ./local_build.sh
    cd ..
}

[[ "${choices[5]}" ]] && {
    printf "Building Radiusdesk docker ... "
    rd_volume="RADIUSDESK_VOLUME=${STORAGE_FOLDER}/radiusdesk"
    echo export $rd_volume >> ./root.conf || exit 1
    cd ./radiusdesk_2docker
    ./local_build.sh
    cd ..

    django_volume="DJANGO_MNT=${STORAGE_FOLDER}/user_management"
    mysql_volume="MYSQL_MANAGEMENT_MNT=${STORAGE_FOLDER}/management-mysql"
    echo export $django_volume >> ./root.conf || exit 1
    echo export $mysql_volume >> ./root.conf || exit 1
    cd ./inethi-management-system
    cd ./inethi_management
    ./local_build.sh
    cd ./inethi_management
    read -p 'Please set the cost of a 30 minute voucher: '  TIME30M
    read -p 'Please set the cost of a 1 hour voucher: ' TIME1H
    read -p 'Please set the cost of a 24 hour voucher: ' TIME24H
    read -p 'Please set the cost of a 1GB voucher: ' DATA1G
    PACKAGE_MAP="PriceToPackageMap = {$TIME30M: ['TIME30M', 1800, '1W'], $TIME1H: ['TIME1H', 3600, '2W'], $TIME24H: ['TIME24H', 86400, '1M'], $DATA1G: ['DATA1G', 2592000, '3M']}"
    # echo $PACKAGE_MAP
    sed -i "14s/.*/${PACKAGE_MAP//\'/\\\'}/" views.py
    cd ../../..
    cd payments/services/web/endpoints
    AMOUNT="        amount=$TIME30M"
    sed -i "50s/.*/${AMOUNT}/" redeem.py
    AMOUNT="        amount=$TIME1H"
    sed -i "52s/.*/${AMOUNT}/" redeem.py
    AMOUNT="        amount=$TIME24H"
    sed -i "54s/.*/${AMOUNT}/" redeem.py
    AMOUNT="        amount=$DATA1G"
    sed -i "59s/.*/${AMOUNT}/" redeem.py
    cd ../../..
    echo "We will set up you Internet sales default payment limits now."
    echo "How often do you want the default limit to reset (in seconds)?"
    read -p "Reset after: "  DURATION
    read -p "How much can a user spend in this time limit (in units)? " PAYMENT_LIMIT
    echo "Your time limit is $DURATION seconds and your spending limit is $PAYMENT_LIMIT"
    echo "Updating database..."
    VALUES="1, 4, $PAYMENT_LIMIT, $DURATION"
    docker exec -it inethi-user-management-mysql mysql inethi-user-management-api -e "INSERT INTO inethi_management_servicetypes (description, pay_type, service_type_id) VALUES ('Internet', 1, 1);"
    docker exec -it inethi-user-management-mysql mysql inethi-user-management-api -e "INSERT INTO inethi_management_defaultpaymentlimits (service_type_id, payment_method, payment_limit, payment_limit_period_sec) VALUES ($VALUES);"
    echo "Done"
}



# Install DNS system last - TODO add a check to see if it works otherwise reverse changes
[ "$installDNS" = 1 ] && {
    printf "Building iNethi DNS ... "
        cd ./dnsmasq
        if [ "$myos" = 1 ]; then
            ./local_build.sh
        else
            ./local_build_mac.sh
        fi

        cd ..
}
