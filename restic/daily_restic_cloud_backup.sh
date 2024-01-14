#!/bin/bash
# Date: 13.01.2024 (DD-MM-YYYY)
# Author: Steve Kunze, Ger, 15344 Strausberg
# Discription: Restic Backup Script with max Compression enabled. Sends Backup to Hetzner Cloud Storage and checks the repository for errors. It saves the results in a file and sends those to gotify 
# Script_Name: Daily Restic Backup   



# Syntax is restic -r (r = repository) (protokol):name_off_.ssh/config_file backup SourcePath compression(off,auto,max) and save restults in rlog.txt 
restic -r sftp:hsb:Restic-Backup-Nextcloud --password-file /home/admin/.restic-hetzner-file backup /mnt/truenasshare/ --compression=max > rlog.txt
#short health check and append result in rlog.txt | if you want to run more in depth check append option --read-data 
restic -r sftp:hsb:Restic-Backup-Nextcloud --password-file /home/admin/.restic-hetzner-file check >> rlog.txt
#save output of rlog.txt in cariable called "result"
result="$(cat rlog.txt)"
# Send to gotify
curl "https://gotify.famkunze.eu/message?token=GOTIFYAPITOKEN" -F "title=Restic Cloud backup finished" -F "message=$result" -F "priority=1"
