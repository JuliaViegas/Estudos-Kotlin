#!/usr/bin/env bash
# scripts/decode_keystore.sh
# Helper script to decode a base64 keystore environment variable into a file.
# Usage: ANDROID_KEYSTORE_BASE64=... ./scripts/decode_keystore.sh

set -euo pipefail

if [ -z "${ANDROID_KEYSTORE_BASE64-}" ]; then
  echo "ANDROID_KEYSTORE_BASE64 is not set"
  exit 1
fi

mkdir -p ./keystores
echo "$ANDROID_KEYSTORE_BASE64" | base64 --decode > ./keystores/keystore.jks
chmod 600 ./keystores/keystore.jks

echo "Keystore written to ./keystores/keystore.jks"
