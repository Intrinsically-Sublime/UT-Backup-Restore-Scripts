#### Simple bash scripts to backup Ubuntu Touch home directories using ADB

Tested on Ubuntu 20.04 host and OnePlus One Bacon OTA-15

- Requires Android debug tools on linux host system
- Interative selection of directories to backup and restore
- Creates dated backups for later restoration
- Not tested for cross device restoring or restoring after updates
- Includes hidden directories but not special directories

Run
```
UT_Backup_Tool.sh
```
to make a dated backup in a folder next to the scripts.

Run
```
UT_Restore_Tool.sh
```
to selectively restore the home directories. You will get to choose the backup and which directories to restore.


