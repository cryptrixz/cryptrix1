#!/bin/bash
set -euo pipefail
WORKDIR="$HOME/.robloxsetup"
cd "$WORKDIR"

# Recreate virtual display if missing
if ! betterdisplaycli get --name="Roblox360" &>/dev/null; then
  betterdisplaycli create -devicetype=virtualscreen -virtualscreenname="Roblox360" -aspectWidth=16 -aspectHeight=9
fi
betterdisplaycli set --name="Roblox360" --refreshRate=360 || true

# Re-apply FPS unlock (safe to run even if Roblox hasn't updated)
if [ -f "./install_fps_unlocker" ]; then
  sudo ./install_fps_unlocker 0 || true
fi