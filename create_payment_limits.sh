#!/bin/bash

echo
echo "Welcome to the iNethi builder system. This script will help you set up default payment limits for Internet vouchers"
sleep 1
echo
echo "RadiusDesk needs to be set up before running this script for the system to work as a whole."
sleep 2
echo
echo "Have you set RadiusDesk up? (Yes=1/No=2)"
select yn in "Yes" "No"; do
    case $yn in
        Yes )  echo "We will set up you Internet default payment limits now."
               echo "How often do you want the default limit to reset (in seconds)?"
               read -p "Reset after: "  DURATION
               read -p "How much can a user spend in this time limit (in units)? " PAYMENT_LIMIT
               break ;;

        No ) echo "Please set up RadisuDesk as per instructions in the build manual and then run this script."; sleep 2;  exit 1 ;;
    esac
done

echo "Your time limit is $DURATION seconds and your spending limit is $PAYMENT_LIMIT"

echo "Updating database..."

VALUES="1, 4, $PAYMENT_LIMIT, $DURATION"

docker exec -it inethi-user-management-mysql mysql inethi-user-management-api -e "INSERT INTO inethi_management_defaultpaymentlimits (service_type_id, payment_method, payment_limit, payment_limit_period_sec) VALUES ($VALUES);"

echo "Done"


