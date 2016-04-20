#!/bin/bash
#tested on 10.11


#turn display sleep, computer sleep and hard drive sleep off
pmset -c displaysleep 0 sleep 0 disksleep 0 


#turn off ask for password and screensaver
sudo -u $SUDO_USER defaults write /Users/$SUDO_USER/Library/Preferences/com.apple.screensaver askForPassword 0
sudo -u $SUDO_USER defaults write /Users/$SUDO_USER/Library/Preferences/ByHost/com.apple.screensaver idleTime 0



