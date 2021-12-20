#!/bin/bash

# customize with your own.
sudo mkdir /mnt/data
options=("jellyfin" "keycloak" "nginx(splash)" "moodle" "nextcloud" "wordpress" "unifi")

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

# # Select domain namec
read -p 'Doman name: ' domainName


printf "You selected"; msg=" nothing"
for i in ${!options[@]}; do
    [[ "${choices[i]}" ]] && {
        printf " %s" "[${options[i]}]"; msg="";
    }
done

echo "$msg"
echo You chose Domain Name: $domainName
echo
printf "Starting to build dockers ... "
echo

# # Send the environmental variables to other scripts
echo export inethiDN=$domainName > ./root.conf

printf "Create docker traefik bridge: traefik-bridge ..."
echo
sudo docker network create --attachable -d bridge inethi-bridge-traefik

printf "Pulling dnsmasq and traefik..."
echo

# Build traefik - compulsory docker
printf "Building Traefik and dnsmasq docker... "
    cd ./traefik
    ./local_build.sh
    cd ..

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
    cd ./unifi
    ./local_build.sh
    cd ..
}
