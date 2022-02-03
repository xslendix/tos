#!/bin/sh

QEMU_FLAGS="-smp cores=$(nproc),threads=1,sockets=1 -m 2G -drive file=tos.img,index=0,media=disk,format=raw -serial telnet:localhost:4321,server,nowait"

if [ -e "/dev/kvm" ]; then
    QEMU_FLAGS="-enable-kvm $QEMU_FLAGS"
fi

if [ "$1" = "vnc" ]; then
    QEMU_FLAGS="$QEMU_FLAGS -vnc :0"
else
    QEMU_FLAGS="$QEMU_FLAGS -display gtk,zoom-to-fit=on"
fi

if [ ! -f tos.img ]; then
    echo '[WARNING] No TempleOS image file found. Detecting if ISO image downloaded.'
    tos_file=""
    for i in ~/Downloads ~/Download ~/Documents ~/Document /tmp; do
        tos_file="$(find "$i" -name TempleOS.ISO 2>/dev/null)"
    done

    if [ -z "$tos_file" ]; then
        method=""
        if command -v curl &>/dev/null; then
            method=curl
        elif command -v wget &>/dev/null; then
            method=wget
        fi

        if [ -z "$method" ]; then
            echo "[ERROR] No curl or wget installed. Cannot automatically download ISO."
            exit 1
        fi

        echo "[WARNING] TempleOS ISO image not found. Downloading using $method"
        case "$method" in
            curl)
                curl -L -o /tmp/TempleOS.ISO https://templeos.org/Downloads/TempleOS.ISO
                ;;
            wget)
                wget -O /tmp/TempleOS.ISO https://templeos.org/Downloads/TempleOS.ISO
                ;;
        esac

        tos_file='/tmp/TempleOS.ISO'

        if [ ! -f "$tos_file" ]; then
            echo "[ERROR] Download failure using $method. Exiting..."
            exit 1
        fi
    else
        echo "[INFO] ISO detected: $tos_file"
    fi

    echo '[INFO] Creating virtual HDD'
    qemu-img create tos.img 2G

    echo '[INFO] Starting 1st stage installer virtual machine'
    echo '       You need to follow the on screen instructions.'
    echo '       When it says you need to reboot, close the VM.'

    qemu-system-x86_64 $QEMU_FLAGS -cdrom "$tos_file"

    ./scripts/patch.sh

    ./scripts/create_install_iso.sh
fi

./scripts/umount.sh
qemu-system-x86_64 $QEMU_FLAGS

