#!/bin/bash
USER_NAME=Aeroniscoolmc2
PASSWORD=

# 1. Create the Account
sudo dscl . -create /Users/$USER_NAME
sudo dscl . -create /Users/$USER_NAME UserShell /bin/bash
sudo dscl . -create /Users/$USER_NAME RealName "$USER_NAME"
sudo dscl . -create /Users/$USER_NAME UniqueID 1001
sudo dscl . -create /Users/$USER_NAME PrimaryGroupID 20
sudo dscl . -create /Users/$USER_NAME NFSHomeDirectory /Users/$USER_NAME
sudo dscl . -passwd /Users/$USER_NAME "$PASSWORD"
sudo dscl . -append /Groups/admin GroupMembership $USER_NAME

# 2. Fix the Black Screen (Virtual Display)
sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -restart -agent

# 3. Install noVNC (The Web Interface)
brew install novnc
# Start the web bridge on port 8080
websockify --web /usr/local/share/novnc/ 8080 localhost:5900 &

echo "Web VNC is starting on port 8080!"
