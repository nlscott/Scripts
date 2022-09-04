#!/bin/zsh

#-------------------------------------------------------------------------------
#            Name:  listVolumeOwners.zsh
#         Created:  2022.07.22
#   Last Modified:  2022.07.24
#         Version:  1.2
#     Description:  Maps user name and account status to volumne owners
#                   # 1 - get UUID of volume owners
#                   # 2 - check if UUIDS are user accounts
#                   # 3 - check if user is admin or standard
#                   # 4 - print results
#      Change Log:  1.0 - First draft
#                   1.1 - Fixed an issues where incorrect output was printed out
#                         for UUIDs that were not real user accoutns
#                   1.2 - Fixed an issue where "Volume Owners" was printed to
#                         output too manytimes
#-------------------------------------------------------------------------------

function listVolumeOwners (){
    #Get a list of volumne owners UUIDs and put them into an array
    arrayofUUIDs=( $(diskutil apfs listUsers / | grep +-- | awk '{print $2}') )
    
    echo "Volume Owners: "

    #loop through array
    for UUID in "${arrayofUUIDs[@]}"; do
        get_username=$(dscl . -search /Users GeneratedUID $UUID | xargs | awk '{print $1}')
        #If the UUID matches a real user account, then a username is returned
        #if not then an empty string is returned
        if [[ $get_username != "" ]]; then
            admin_check=$(dsmemberutil checkmembership -U $get_username -G admin)
            admin_output="user is a member of the group"
            #check if the user is an admin or standard user and printing results
            if [ $admin_check = $admin_output ]; then
                echo "  $get_username : (Admin)"
            elif [ $admin_check != $admin_output ]; then
                echo "  $get_username : (Standard)"
            else
                echo "something went wrong"
                exit 201
            fi
        #if the UUID check didn't return a username and the string is empty    
        elif [[ $get_username == "" ]]; then
            #Nothihng to do here, UUID doesn't match a real user account
            continue
        else
            #If you end up here, you probably need to do some debugging
            echo "I'm sorry we're broken ..."
            exit 202
        fi
    done
}

listVolumeOwners
