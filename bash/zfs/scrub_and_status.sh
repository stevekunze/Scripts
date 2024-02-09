#!/bin/bash
# Date: 20.01.2024 (DD-MM-YYYY)
# Author: Steve Kunze, Ger, 15344 Strausberg
# Discription: does a scrub task and checks the zpool status. sends the restults to Gotify
# Script_Name: scrub_and_status
zpool scrub rpool
zpoolstatus="$(zpool status rpool)"
curl "https://gotify.famkunze.eu/message?token=GOTIFYAPITOKEN" -F "title=PVE Zpool Scrub and Zpool status" -F "message=Scub Job done $zpoolstatus" -F "priority=5"
