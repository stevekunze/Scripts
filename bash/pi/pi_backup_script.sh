#!/bin/bash
# Date: 13.01.2024 (DD-MM-YYYY)
# Author: Steve Kunze, Ger, 15344 Strausberg
# Discription: Does a backuo if the entire sd card moves the old backup and deletes them once the new backup was created
# Script_Name: fuc_restic (fuc = frequently used commands)

# move to smbshare path
cd /home/steve/mnt/smbshare/
# create a folder called "oldbackup"
mkdir oldbackup
# find a any img file and move it to the created folder 
find . -name *.img -exec mv '{}' "oldbackup/" ";"
#go back to parent directory
cd /home/steve/mnt/smbshare/
#create full img of Raspberry Pi SD Card
dd bs=4M if=/dev/mmcblk0 of=/home/steve/mnt/smbshare/$(date+"%FT%T")-pibackup.img/
# move to oldbackup folder 
cd /home/steve/mnt/smbshare/
# delete old folder 
rm -rf oldbackup
