#!/bin/bash

# Set backup source and destination directories
BACKUP_SRC="/"
BACKUP_DEST="/media/nas/backups"  # Change this to your backup location
BACKUP_DATE=$(date +'%Y-%m-%d_%H-%M-%S')

# Create backup destination directory with timestamp
BACKUP_DIR="${BACKUP_DEST}/backup_${BACKUP_DATE}"
mkdir -p "$BACKUP_DIR"

# Exclude system directories that don't need to be backed up
EXCLUDES="--exclude=/proc --exclude=/sys --exclude=/dev --exclude=/tmp --exclude=/run --exclude=/mnt --exclude=/media"

# Rsync command to backup files
rsync -aAXv $EXCLUDES / "$BACKUP_DIR"

# Check if rsync was successful
if [ $? -eq 0 ]; then
  echo "Backup completed successfully."
else
  echo "Backup failed."
fi

# Compress the backup folder into a tar.gz archive
BACKUP_ARCHIVE="${BACKUP_DEST}/backup_${BACKUP_DATE}.tar.gz"
echo "Compressing backup into archive..."
tar -czf "$BACKUP_ARCHIVE" -C "$BACKUP_DEST" "backup_${BACKUP_DATE}"

# Remove the original uncompressed backup directory
rm -rf "$BACKUP_DIR"

# Confirm compression and cleanup
echo "Backup successfully compressed into: $BACKUP_ARCHIVE"
echo "Original backup directory deleted."

# Delete backups older than 30 days
echo "Deleting backups older than 30 days..."
find "$BACKUP_DEST" -maxdepth 1 -type f -name "backup_*.tar.gz" -mtime +30 -exec rm -f {} \;

# Confirm deletion of old backups
echo "Old backups deleted."
