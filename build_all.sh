#!/bin/bash

# customize with your own.
sudo mkdir -p /mnt/data
options=("jellyfin" "keycloak" "nginx(splash)" "moodle" "nextcloud" "wordpress" "unifi" "radiusdesk")
entrypoint=web

menu() {
    echo "iNethi (Traefik) version 0.1.0 builder"
    echo
    echo "Avaliable options:"
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

# Select domain namec
read -p 'Doman name: ' domainName

# Select https or http
echo "Do you wish to deploy a secure site with https?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) entrypoint=websecure; break;;
        No ) entrypoint=web; break;;
    esac
done

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
    echo API keys are needed to setup https certificates
    if test -f traefikssl/secrets/secret_keys.env; then
        echo API key file exists
        cat traefikssl/secrets/secret_keys.env
    else
        read -p 'AWS_ACCESS_KEY_ID: '  AWS_ACCESS_KEY_ID
        read -p 'AWS_SECRET_ACCESS_KEY: ' AWS_SECRET_ACCESS_KEY
        read -p 'AWS_HOSTED_ZONE_ID: ' AWS_HOSTED_ZONE_ID
        echo AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID > traefikssl/secrets/secret_keys.env
        echo AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY >> traefikssl/secrets/secret_keys.env
        echo AWS_HOSTED_ZONE_ID=$AWS_HOSTED_ZONE_ID >> traefikssl/secrets/secret_keys.env
    fi
else
    echo You chose insecure Domain Name: http://$domainName
fi
echo
printf "Starting to build dockers ... "
echo

# # Send the environmental variables to other scripts
echo export inethiDN=$domainName > ./root.conf
echo export TRAEFIK_ENTRYPOINT=$entrypoint >> ./root.conf

printf "Create docker traefik bridge: traefik-bridge ..."
echo
sudo docker network create --attachable -d bridge inethi-bridge-traefik

printf "Pulling dnsmasq and traefik..."
echo

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
    printf "Building jellyfin docker ... "
    cd ./jellyfin
    ./local_build.sh
    cd ..
}

[[ "${choices[1]}" ]] && {
    printf "Building keycloak docker ... "
    cd ./keycloak
     ./local_build.sh
    cd ..
}

[[ "${choices[2]}" ]] && {
    printf "Building nginx(splash) docker ... "
    cd ./nginx-splash
    ./local_build.sh
    cd ..
}

[[ "${choices[3]}" ]] && {
    printf "Building Moodle docker ... "
    cd ./moodle
    ./local_build.sh
    cd ..
}


[[ "${choices[4]}" ]] && {
    printf "Building Nextcloud docker ... "
    cd ./nextcloud
    ./local_build.sh
    cd ..
}

[[ "${choices[5]}" ]] && {
    printf "Building wordpress docker ... "
    cd ./wordpress
    ./local_build.sh
    cd ..
}

[[ "${choices[6]}" ]] && {
    printf "Building Unifi Controller docker ... "
    cd ./unificontroller
    ./local_build.sh
    cd ..
}

[[ "${choices[7]}" ]] && {
    printf "Building Radiusdesk docker ... "
    cd ./radiusdesk
    ./local_build.sh
    cd ..
}
