# Server-Backup-Script

# 🗄️ Backup Script

This Bash script performs a system backup using `rsync`, compresses the backup into a `.tar.gz` archive,<br>
and manages old backups by deleting archives older than 30 days.<br>
You can also set a cronjob such as "0 0 * * 0 /home/mirage/scripts/backup.sh" to have it run every Sunday.

## 🚀 Features

- Backs up the entire system (`/` directory) except for temporary and unnecessary system directories.
- Stores the backup in a timestamped directory.
- Compresses the backup into a `.tar.gz` archive to save space.
- Deletes backup archives older than 30 days to manage storage.

--------------------------------------------------------------------
## 🔧 Configuration
The **only thing you need to change** is the backup destination path:

```bash
BACKUP_DEST="/media/nas/backups"
```
Replace this with the path where you want your backups to be stored.
--------------------------------------------------------------------

## 📁 Excluded Directories

To avoid issues and unnecessary files, the script excludes the following directories from the backup:

- `/proc`
- `/sys`
- `/dev`
- `/tmp`
- `/run`
- `/mnt`
- `/media`

## 🛠 How It Works

1. Creates a timestamped backup directory at the destination.
2. Uses `rsync` to copy the system files, excluding unnecessary directories.
3. Compresses the backup directory into a `.tar.gz` file.
4. Deletes the uncompressed backup directory.
5. Finds and deletes backup archives older than 30 days.

## ✅ Example Output

```bash
Backup completed successfully.
Compressing backup into archive...
Backup successfully compressed into: /your/destination/backup_2025-04-05_13-30-00.tar.gz
Original backup directory deleted.
Deleting backups older than 30 days...
Old backups deleted.
```
