exec { "set_power_settings":
  		path   => ["/usr/bin", "/usr/sbin", "/bin", "/sbin"],
  		command => "pmset -c displaysleep 30 sleep 0 disksleep 0 womp 1 autorestart 1",
		unless => "pmset -g | grep -w sleep | awk '{print $2}' | grep -w 0 >/dev/null"
		}