#!/bin/bash
#tested on 10.11

#version 1.0 - base

#power settings
pmset -c displaysleep 60 sleep 0 disksleep 0 


#turn off ask for password and screensaver
sudo -u $SUDO_USER defaults write /Users/$SUDO_USER/Library/Preferences/com.apple.screensaver askForPassword 1
sudo -u $SUDO_USER defaults write /Users/$SUDO_USER/Library/Preferences/com.apple.screensaver askForPasswordDelay 300
sudo -u $SUDO_USER defaults write /Users/$SUDO_USER/Library/Preferences/ByHost/com.apple.screensaver idleTime 900



