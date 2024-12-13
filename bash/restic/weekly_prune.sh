restic -r sftp:hsb:Restic-Backup-Nextcloud --password-file /home/admin/restic/.restic-hetzner-file forget \
--keep-daily 14 \
--keep-weekly 4 \
--keep-monthly 6 \
--keep-yearly 1 \
--prune > prunelog.txt
