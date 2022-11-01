#!/bin/bash

currentUser=$(ls -l /dev/console | awk '{print $3}')
currentUserUID=$(id -u "$currentUser")
#for applescript, replace / in filepaths with :
iconFilePath="System:Library:CoreServices:Installer.app:Contents:Resources:AppIcon.icns"


Pass=$(
/bin/launchctl asuser "$currentUserUID" sudo -iu "$currentUser" /usr/bin/osascript <<APPLESCRIPT
    set validatedPass to false
    repeat while (validatedPass = false)
    -- Prompt the user to enter their computer password
    display dialog "Enter your computer password to start the update process" with icon file "$iconFilePath" default answer "" buttons {"Continue"} with text and hidden answer default button "Continue"
    set Pass to (text returned of result)
    display dialog "Re-enter your password to verify it was entered correctly" with text and hidden answer buttons {"Continue"} with icon file "$iconFilePath" default answer "" default button "Continue"
    if text returned of result is equal to Pass then
    set validatedPass to true
    Pass
    else
    display dialog "The passwords you have entered do not match. Please try again." with title "Computer Password Validation Failed" buttons {"Re-Enter Password"} default button "Re-Enter Password" with icon file "$iconFilePath"
    end if
    end repeat
APPLESCRIPT
)

unset Pass
