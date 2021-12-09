#!/bin/sh

./mount.sh

echo '[INFO] Checking if valid TempleOS installation'
if [ -d 'mnt/0000Boot' ]; then
    echo '[INFO] Installation valid. Patching OS.'
    sudo cp -rv custom/* mnt/
else
    echo '[ERROR] No valid TempleOS installation found.'
fi

