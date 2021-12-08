#!/bin/sh

# Check if image already mounted
mounted="$(lsblk | grep -c 'loop0')"
if [ "$mounted" -ne 0 ]; then
    echo "[INFO] Partition already mounted. Ignoring request."
    exit
fi

echo "[INFO] Mounting C: partiton"
sudo mount -o loop,offset=32256 ./tos.img mnt/

