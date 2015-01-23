#!/bin/bash

#VARIABLES 
ESC_SEQ="\x1b["
COL_RED=$ESC_SEQ"31;01m"
COL_RESET=$ESC_SEQ"39;49;00m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_BLUE=$ESC_SEQ"36;15m"
cycle_count=`ioreg -w0 -l | grep -w CycleCount | awk '{print $5}' | awk 'NR==1'`
max_cycle_count=`ioreg -w0 -l | grep -w DesignCycleCount9C | awk '{print $5}' | awk 'NR==1'`
cycle_check=`ioreg -w0 -l | grep -w CycleCount | awk '{print $3}' | awk 'NR==1' | cut -d '"' -f 2`

echo -e " Current Battery Cycles: $COL_BLUE"$cycle_count"$COL_RESET"
echo -e " Maximum Battery Cycles: $COL_BLUE"$max_cycle_count"$COL_RESET"


if [[  $cycle_check == CycleCount ]]; then
	if [[ $(($max_cycle_count-$cycle_count)) > 0 ]]; then
		echo -e " Battery Status:$COL_GREEN "Good"$COL_RESET"
		echo " You still have $(($max_cycle_count-$cycle_count)) cycles"
	
	elif [[ $(($max_cycle_count-$cycle_count)) < 0 ]]; then
		echo -e " Battery Status:$COL_RED "Needs Replaced"$COL_RESET"
		echo " You are $(($max_cycle_count-$cycle_count)) cycles over the max"
	
	else
		echo "oops! something went wrong and the battery status could not be checked"
	fi

else
	echo " Error: A internal battery could not be found"
fi



