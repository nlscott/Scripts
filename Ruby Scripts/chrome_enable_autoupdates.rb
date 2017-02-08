#!/usr/bin/ruby

#=================================================================================
# test on macOS: 10.12.3
# test on chrome version:  56.0.2924.87
# enables  chrome auto updates for all users.
# meant to be run after installing chrome
# preferably as a deployment workflow via deploystudio or first time login or before chrome is opened
#=================================================================================

require 'CFPropertyList'

module ChromeAutoUpdate
	
	CHROMEPATH = "/Applications/Google Chrome.app"
	INFOPLISTPATH = File.join("#{CHROMEPATH}", 'Contents/Info.plist')
	KSADMIN = "/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/MacOS/ksadmin"
	BRANDPATH = "/Library/Google/Google Chrome Brand.plist"
	BRANDKEY = "KSBrandID"
	TAGPATH = INFOPLISTPATH
	TAGKEY = "KSChannelID"
	VERSIONPATH = INFOPLISTPATH
	VERSIONKEY = "KSVersion"

	def self.is_chrome_installed
		if File.exist?("#{CHROMEPATH}")
			return true
		else
			return abort("Chrome is not installed")
		end
	end

	def self.chrome_version
		plist = CFPropertyList::List.new(:file => "#{INFOPLISTPATH}")
		results = CFPropertyList.native_types(plist.value)
		return results['CFBundleShortVersionString']
	end


	def self.update_url
		plist = CFPropertyList::List.new(:file => "#{INFOPLISTPATH}")
		results = CFPropertyList.native_types(plist.value)
		return results['KSUpdateURL']
	end

	def self.product_id
		plist = CFPropertyList::List.new(:file => "#{INFOPLISTPATH}")
		results = CFPropertyList.native_types(plist.value)
		return results['KSProductID']
	end

	def self.keystone_registration_path
		keystone_registration = File.join("#{CHROMEPATH}", 'Contents/Versions')
		keystone_registration = File.join("#{keystone_registration}", "#{chrome_version}")
		keystone_registration = File.join("#{keystone_registration}", "Google Chrome Framework.framework")
		keystone_registration = File.join("#{keystone_registration}", "Frameworks/KeystoneRegistration.framework")
	end

	def self.keystone_install
		ksinstall = File.join("#{keystone_registration_path}", "Resources/ksinstall")
		keystone_pkg = File.join("#{keystone_registration_path}", "Resources/Keystone.tbz")

		command = [
			"'#{ksinstall}'",
			"--install",
			"'#{keystone_pkg}'",
			"--force",
			"2>/dev/null"]

		system("#{command.join(" ")}")
	end

	def self.keystone_delete
		ksinstall = File.join("#{keystone_registration_path}", "Resources/ksinstall")
		command = [
			"'#{ksinstall}'",
			"--delete",
			"--productid",	"#{product_id}",
			"2>/dev/null"]
		system("#{command.join(" ")}")
	end

	def self.keystone_register
		 command = [
		 	"'#{KSADMIN}'",
		 	"--register",
		 	"--preserve-tttoken",
		 	"--productid",			"'#{product_id}'",
		 	"--version",			"'#{chrome_version}'",
		 	"--xcpath",				"'#{CHROMEPATH}'",
		 	"--url",				"'#{update_url}'",
		 	"--tag-path",			"'#{TAGPATH}'",
		 	"--tag-key", 			"'#{TAGKEY}'",
		 	"--brand-path", 		"'#{BRANDPATH}'",
		 	"--brand-key",			"'#{BRANDKEY}'",
		 	"--version-path", 		"'#{VERSIONPATH}'",
		 	"--version-key", 		"'#{VERSIONKEY}'",
		 	"2>/dev/null"]

		 system("#{command.join(" ")}")
	end

end


#==============================================
#run commands

#if chrome is not installed exit
ChromeAutoUpdate.is_chrome_installed

#install current keystone to /Library/Google
ChromeAutoUpdate.keystone_install

#delete any current keystone tickets
ChromeAutoUpdate.keystone_delete

#registor for a a new keysonte ticket
ChromeAutoUpdate.keystone_register



