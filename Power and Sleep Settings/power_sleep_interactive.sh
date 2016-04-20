#!/bin/bash
#version 1.1


[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"


echo "Do you want to set power on or off: "
read powersettings


if [[ $powersettings == off ]]; then
  echo "Turning power settings off"
  pmset -c displaysleep 0 sleep 0 disksleep 0 
  sudo -u $SUDO_USER defaults write /Users/$SUDO_USER/Library/Preferences/com.apple.screensaver askForPassword 0
  sudo -u $SUDO_USER defaults write /Users/$SUDO_USER/Library/Preferences/ByHost/com.apple.screensaver idleTime 0

elif [[ $powersettings == on ]]; then
  echo "Turning power settings on"
  pmset -c displaysleep 60 sleep 0 disksleep 0 
  sudo -u $SUDO_USER defaults write /Users/$SUDO_USER/Library/Preferences/com.apple.screensaver askForPassword 1
  sudo -u $SUDO_USER defaults write /Users/$SUDO_USER/Library/Preferences/com.apple.screensaver askForPasswordDelay 300
  sudo -u $SUDO_USER defaults write /Users/$SUDO_USER/Library/Preferences/ByHost/com.apple.screensaver idleTime 900

else
  echo "No choice"
fi
sleep 1

Killall Terminal