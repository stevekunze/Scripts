#!/bin/bash
# Date: 13.01.2024 (DD-MM-YYYY)
# Author: Steve Kunze, Ger, 15344 Strausberg
# Discription: restic backup script with max compression enabled. sends backup to hetzner cloud storage and checks the repository for errors. It saves the results in a file and sends those to gotify 
# Script_Name: daily restic backup   

# restic backup script with max compression enabled. sends backup to hetzner cloud storage
restic -r sftp:hsb:Restic-Backup-Nextcloud --password-file /home/admin/restic/.restic-hetzner-file backup /mnt/truenasshare/ --compression=max > rlog.txt
#formatting with line breaks and dashes for better formatting
echo >> rlog.txt
echo '----------------' >> rlog.txt
echo >> rlog.txt
#short health check and append result in rlog.txt | if you want to run more in depth check append option --read-data
restic -r sftp:hsb:Restic-Backup-Nextcloud --password-file /home/admin/restic/.restic-hetzner-file check >> rlog.txt
#save output of rlog.txt in variable called "result"
result="$(cat rlog.txt)"
# Send to gotify
curl "https://gotify.famkunze.eu/message?token=GOTIFYAPITOKEN" -F "title=Restic Cloud backup finished" -F "message=$result" -F "priority=1"
