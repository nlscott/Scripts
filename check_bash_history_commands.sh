#!/bin/bash
################################################################################
# Name      	: check_bash_history_commands.sh                                                                                                                                                 
# Date          : 2024.05.19 
# Version       : 1.0.0                                                                                    
# Author       	: Nic Scott                                               
# Description	: checks if the histroy files exisits and reads the file line by
#                 line to find any commands that contain $commandToFind. If a match 
#                 is found, prints the timestamp and the command that was run                                    
################################################################################


## VARIABLES -------------------------------------------------------------------
# update variables as needed
commandToFind="scp"
numberOfDays=1000
HISTORY_FILE="$HOME/.zsh_history"

# do not edit this variable
currentTime=$(date +%s)


## FUNCTIONS -------------------------------------------------------------------
function checkBashHistoryForCommand () {
    if [ -f "$HISTORY_FILE" ]; then
        while IFS= read -r line; do
            if [[ "$line" =~ "$commandToFind" ]];then
                commandTimeStamp=$(echo $line | awk '{print $2}' | cut -d ":" -f1)
                timeDifference=$(($currentTime - $commandTimeStamp))
                days=$(($timeDifference / 86400))
                if [[ $days -le "$numberOfDays" ]];then
                    commandARGTimeStamp=$(echo $line | cut -d ":" -f2 |xargs)
                    humanTimeStamp=$(date -r $commandARGTimeStamp "+%Y-%m-%d %H:%M:%S")
                    commandARG=$(echo $line | cut -d ";" -f2)
                    echo "$humanTimeStamp $commandARG"
                fi
            fi
        done < "$HISTORY_FILE"
    else
        echo "No history file found."
    fi
}


## COMMANDS --------------------------------------------------------------------
checkBashHistoryForCommand