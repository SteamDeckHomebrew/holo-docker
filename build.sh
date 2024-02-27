#!/bin/bash
set -e

sudo losetup

LOOP=$(sudo losetup --find --partscan --show ./steamos_image/disk.img)
mkdir -p ${PWD}/steamos
sudo btrfstune -M $(uuidgen) ${LOOP}p3
sudo mount ${LOOP}p3 ${PWD}/steamos
unmount_img() {
    sudo umount ${PWD}/steamos
    sudo losetup -d $LOOP
}
trap unmountimg ERR

sudo podman build -t docker.io/spkane/holo-base:latest .

unmount_img
