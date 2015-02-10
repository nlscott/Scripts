
#!/bin/bash
#version 1.0


#Varibles
#---------------------------------------------------------
version=CFBundleShortVersionString



#Check for version
#---------------------------------------------------------
if [ -s /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin ]
then
	defaults read "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Info" $version
else
	echo "Error: Java is not installed or the version could not be checked"
fi

