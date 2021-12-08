#!/bin/sh

./umount.sh
qemu-system-x86_64 -enable-kvm -m 2G -hda tos.img -smp cores=8,threads=1,sockets=1 -display gtk,zoom-to-fit=on

