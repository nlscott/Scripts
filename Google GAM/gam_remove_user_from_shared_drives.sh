#!/bin/zsh


emailAccount="user.name@email.com"
gamCommand="path_to_gam_command"


declare -a sharedDriveArray
sharedDriveArray=($($gamCommand user $emailAccount show teamdrives | grep ID: | cut -d ":" -f3 | awk '{$1=$1;print}'))


for driveID in ${sharedDriveArray[@]}; do
    echo "[Action] Removing $emailAccount from Drive ID: $driveID"
    driveOwnerEmail=$($gamCommand user $emailAccount show drivefileacl $driveID |  grep -B 1 "role: organizer" | head -1 | awk '{print $2}')
    $gamCommand user $driveOwnerEmail delete drivefileacl $driveID $emailAccount
 
done

