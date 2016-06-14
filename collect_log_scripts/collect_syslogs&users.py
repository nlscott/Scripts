#!/usr/bin/env python 

#
#	this script colelcts sytem logs to "/Users/Shared/Syslogs/System Logs", and user logs to individual folders.
#
#	run this script with sudo
#

#REQUIRED
import os, sys, shutil

#VARIABLES
collction_folder="/Users/Shared/Syslogs"
syslogs="%s/System Logs" % (collction_folder)
system_logs="/var/log"
users_folder="/Users"


#MAKE DIRECTOIRES & COPY SYSTEM LOG FILES
os.mkdir( collction_folder, 0777 );
shutil.copytree(system_logs, syslogs, symlinks=False, ignore=None)


#GET LIST OF USERS
list_users=os.listdir(users_folder)
current_users=[]
for x in list_users:
	if x != ".localized" and x != "Shared":
		current_users.append(x)




#CREATE DIRECTORYS AND COPY FILES PER USER
for x in current_users:
	#print '%s/%s/' % (collction_folder, x)
	shutil.copytree("/Users/%s/Library/Logs/" % x, '%s/%s/' % (collction_folder, x), symlinks=False, ignore=None)


#change permissions so you can read/write logs. If you need to retain permissions for forensics, delete or comment out this line.
os.system('chmod -R 777 /Users/Shared/Syslogs')