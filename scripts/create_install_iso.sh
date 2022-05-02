#!/bin/sh

if ! command -v mkarchiso &> /dev/null ; then
    echo '[WARN] Archiso not detected. Second stage installer is now disabled'
    exit
fi

force=0

set -e

if [ "$1" = "force" ]; then
    force=1
fi

if ! [ -f 'installer.iso' ] || [ "$force" -eq 1 ]; then
    echo '[INFO] Removing archiso work directory.'

    sudo rm -rf archiso_workdir
    mkdir archiso_workdir

    echo '[INFO] Running mkarchiso.'
    sudo mkarchiso -v -w archiso_workdir -o archiso_outdir archlive

    echo '[INFO] Moving installer ISO.'
    sudo chown -R $USER: archiso_outdir/
    mv -v archiso_outdir/*.iso installer.iso

fi

echo '[INFO] Starting 2nd stage installer virtual machine.'
qemu-system-x86_64 -enable-kvm -m 5G -hda tos.img -cdrom installer.iso -boot d

