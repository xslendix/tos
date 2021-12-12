#!/bin/sh

# Check if image already mounted
mounted="$(lsblk | grep -c 'loop.*mnt.*')"
if [ "$mounted" -eq 0 ]; then
    echo "[INFO] Partition already unmounted. Ignoring request."
    exit
fi

echo "[INFO] Syncing disks"
sudo sync
echo "[INFO] Unmounting C: partition"
sudo umount mnt/

