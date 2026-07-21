#!/bin/bash
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main"
PLIST_NAME="com.robloxsetup.autorun.plist"
PLIST_DEST="$HOME/Library/LaunchAgents/$PLIST_NAME"
WORKDIR="$HOME/.robloxsetup"

echo "==> Setting up working directory..."
mkdir -p "$WORKDIR"
cd "$WORKDIR"

echo "==> Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
fi

echo "==> Installing/updating BetterDisplay..."
brew install --cask betterdisplay 2>/dev/null || brew upgrade --cask betterdisplay 2>/dev/null || true

echo "==> Launching BetterDisplay for first-time permission grant..."
open -a BetterDisplay
sleep 4

echo "==> Creating virtual display (if it doesn't already exist)..."
if ! betterdisplaycli get --name="Roblox360" &>/dev/null; then
  betterdisplaycli create -devicetype=virtualscreen -virtualscreenname="Roblox360" -aspectWidth=16 -aspectHeight=9
fi
betterdisplaycli set --name="Roblox360" --refreshRate=360 || \
  echo "WARNING: 360Hz may require BetterDisplay Pro. Falling back to whatever max Hz your license allows."

echo "==> Downloading FPS unlocker script..."
curl -sfLO https://raw.githubusercontent.com/lanylow/rbxfpsunlocker-osx/script/install_fps_unlocker
chmod +x install_fps_unlocker

echo "==> Applying FPS unlock..."
sudo ./install_fps_unlocker 0

echo "==> Downloading persistence script (refresh.sh)..."
curl -sfLO "$REPO_RAW/refresh.sh"
chmod +x refresh.sh

echo "==> Installing LaunchAgent for auto re-apply on login/reboot..."
curl -sfLO "$REPO_RAW/$PLIST_NAME"
mkdir -p "$HOME/Library/LaunchAgents"
cp "$PLIST_NAME" "$PLIST_DEST"
launchctl unload "$PLIST_DEST" 2>/dev/null || true
launchctl load "$PLIST_DEST"

echo ""
echo " Done. FPS unlocked, 'Roblox360' virtual display created, auto re-apply enabled on every login."