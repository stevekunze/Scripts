#!/bin/bash
# Date: 20.01.2024 (DD-MM-YYYY)
# Author: Steve Kunze, Ger, 15344 Strausberg
# Discription: Does S.M.A.R.T tests and sends the restults to gotify
# Script_Name: smart_report.sh

sda="$(smartctl -q errorsonly /dev/sda)"
sdb="$(smartctl -q errorsonly /dev/sdb)"
sdc="$(smartctl -q errorsonly /dev/sdc)"
sdd="$(smartctl -q errorsonly /dev/sdd)"
nvme="$(smartctl -q errorsonly /dev/nvme0n1)"
curl "https://gotify.famkunze.eu/message?token=GOTIFYAPITOKEN" -F "title=PVE SMART REPORT" -F "message=Detected SMART errors on the following disks: $sda $sdb $sdc $sdd $nvme" -F "priority=5"
