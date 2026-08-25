#!/usr/bin/env bash
set -euo pipefail

# scripts/generate-wrapper.sh
# Generates the official Gradle wrapper using a Docker Gradle image, commits the generated
# wrapper files to the current branch and pushes to origin.
# Usage: ./scripts/generate-wrapper.sh [branch] [gradle-version]
# Example: ./scripts/generate-wrapper.sh add/contador-screen 8.4.1

BRANCH=${1:-add/contador-screen}
GRADLE_VER=${2:-8.4.1}
DOCKER_IMAGE="gradle:${GRADLE_VER}-jdk11"

echo "Will generate Gradle wrapper for Gradle ${GRADLE_VER} on branch ${BRANCH} using Docker image ${DOCKER_IMAGE}."

# Ensure we have docker available
if ! command -v docker >/dev/null 2>&1; then
  echo "docker CLI not found. Install Docker or run the equivalent gradle wrapper command locally." >&2
  exit 1
fi

# Fetch and checkout branch
git fetch origin "$BRANCH"
git checkout "$BRANCH"

# Run gradle wrapper inside container
echo "Running: docker run --rm -v \"$PWD\":/home/gradle/project -w /home/gradle/project ${DOCKER_IMAGE} gradle wrapper --gradle-version ${GRADLE_VER}"
docker run --rm -v "$PWD":/home/gradle/project -w /home/gradle/project "$DOCKER_IMAGE" gradle wrapper --gradle-version "$GRADLE_VER"

# Add, set executable and commit
git add gradlew gradlew.bat gradle/wrapper/gradle-wrapper.jar gradle/wrapper/gradle-wrapper.properties || true
# Ensure gradlew is executable in Git
git update-index --add --chmod=+x gradlew || true

if git diff --staged --quiet; then
  echo "No changes to commit (wrapper files already up-to-date)."
else
  git commit -m "Add Gradle wrapper (generated via Docker: ${DOCKER_IMAGE})"
  git push origin "$BRANCH"
  echo "Wrapper generated and pushed to origin/${BRANCH}."
fi
