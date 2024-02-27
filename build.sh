#!/usr/bin/env bash

set -e

set -a
if [[ -f ${PWD}/.env ]]; then
  source ${PWD}/.env
else
  echo "[ERROR] Please copy 'example.env' to '.env' and edit values as desired."
  exit 1
fi
set +a

losetup

LOOP=$(losetup --find --partscan --show ./steamos_image/disk.img)
mkdir -p ${PWD}/steamos
btrfstune -M $(uuidgen) ${LOOP}p3 # This allows us to mount this partition even if we are on a real SteamDeck.
mount ${LOOP}p3 ${PWD}/steamos

unmount_img() {
    umount ${PWD}/steamos
    losetup -d $LOOP
}

trap unmountimg ERR

if command -v "docker" &> /dev/null; then
  docker build -t ${IMAGE_BASE}/${IMAGE_NAME_ROOT}-base:${IMAGE_TAG} .
elif command -v "podman" &> /dev/null; then
  podman build -t ${IMAGE_BASE}/${IMAGE_NAME_ROOT}-base:${IMAGE_TAG} .
else
  echo "[ERROR] You must have 'docker' or 'podman' installed."
  exit 1
fi

unmount_img

