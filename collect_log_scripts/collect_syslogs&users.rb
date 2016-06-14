#!/usr/bin/ruby

#
#	this script colelcts sytem logs to "/Users/Shared/Syslogs/System Logs", and user logs to individual folders.
#
#	run this script with sudo
#


#REQUIRED RUBY MODULES
require 'fileutils'


#VARIBLES
collectionfolder='/Users/Shared/SYSLOGS'
syslogs="#{collectionfolder}/System Logs"
system_logs='/var/log'
users_folder="/Users"


#MAKE DIRECTORY & FILE STRUCTURE SYSTEM LOGS
Dir.mkdir("#{collectionfolder}", 0755)
Dir.mkdir("#{syslogs}", 0755)


#COPY SYSTEM LOGS
FileUtils.copy_entry("/var/log", "#{syslogs}", :preserve => true)


#CREATE A LIST OF USERS
list_users=Dir.foreach(users_folder)
current_users = []

for x in list_users
	if x != "." and x != ".." and x != ".localized" and x != "Shared"
		current_users << x
	end
end

#CREATE DIRECTORYS AND COPY FILES PER USER
for x in current_users
	#set file paths
	log_folder = "#{collectionfolder}/#{x}/"
	
	#make directories
	Dir.mkdir("#{collectionfolder}/#{x}", 0755)

	#copy files
	FileUtils.copy_entry("/Users/#{x}/Library/Logs", "#{log_folder}", :preserve => true)
end


#change permissions so you can read/write logs. If you need to retain permissions for forensics, delete or comment out this line.
FileUtils.chmod_R 0777, "#{collectionfolder}"