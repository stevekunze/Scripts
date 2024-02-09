#!/bin/bash
# Date: 13.01.2024 (DD-MM-YYYY)
# Author: Steve Kunze, Ger, 15344 Strausberg
# Discription: create a ed25519 ssh key-pair and push the publickey to a remote server
# Script_Name: create_ed25519_and_push.sh

# create a ssh key with ed25519
read -p "enter your desired filenamesufix: " keyname
ssh-keygen -t ed25519 -f ~/.ssh/ed25519_$keyname.key
#show  created files
ls -lah /home/$USER/.ssh | grep $keyname
#enter ssh user
read -p "enter your ssh-username: " sshuser
#enter ip of remote server 
read -p "enter the ip of your remote server: " remote_ip
# copy created publickey to /home/$USER/.ssh/
ssh-copy-id -i /home/$USER/.ssh/ed25519_$name.key $sshuser@$remote_ip
