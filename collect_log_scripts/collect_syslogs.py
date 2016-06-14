#!/usr/bin/env python 


#
#	this script colelcts sytem logs to "/Users/Shared/Collected System Logs"
#
#	run this script with sudo
#



#REQUIRED
import os, sys, shutil, distutils.dir_util

#VARIABLES
collction_folder="/Users/Shared/Collected System Logs"
system_logs="/var/log/"


#MAKE DIRECTOIRES & COPY SYSTEM LOG FILES
os.mkdir( collction_folder, 0777 );
#shutil.copytree(system_logs, collction_folder, symlinks=False, ignore=None)
distutils.dir_util.copy_tree(system_logs, collction_folder)

