#!/bin/zsh


## Variables ---------------------------------------------------------------------------------------
emailAccount="user.name@email.com"
gamCommand="path_to_gam_command"


## Commands ----------------------------------------------------------------------------------------

# rest account password
echo "[Action] Resetting password for $emailAccount"
$gamCommand update user $emailAccount password random
echo "\n"

# remove user from email groups
echo "[Action] Removing user $emailAccount from Groups"
$gamCommand user $emailAccount delete groups
echo "\n"

# signs user out of all active sessions, revokes all app specific passwords, 2SV Backup Codes, and OAuth Tokens
echo "[Action] deprovisioning user $emailAccount"
$gamCommand user $emailAccount deprovision
echo "\n"

# delete recovery email and phone
echo "[Action] Removing Recovery info for $emailAccount"
$gamCommand update user $emailAccount recoveryemail ""
$gamCommand update user $emailAccount recoveryphone ""
echo "\n"

# delete personal email and phone
echo "[Action] Removing Contact info for $emailAccount"
$gamCommand update user $emailAccount emails home ""
$gamCommand update user $emailAccount phone type home value "            " notprimary
echo "\n"

# remove user from shared drives
echo "[Action] Removing $emailAccount from Shared Drives"
declare -a sharedDriveArray
sharedDriveArray=($($gamCommand user $emailAccount show teamdrives | grep ID: | cut -d ":" -f3 | awk '{$1=$1;print}'))
for driveID in ${sharedDriveArray[@]}; do
    echo "[Action] Removing $emailAccount from Drive ID: $driveID"
    driveOwnerEmail=$($gamCommand user $emailAccount show drivefileacl $driveID |  grep -B 1 "role: organizer" | head -1 | awk '{print $2}')
    $gamCommand user $driveOwnerEmail delete drivefileacl $driveID $emailAccount
done
echo "\n"

# suspend user
echo "[Action] Suspending user $emailAccount"
$gamCommand update user $emailAccount suspended on
echo "\n"

# move user to suspended OU
echo "[Action] Moving user $emailAccount Supspended OU"
$gamCommand update user $emailAccount suspended on org "Suspended User"
echo "\n"
