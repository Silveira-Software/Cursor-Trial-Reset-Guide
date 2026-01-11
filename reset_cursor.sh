#!/bin/bash
# Cursor Trial Reset for macOS

echo "Starting Cursor Reset..."

# Close Cursor
pkill -i Cursor

# Unlock file if locked
chmod 644 ~/Library/Application\ Support/Cursor/User/globalStorage/storage.json 2>/dev/null

# Remove database and cache
rm -rf ~/Library/Application\ Support/Cursor/User/globalStorage/state.vscdb*
rm -rf ~/Library/Caches/com.todesktop.230313mzl4w4u92
rm -rf ~/Library/Application\ Support/Caches/cursor-updater

# Generate New IDs
ID1=$(uuidgen | tr '[:upper:]' '[:lower:]')
ID2=$(uuidgen | tr '[:upper:]' '[:lower:]')
ID3=$(uuidgen)

# Create new storage.json
echo "{\"telemetry.macMachineId\":\"$ID1\",\"telemetry.machineId\":\"$ID2\",\"telemetry.devDeviceId\":\"$ID3\"}" > ~/Library/Application\ Support/Cursor/User/globalStorage/storage.json

# Lock file as Read-Only
chmod 444 ~/Library/Application\ Support/Cursor/User/globalStorage/storage.json

echo "Done! New IDs generated. Please change your IP/VPN and use a new email."
