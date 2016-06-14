#!/bin/bash

#
#	this script colelcts sytem logs to "/Users/Shared/Collected System Logs"
#
#	run this script with sudo
#



## varibles
collectionfolder="/Users/Shared/Collected System Logs"
system_logs="/var/log/*"


## make directory
mkdir "$collectionfolder"


## copy system logs
cp -R -p $system_logs "$collectionfolder"
