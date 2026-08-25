#!/usr/bin/env bash
set -euo pipefail

# Robust Gradle downloader wrapper
# - Prefer an existing GRADLE_HOME/bin/gradle if valid and executable
# - Otherwise download Gradle distribution with retries and strict HTTP checks
# - Validate the downloaded file before unzipping
# - Save HTTP error body to /tmp/gradle-download-failed.html for debugging if download fails

GRADLE_VERSION=8.4.1
CACHE_DIR="$HOME/.gradle-wrapper"
DIST_ZIP="/tmp/gradle-${GRADLE_VERSION}.zip"
RETRY_COUNT=3

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

    # Attempt to download with retries
    success=0
    for i in $(seq 1 $RETRY_COUNT); do
      echo "Download attempt ${i}..."
      rm -f "$DIST_ZIP" /tmp/gradle-download-failed.html || true
      if command -v curl >/dev/null 2>&1; then
        # -f : fail on HTTP errors, -S show error, -L follow redirects
        if curl -fSL "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -o "$DIST_ZIP"; then
          success=1
          break
        else
          echo "curl download returned non-zero; saving verbose output to /tmp/gradle-download-failed.html"
          curl -sSL "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -o /tmp/gradle-download-failed.html || true
        fi
      elif command -v wget >/dev/null 2>&1; then
        if wget -q -O "$DIST_ZIP" "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"; then
          success=1
          break
        else
          echo "wget download returned non-zero; saving response to /tmp/gradle-download-failed.html"
          wget -S "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -O /tmp/gradle-download-failed.html || true
        fi
      else
        echo "Neither curl nor wget is available on this runner. Cannot download Gradle." >&2
        exit 1
      fi

      echo "Waiting before retry..."
      sleep 2
    done

    if [ "$success" -ne 1 ]; then
      echo "Failed to download Gradle after ${RETRY_COUNT} attempts. Inspect /tmp/gradle-download-failed.html for details." >&2
      ls -la /tmp/gradle-download-failed.html || true
      exit 1
    fi

    # Quick validation: check that file is a zip
    if command -v file >/dev/null 2>&1; then
      filetype=$(file -b --mime-type "$DIST_ZIP" || echo "")
      echo "Downloaded file MIME type: $filetype"
      if [[ "$filetype" != "application/zip" ]]; then
        echo "Downloaded file is not a zip archive; saving head for inspection and aborting." >&2
        head -c 4096 "$DIST_ZIP" | sed -n '1,200p' > /tmp/gradle-download-HEAD.txt || true
        ls -la "$DIST_ZIP" || true
        exit 1
      fi
    fi

    # Unzip to cache
    unzip -q "$DIST_ZIP" -d "$CACHE_DIR" || {
      echo "unzip failed; saving diagnostic (first bytes) to /tmp/gradle-download-HEAD.txt" >&2
      head -c 4096 "$DIST_ZIP" > /tmp/gradle-download-HEAD.txt || true
      exit 1
    }
    rm -f "$DIST_ZIP"
    GRADLE_CMD="$CACHE_DIR/gradle-$GRADLE_VERSION/bin/gradle"
  fi
fi

if [ -z "${GRADLE_CMD-}" ]; then
  echo "Failed to find or download gradle. Exiting." >&2
  exit 1
fi

exec "$GRADLE_CMD" "$@"
