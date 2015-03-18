#!/bin/bash
#version 1.0 03.18.2015


#set terminal defaults
sudo -u $USER defaults write /Users/$USER/Library/Preferences/com.apple.Terminal.plist "Default Window Settings" "Homebrew"
sudo -u $USER defaults write /Users/$USER/Library/Preferences/com.apple.Terminal.plist "Startup Window Settings" "Homebrew"

#set window width to 120
sudo /usr/libexec/PlistBuddy -c "Add :Window\ Settings:Homebrew:columnCount integer 120" /Users/$USER/Library/Preferences/com.apple.Terminal.plist
defaults write /Users/$USER/Library/Preferences/com.apple.Terminal.plist "NSWindow Frame TTWindow Homebrew" "97 302 1075 366 0 0 1280 777 "

#restart terminal & remove file
killall Terminal


exit 0


