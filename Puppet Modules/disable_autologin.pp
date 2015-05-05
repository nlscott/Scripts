class disable_autologin {

	exec { "disable_autologin":
  		path   => ["/usr/bin", "/usr/sbin", "/bin", "/sbin"],
  		command => "sudo defaults delete /library/preferences/com.apple.loginwindow autoLoginUser",
		unless => "[ -z `sudo defaults read /library/preferences/com.apple.loginwindow autoLoginUser` ] >/dev/null"
		}

include disable_autologin