#!/bin/bash
backup_path="/path/to/backup/dir"
if [ -d $backup_path ]; then
    cd /home
    home="homedir"
    timestamp=`date '+%Y-%m-%d %H:%M:%S'`
    echo "[$timestamp] Starting backup" >> "$backup_path/backup_job.log"
    timestamp=`date +%Y%m%dT%H%M%S`
    backup_file="$timestamp-backup.tar.bz2"
    tar -cjpf "$backup_path/$backup_file" \
        "$home/Desktop" \
        "$home/Documents" \
        "$home/other_dir"
        &>> "$backup_path/backup_job.log"
    if [ $? -eq 0 ]; then
        timestamp=`date '+%Y-%m-%d %H:%M:%S'`
        echo "[$timestamp] Backup complete" >> "$backup_path/backup_job.log"
    else
        timestamp=`date '+%Y-%m-%d %H:%M:%S'`
        echo "[$timestamp] Failed to create backup" >> "$backup_path/backup_job.log"
    fi
else
    timestamp=`date '+%Y-%m-%d %H:%M:%S'`
    echo "[$timestamp] Unable to find backup directory: $backup_path" >> backup_job.log
fi

