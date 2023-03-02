#!/bin/bash

# This script would delete all the files from a specific path
# The goal is to use this script with crontab to run it periodically
# and avoid filling up the disk
# This script will be used to delete log files generated by VCC

# Version Specific Comments#
# It sends an email with the summary of the deletion process
# The email is sent using msmtp: https://wiki.debian.org/msmtp
# The script stores the result of each file deletion effort on the BODY variable
# The BODY variable is then passed to msmtp to send the email

RECEIVER="john@doe.com"
SUBJECT="Server notifications"
file_location="/tmp/file-$(date +"%Y%m%d%H%M%S").log"
BODY="Cleaning /var/crash folder:"$'\n\n'

for f in $(find /var/crash/* -type f -mmin +2)
  do
    logger "Trying to delete: $f"
    rm $f
    if [ $? -eq 0 ]; then
      logger "SUCCESS deleting file $f"
      NOW=$(date +"%Y-%m-%d %T")
      BODY+="$NOW: Success deleting file $f"$'\n'
    else
      logger "ERROR deleting file $f"
      NOW=$(date +"%Y-%m-%d %T")
      BODY+="$NOW: ERROR deleting file $f"$'\n'
    fi
  done

cat > $file_location << EOF
To: $RECEIVER
Subject: $SUBJECT

$BODY
EOF


cat $file_location | msmtp -t
rm $file_location
