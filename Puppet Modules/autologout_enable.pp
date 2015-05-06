exec { "auto_logout":
  		path   => ["/usr/bin", "/usr/sbin", "/bin", "/sbin"],
  		command => "sudo defaults write /Library/Preferences/.GlobalPreferences com.apple.autologout.AutoLogOutDelay -int 3600",
		unless => "sudo defaults read /Library/Preferences/.GlobalPreferences com.apple.autologout.AutoLogOutDelay | grep -w 3600 >/dev/null" #3600 = 60 minutes
		}

		#This policey checks to see if the auto logout is turned on.
		#If it's not, the command turns it on and sets the idle time to 60 minutes

		#verified on 10.9