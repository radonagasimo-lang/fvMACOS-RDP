#!/bin/bash
USER_NAME=Aeroniscoolmc2
PASSWORD=
NGROK_TOKEN=$3

# Create the account
sudo dscl . -create /Users/$USER_NAME
sudo dscl . -create /Users/$USER_NAME UserShell /bin/bash
sudo dscl . -create /Users/$USER_NAME RealName "$USER_NAME"
sudo dscl . -create /Users/$USER_NAME UniqueID 1001
sudo dscl . -create /Users/$USER_NAME PrimaryGroupID 20
sudo dscl . -create /Users/$USER_NAME NFSHomeDirectory /Users/$USER_NAME
sudo dscl . -passwd /Users/$USER_NAME "$PASSWORD"
sudo dscl . -append /Groups/admin GroupMembership $USER_NAME

# Start VNC
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist

# Start Ngrok
brew install --cask ngrok
ngrok authtoken $NGROK_TOKEN
ngrok tcp 5900 --log=stdout > /dev/null &

echo "Setup finished for $USER_NAME!"

