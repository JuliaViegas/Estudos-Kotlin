#!/usr/bin/env bash
set -euo pipefail

# Simple Gradle wrapper alternative that downloads a Gradle distribution at runtime
# This avoids needing gradle/wrapper/gradle-wrapper.jar in the repository.
# Adjust GRADLE_VERSION if you need a different Gradle version.

GRADLE_VERSION=8.4.1
CACHE_DIR="$HOME/.gradle-wrapper"
DIST_ZIP="/tmp/gradle-${GRADLE_VERSION}.zip"

if [ -z "${GRADLE_HOME-}" ]; then
  if [ ! -x "$CACHE_DIR/gradle-$GRADLE_VERSION/bin/gradle" ]; then
    echo "Gradle $GRADLE_VERSION not found in cache; downloading..."
    mkdir -p "$CACHE_DIR"
    if command -v curl >/dev/null 2>&1; then
      curl -sSL "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -o "$DIST_ZIP"
    else
      wget -q "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -O "$DIST_ZIP"
    fi
    unzip -q "$DIST_ZIP" -d "$CACHE_DIR"
    rm -f "$DIST_ZIP"
  fi
  GRADLE_CMD="$CACHE_DIR/gradle-$GRADLE_VERSION/bin/gradle"
else
  GRADLE_CMD="$GRADLE_HOME/bin/gradle"
fi

# Execute gradle with all arguments passed to this script
exec "$GRADLE_CMD" "$@"
