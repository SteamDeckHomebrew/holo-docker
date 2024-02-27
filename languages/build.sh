#!/usr/bin/env bash

set -e

if [[ $# != 1 ]]; then
  echo "[ERROR] Exactly one argument is expected that matches the first part of one of the dockerfile names (e.g. 'go')"
  exit 1
fi

DIR="$(dirname "$(realpath "$0")")"

cd ${DIR}

if [[ ! -f "${1}.dockerfile" ]]; then
  echo "[ERROR] Could not find '${1}.dockerfile' in the same directory as this script."
  exit 1
fi

set -a
if [[ -f ${PWD}/../.env ]]; then
  source ${PWD}/../.env
else
  echo "[ERROR] Please copy 'example.env' to '.env' in the repo root and edit values as desired."
  exit 1
fi
set +a

if command -v "docker" &> /dev/null; then
  docker build -f "${1}.dockerfile" \
    --build-arg="image_name=${IMAGE_BASE}/${IMAGE_NAME_ROOT}-base" \
    -t ${IMAGE_BASE}/${IMAGE_NAME_ROOT}-toolchain-${1}:${IMAGE_TAG} .
elif command -v "podman" &> /dev/null; then
  podman build -f "${1}.dockerfile" \
    --build-arg="image_name=${IMAGE_BASE}/${IMAGE_NAME_ROOT}-base" \
    -t ${IMAGE_BASE}/${IMAGE_NAME_ROOT}-toolchain-${1}:${IMAGE_TAG} .
else
  echo "[ERROR] You must have 'docker' or 'podman' installed."
  exit 1
fi

