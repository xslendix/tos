#!/bin/sh

run() {
    ./scripts/start.sh $1
    exit
}

patch() {
    ./scripts/patch.sh
    exit
}

mount() {
    ./scripts/mount.sh
    exit
}

umount() {
    ./scripts/umount.sh
    exit
}

help() {
    cat <<EOF
Usage: $1 <task>

Tasks:
  - Run/Start -> Run/Install TempleOS
  - Patch -> Patch TempleOS
  - Mount -> Mount TempleOS C: partition
  - Unmount -> Unmount TempleOS C: partition
  - Clean -> Delete the TempleOS disk image
  - Help -> This page
EOF
    exit
}

unknown_command() {
    echo "Unknown command: $1"
}

clean() {
    rm -vf tos.img
    exit
}

test -z "$1" && help
test "$(echo "$1" | tr '[:upper:]' '[:lower:]')" = 'run' && run
test "$(echo "$1" | tr '[:upper:]' '[:lower:]')" = 'vnc' && run vnc
test "$(echo "$1" | tr '[:upper:]' '[:lower:]')" = 'start' && run
test "$(echo "$1" | tr '[:upper:]' '[:lower:]')" = 'patch' && patch
test "$(echo "$1" | tr '[:upper:]' '[:lower:]')" = 'mount' && mount
test "$(echo "$1" | tr '[:upper:]' '[:lower:]')" = 'umount' && umount
test "$(echo "$1" | tr '[:upper:]' '[:lower:]')" = 'unmount' && unmount
test "$(echo "$1" | tr '[:upper:]' '[:lower:]')" = 'clean' && clean
test "$(echo "$1" | tr '[:upper:]' '[:lower:]')" = 'help' && help
test -n "$1" && unknown_command "$1"

