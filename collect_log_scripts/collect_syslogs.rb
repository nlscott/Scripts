#!/usr/bin/ruby

#
#	this script colelcts sytem logs to "/Users/Shared/Collected System Logs"
#
#	run this script with sudo
#


#REQUIRED RUBY MODULES
require 'fileutils'


#VARIBLES
collectionfolder='/Users/Shared/Collected System Logs'
system_logs='/var/log'


#MAKE DIRECTORY & FILE STRUCTURE SYSTEM LOGS
Dir.mkdir("#{collectionfolder}", 0755)


#COPY SYSTEM LOGS
FileUtils.copy_entry("/var/log", "#{collectionfolder}", :preserve => true)


