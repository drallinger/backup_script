#!/bin/bash
backup_path="/path/to/backup/dir"
if [ -d "$backup_path" ]; then
    timestamp=`date '+%Y-%m-%d %H:%M:%S'`
    echo "[$timestamp] Checking for existing files" >> "$backup_path/backup_job.log"
    # delete_old_files.pl -d "$backup_path" -l 6 >> "$backup_path/backup_job.log" 2>&1
    if [ $? -eq 0 ]; then
        cd /home
        home="homedir"
        timestamp=`date '+%Y-%m-%d %H:%M:%S'`
        echo "[$timestamp] Starting backup" >> "$backup_path/backup_job.log"
        timestamp=`date +%Y%m%dT%H%M%S`
        backup_file="$timestamp-backup.tar.bz2"
        tar -cjpf "$backup_path/$backup_file" \
            "$home/dir1" \
            "$home/dir2" \
            >> "$backup_path/backup_job.log" 2>&1
        if [ $? -eq 0 ]; then
            timestamp=`date '+%Y-%m-%d %H:%M:%S'`
            echo "[$timestamp] Backup complete" >> "$backup_path/backup_job.log"
        else
            timestamp=`date '+%Y-%m-%d %H:%M:%S'`
            echo "[$timestamp] Failed to create backup" >> "$backup_path/backup_job.log"
        fi
    else
        timestamp=`date '+%Y-%m-%d %H:%M:%S'`
        echo "[$timestamp] Failed to delete old files" >> "$backup_path/backup_job.log"
    fi
else
    timestamp=`date '+%Y-%m-%d %H:%M:%S'`
    echo "[$timestamp] Unable to find backup directory: $backup_path" >> backup_job.log
fi
