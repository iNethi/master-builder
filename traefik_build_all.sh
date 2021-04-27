#!/bin/bash

# customize with your own.
options=("jellyfin" "keycloak" "nginx(splash)")

menu() {
    echo "iNethi (Traefik) version 0.0.1 builder"
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
# Send the environmental variables to other scripts
echo export inethiDN=$domainName > ./root.conf

printf "Create docker traefik bridge: traefik-bridge ..."
echo 
#sudo docker network create --attachable -d bridge --subnet=172.19.0.0/16  inethi-bridge-traefik
#docker network create web
sudo docker network create --attachable -d bridge inethi-bridge-traefik
#
# Build traefik - compulsory docker
printf "Building Traefik docker ... "
    cd ./traefik
    ./local_build.sh
    cd ..


[[ "${choices[0]}" ]] && {
    printf "Building jellyfin docker ... "
    cd ./jellyfin-traefik
    ./local_build.sh
    cd ..
}

[[ "${choices[1]}" ]] && {
    printf "Building keycloak docker ... "
    cd ./keycloak-traefik
     ./local_build.sh
    cd ..
}

[[ "${choices[2]}" ]] && {
    printf "Building nginx(splash) docker ... "
    cd ./nginx-traefik
    ./local_build.sh
    cd ..
}
