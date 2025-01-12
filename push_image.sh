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

if command -v "docker" &> /dev/null; then
  docker login ${IMAGE_BASE%%/*}
  docker image push ${IMAGE_BASE}/${IMAGE_NAME_ROOT}-base:${IMAGE_TAG}
elif command -v "podman" &> /dev/null; then
  podman login ${IMAGE_BASE%%/*}
  podman image push ${IMAGE_BASE}/${IMAGE_NAME_ROOT}-base:${IMAGE_TAG}
else
  echo "[ERROR] You must have 'docker' or 'podman' installed."
  exit 1
fi

