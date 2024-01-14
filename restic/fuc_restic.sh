#!/bin/bash
# Date: 13.01.2024 (DD-MM-YYYY)
# Author: Steve Kunze, Ger, 15344 Strausberg
# Discription: Restic Menue based on freequently used commands
# Script_Name: fuc_restic (fuc = frequently used commands)


function_snapshots () { 
        #List snapshot    
        restic -r sftp:hsb:Restic-Backup-Nextcloud --password-file /home/admin/.restic-hetzner-file snapshots     
}

function_backup () {
        #Syntax is restic -r (r = repository) (protokol):name_off_.ssh/config_file backup SourcePath compression(off,auto,max)
        restic -r sftp:hsb:Restic-Backup-Nextcloud --password-file /home/admin/.restic-hetzner-file backup /mnt/truenasshare/ --compression=max
}

funcktion_quickcheck () {
        #qick health check
        restic -r sftp:hsb:Restic-Backup-Nextcloud --password-file /home/admin/.restic-hetzner-file check
}

funcktion_check () {    
        # full health check 
        restic -r sftp:hsb:Restic-Backup-Nextcloud --password-file /home/admin/.restic-hetzner-file check --read-data
}

function_listfilesofselectedsnapshot () {
        function_snapshots
        # full health check 
        read -p "Enter Snapshot ID: " ID
        restic -r sftp:hsb:Restic-Backup-Nextcloud --password-file /home/admin/.restic-hetzner-file ls $ID | less 
}

PS3='Choose a Task: '
select task in backup snapshots quick_check full_check list_files; 
do 
    case $task in 
        backup) 
                function_backup
                ;; 
        snapshots)
                function_snapshots
                ;;
        quick_check)
                funcktion_quickcheck
                ;;
        full_check) 
                funcktion_check
                ;;
        list_files)
                function_listfilesofselectedsnapshot
                ;;        
        Quit)
                echo "Bye!"
                break 
        ;;
        *) echo "invalid opton $Reply"
        ;;
        esac 
done
