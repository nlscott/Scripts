#!/usr/bin/ruby

#define colored text
class String
	def cyan; "\033[36m#{self}\033[0m" end
end


#Varibles
#---------------------------------------------------------
which_version="CFBundleShortVersionString"
current_java=`defaults read "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Info" #{which_version}`.strip


puts "Checking Java for: " + which_version.cyan
puts "Current version is: " + current_java.cyan
