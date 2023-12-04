#!/bin/sh
set -e

# these are hardcoded and can be found in ~/.netrc
AUTH="jupiter-image-2021:e54fe7f0-756e-46e1-90d2-7843cda0ac01"
IMAGE="$(curl -sS --user $AUTH "https://steamdeck-atomupd.steamos.cloud/updates?product=steamos&release=holo&variant=steamdeck&arch=amd64&version=snapshot&buildid=20220526.1&checkpoint=False&estimated_size=0" | jq -r '.minor.candidates[0]')"
FILE=$(echo "$IMAGE" | jq -r ".update_path" | sed 's/\.raucb/\.img.zip/')

{
    echo "Downloading image $FILE"
    curl --user $AUTH "https://steamdeck-images.steamos.cloud/$FILE" -o ./steamos.zip
    unzip ./steamos.zip -d ./steamos_image
    rm ./steamos.zip
} >&2

# Output the downloaded version for github actions to tag the images
echo "BUILD_ID=$(echo "$IMAGE" | jq -r '.image.buildid')"
FULL_VERSION="$(echo "$IMAGE" | jq -r '.image.version')"
echo "FULL_VERSION=${FULL_VERSION}"
echo "MAJOR_VERSION=$(echo "$FULL_VERSION" | cut -d. -f 1)"
echo "MINOR_VERSION=$(echo "$FULL_VERSION" | cut -d. -f 1,2)"
