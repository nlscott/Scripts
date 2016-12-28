#!/usr/bin/ruby

#==============================================================
# Loop through the applications folder and find apps that
# start with "Adobe". Look inside the folders and find
# .app files, then read the Info.plist file for the
# CFBundleShortVersionString key and report back the version
#==============================================================

#==============================================================
#get a list of Adobe apps and version numbers

def adobe_app_versions
	application_folder = Dir.entries("/Applications")
	for application_name in application_folder
		if application_name.start_with?('Adobe')
			for x in Dir["/Applications/#{application_name}/*.app"]
				puts application_name + " = " + `defaults read "#{x}/Contents/Info.plist" "CFBundleShortVersionString"`
			end
		end
	end
end

adobe_app_versions