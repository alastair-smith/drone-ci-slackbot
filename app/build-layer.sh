#!/bin/bash

# intended to be ran in docker image amazonlinux

set -eu

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NO_COLOR='\033[0m'

yellow_echo() {
  echo -e "${YELLOW}${@}${NO_COLOR}"
}

green_echo() {
  echo -e "${GREEN}${@}${NO_COLOR}"
}

yellow_echo "Configuring variables..."

WORKING_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
LAYER_DIR="$WORKING_DIR/layer"
NODE_LAYER_DIR="nodejs/"
NODE_LAYER_FULL_DIR="$LAYER_DIR/$NODE_LAYER_DIR"
ARCHIVE_OUTPUT="$WORKING_DIR/layer.zip"

yellow_echo "Configured variables"
yellow_echo "Creating directories..."

rm -rf "$LAYER_DIR"
rm -f "$ARCHIVE_OUTPUT"
mkdir -p "$NODE_LAYER_FULL_DIR"

yellow_echo "Created directories"
yellow_echo "Installing yum packages..."

amazon-linux-extras install epel -y

yum install -y \
  tar \
  gzip \
  zip

yellow_echo "Installed yum packages"
yellow_echo "Installing nodejs..."

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" || echo "supressing failure"
echo "Installed nvm, installing node: $(cat .nvmrc)"
nvm install

yellow_echo "Installed nodejs"
yellow_echo "Installing node modules..."

cd "$NODE_LAYER_FULL_DIR"
cp "$WORKING_DIR/package.json" "$WORKING_DIR/package-lock.json" .
npm ci --production
rm "package.json" "package-lock.json"

yellow_echo "Installed node modules"
yellow_echo "Creating archive"

cd "$LAYER_DIR"
zip -r "$ARCHIVE_OUTPUT" "$NODE_LAYER_DIR"

yellow_echo "Created archive"
yellow_echo "Cleaning up workspace..."

rm -r "$LAYER_DIR"

yellow_echo "Cleaned up workspace"
green_echo "Build complete"
