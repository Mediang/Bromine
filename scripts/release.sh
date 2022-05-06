#!/bin/bash

if [ -z "$GITHUB_TOKEN" ]; then
  if [ -z "$1" ]; then
    echo "Error: Please set GITHUB_TOKEN environment variable or pass it as an argument"
    exit 1
  else
    GITHUB_TOKEN="$1"
  fi
fi

set -e

cd "$(dirname "$0")"/..
echo "Working directory: $PWD"

TARGET_API_PATH="github.com/repos/Mediang/Bromine/releases"

curl() {
  CURL_COMMAND="$(which curl)"
  $CURL_COMMAND -s -H "Accept: application/vnd.github.v3+json" -H "Authorization: token $GITHUB_TOKEN" "$@"
}

RELEASE_ID=$(curl "https://api.$TARGET_API_PATH/latest" | jq -r '.id')
echo "Latest release id: $RELEASE_ID"

ASSET_ID=$(curl "https://api.$TARGET_API_PATH/$RELEASE_ID/assets" | jq -r '.[0].id')
if [ "$ASSET_ID" != null ]; then
  echo "Deleting latest asset ($ASSET_ID)"
  curl -X DELETE "https://api.$TARGET_API_PATH/assets/$ASSET_ID" -o /dev/null
fi

PAPERCLIPS=(build/libs/*-paperclip-*-reobf.jar)
PAPERCLIP=${PAPERCLIPS[0]}
PAPERCLIP_BASENAME=$(basename "$PAPERCLIP")

echo "Uploading $PAPERCLIP"
curl -X POST -T "$PAPERCLIP" -H "Content-Type: application/zip" "https://uploads.$TARGET_API_PATH/$RELEASE_ID/assets?name=$PAPERCLIP_BASENAME" -o /dev/null
echo "Uploaded paperclip '$PAPERCLIP' to release '$RELEASE_ID'"
