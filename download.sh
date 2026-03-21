#!/bin/sh
set -e

CHANNEL="$1"

if [ -z "$CHANNEL" ]; then
    echo "Usage: $0 <channel>" >&2
    exit 1
fi

# these are hardcoded and can be found in ~/.netrc
AUTH="jupiter-image-2021:e54fe7f0-756e-46e1-90d2-7843cda0ac01"
METADATA_URL="https://steamdeck-atomupd.steamos.cloud/meta/steamos/amd64/snapshot/${CHANNEL}.json"
IMAGE="$(curl -fsSL --user "$AUTH" "$METADATA_URL" | jq -r '.minor.candidates[0]')"
FILE=$(echo "$IMAGE" | jq -r ".update_path" | sed 's/\.raucb/\.img.zst/')

{
    echo "Downloading image $FILE"
    curl --user $AUTH "https://steamdeck-images.steamos.cloud/$FILE" -o ./steamos.img.zst
    mkdir ./steamos_image
    zstd -d ./steamos.img.zst -o ./steamos_image/disk.img
    rm ./steamos.img.zst
} >&2

# Output the downloaded version for github actions to tag the images
echo "BUILD_ID=$(echo "$IMAGE" | jq -r '.image.buildid')"
FULL_VERSION="$(echo "$IMAGE" | jq -r '.image.version')"
echo "FULL_VERSION=${FULL_VERSION}"
echo "MAJOR_VERSION=$(echo "$FULL_VERSION" | cut -d. -f 1)"
echo "MINOR_VERSION=$(echo "$FULL_VERSION" | cut -d. -f 1,2)"
