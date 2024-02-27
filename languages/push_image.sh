#!/usr/bin/env bash

set -e

if [[ $# != 1 ]]; then
  echo "[ERROR] Exactly one argument is expected that matches the first part of one of the dockerfile names (e.g. 'go')"
  exit 1
fi

set -a
if [[ -f ${PWD}/../.env ]]; then
  source ${PWD}/../.env
else
  echo "[ERROR] Please copy 'example.env' to '.env' and edit values as desired."
  exit 1
fi
set +a

if command -v "docker" &> /dev/null; then
  docker login ${IMAGE_BASE}
  docker image push ${IMAGE_BASE}/${IMAGE_NAME_ROOT}-toolchain-${1}:${IMAGE_TAG}
elif command -v "podman" &> /dev/null; then
  podman login ${IMAGE_BASE}
  podman image push ${IMAGE_BASE}/${IMAGE_NAME_ROOT}-toolchain-${1}:${IMAGE_TAG}
else
  echo "[ERROR] You must have 'docker' or 'podman' installed."
  exit 1
fi

