# My Roblox Mac Setup

One command installs BetterDisplay, creates a 360Hz virtual display named
"Roblox360", and unlocks Roblox's FPS cap. A LaunchAgent keeps both applied
automatically after reboots, macOS updates, and Roblox updates.

## Install
\`\`\`
bash <(curl -sfL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/install.sh)
\`\`\`

## Requirements
- macOS 13.2+
- A 360Hz virtual display **requires a BetterDisplay Pro license**. Without
  it, the script still runs but the display may cap at a lower Hz.

## Logs
Check \`/tmp/robloxsetup.log\` and \`/tmp/robloxsetup-error.log\` if something
isn't working after a reboot.

## Uninstall
\`\`\`
launchctl unload ~/Library/LaunchAgents/com.robloxsetup.autorun.plist
rm ~/Library/LaunchAgents/com.robloxsetup.autorun.plist
rm -rf ~/.robloxsetup
\`\`\`