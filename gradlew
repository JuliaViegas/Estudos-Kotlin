#!/usr/bin/env bash
set -euo pipefail

# Simple Gradle wrapper alternative that downloads a Gradle distribution at runtime
# Robustified to prefer an existing GRADLE_HOME/bin/gradle only if it exists and is executable.
# Otherwise downloads the specified Gradle version into a local cache and uses that.

GRADLE_VERSION=8.4.1
CACHE_DIR="$HOME/.gradle-wrapper"
DIST_ZIP="/tmp/gradle-${GRADLE_VERSION}.zip"

GRADLE_CMD=""

# Use GRADLE_HOME if it points to a valid gradle executable
if [ -n "${GRADLE_HOME-}" ] && [ -x "${GRADLE_HOME}/bin/gradle" ]; then
  echo "Using gradle from GRADLE_HOME: ${GRADLE_HOME}/bin/gradle"
  GRADLE_CMD="${GRADLE_HOME}/bin/gradle"
else
  # Use cached download if present
  if [ -x "$CACHE_DIR/gradle-$GRADLE_VERSION/bin/gradle" ]; then
    GRADLE_CMD="$CACHE_DIR/gradle-$GRADLE_VERSION/bin/gradle"
  else
    echo "Gradle not found in GRADLE_HOME or cache; downloading Gradle $GRADLE_VERSION..."
    mkdir -p "$CACHE_DIR"
    if command -v curl >/dev/null 2>&1; then
      curl -sSL "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -o "$DIST_ZIP"
    else
      wget -q "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -O "$DIST_ZIP"
    fi
    unzip -q "$DIST_ZIP" -d "$CACHE_DIR"
    rm -f "$DIST_ZIP"
    GRADLE_CMD="$CACHE_DIR/gradle-$GRADLE_VERSION/bin/gradle"
  fi
fi

if [ -z "${GRADLE_CMD-}" ]; then
  echo "Failed to find or download gradle. Exiting." >&2
  exit 1
fi

exec "$GRADLE_CMD" "$@"
