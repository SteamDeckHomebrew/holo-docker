#!/usr/bin/env bash

set -e

# These are hardcoded and can be found in ~/.netrc on the SteamDeck filesystem image
AUTH="jupiter-image-2021:e54fe7f0-756e-46e1-90d2-7843cda0ac01"
FILE=$(curl -sS --user $AUTH "https://steamdeck-atomupd.steamos.cloud/updates?product=steamos&release=holo&variant=steamdeck&arch=amd64&version=snapshot&buildid=20220526.1&checkpoint=False&estimated_size=0" | jq -r ".minor.candidates[0].update_path" | sed 's/\.raucb/\.img.zip/')
echo "Downloading image $FILE"
curl --user $AUTH "https://steamdeck-images.steamos.cloud/$FILE" -o ./steamos.zip
unzip ./steamos.zip -d ./steamos_image
rm ./steamos.zip

