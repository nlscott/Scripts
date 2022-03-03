#!/usr/bin/ruby

#---------------------------------------------------------------------------------------------------
# Tested on macOS: 12.2.1
# Tested with chrome version: 98.0.4758.109
# enables chrome auto updates for all users.
# run after installing chrome
# run with SUDO to install to /Library/Google
#---------------------------------------------------------------------------------------------------

require 'CFPropertyList'

module ChromeAutoUpdate
    CHROMEPATH = "/Applications/Google Chrome.app"
	INFOPLISTPATH = File.join("#{CHROMEPATH}", 'Contents/Info.plist')
	KSADMIN = "/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/MacOS/ksadmin"
	TAGPATH = INFOPLISTPATH
	TAGKEY = "KSChannelID"
    BRANDPATH = "/Library/Google/Google Chrome Brand.plist"
	BRANDKEY = "KSBrandID"
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
		keystone_registration = File.join("#{CHROMEPATH}", 'Contents/Frameworks')
		keystone_registration = File.join("#{keystone_registration}", "Google Chrome Framework.framework")
        keystone_registration = File.join("#{keystone_registration}", "Versions/#{chrome_version}")
		keystone_registration = File.join("#{keystone_registration}", "Frameworks/KeystoneRegistration.framework")
	end

	def self.keystone_install
		ksinstall = File.join("#{keystone_registration_path}", "Helpers/ksinstall")
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
		ksinstall = File.join("#{keystone_registration_path}", "Helpers/ksinstall")
		command = [
			"'#{ksinstall}'",
			"--nuke",
			"2>/dev/null"]
		system("#{command.join(" ")}")
	end

    def self.print_tickets
	    command = [
		 	"'#{KSADMIN}'",
		 	"--print-tickets"]
		system("#{command.join(" ")}")
	end

	def self.keystone_register
		 command = [
		 	"'#{KSADMIN}'",
		 	"--register",
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
            "--system-store",
		 	"2>/dev/null"]
		 system("#{command.join(" ")}")
	end

end


# Run Commands -------------------------------------------------------------------------------------

#Check if Chrome is installed
ChromeAutoUpdate.is_chrome_installed

#Check if Chrome is installed
# ChromeAutoUpdate.print_tickets

#Install current keystone to /Library/Google/GoogleSoftwareUpdate/TicketStore
ChromeAutoUpdate.keystone_install

# #delete any current keystone tickets
# ChromeAutoUpdate.keystone_delete

#register for a a new keystone ticket
ChromeAutoUpdate.keystone_register



