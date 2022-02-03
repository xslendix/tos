#!/bin/sh

echo Yes | parted /dev/sda ---pretend-input-tty 'resizepart 2 -15M'

parted /dev/sda -s unit MB print free

data="$(parted /dev/sda -s unit MB print free | tail -n 2)"
start="$(echo $data | awk '{ print $1 }')"
end="$(echo $data | awk '{ print $2 }')"

echo "Start: $start End: $end"

echo "Creating ext4 partition"
parted /dev/sda -s mkpart primary ext4 "$start" "$end"

set -e

echo "Setting boot flags"
parted /dev/sda -s set 1 boot off
parted /dev/sda -s set 2 boot off
parted /dev/sda -s set 3 boot on

echo "Formatting ext4 partition"
mkfs.ext4 /dev/sda3

echo "Mounting ext4 partition"
mount /dev/sda3 /mnt
mkdir /mnt/boot

echo "Installing GRUB"
grub-install --boot-directory=/mnt/boot --target=i386-pc --locales=en@arabic /dev/sda

cat << EOF > /mnt/boot/grub/grub.cfg
timeout=1

menuentry "TempleOS C" {
  set root=(hd0,1)
  chainloader +1
}

menuentry "TempleOS D" {
  set root=(hd0,2)
  chainloader +1
}

EOF

printf "Done! Powering off in "

printf "5... "
sleep 1
printf "4... "
sleep 1
printf "3... "
sleep 1
printf "2... "
sleep 1
printf "1... "
sleep 1

systemctl poweroff

