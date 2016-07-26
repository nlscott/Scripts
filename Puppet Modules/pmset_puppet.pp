exec { "set_power_settings":
  		path   => ["/usr/bin", "/usr/sbin", "/bin", "/sbin"],
  		command => "pmset -c displaysleep 30 sleep 0 disksleep 0 womp 1 autorestart 1",
		unless => "pmset -g | awk '/ sleep/ && !/0/{print $2}' >dev/null"
		}