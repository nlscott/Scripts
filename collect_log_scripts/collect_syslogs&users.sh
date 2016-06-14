#!/bin/bash
#tested on 10.11

#
#	this script colelcts sytem logs to "/Users/Shared/Syslogs/System Logs", and user logs to individual folders.
#
#	run this script with sudo
#


## varibles
collectionfolder="/Users/Shared/Collected System Logs"
system_logs="/var/log/*"
list_of_users=$(ls /Users)


## make collection log directory
mkdir "$collectionfolder"
mkdir "$collectionfolder/syslogs"



## copy system logs
cp -R -p $system_logs "$collectionfolder/syslogs"


## create folder and copy logs per user
for x in $list_of_users;
do
	if [[ $x != "Shared" && $x != ".localized" ]];then
		#echo $x
		mkdir "$collectionfolder/$x"
		cp -R -p "/Users/$x/Library/Logs" "$collectionfolder/$x"
	fi
done


#change permissions so you can read/write logs. If you need to retain permissions for forensics, delete or comment out this line.
chmod -R 777 "$collectionfolder"




