#!/bin/bash
USER_NAME=Aeroniscoolmc2
PASSWORD=

# Create your account
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
# Force the Mac to recognize a virtual display
sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent

echo "Mac is ready on your Tailnet!"
