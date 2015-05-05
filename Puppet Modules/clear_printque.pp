class clear_printque {

	exec { "clear_printque":
  		path   => ["/usr/bin", "/usr/sbin", "/bin", "/sbin"],
  		command => "cancel -a -; cupsenable `lpstat -a | awk '{print $1}'`; echo $?",
		unless => "[ -z `lpstat -t | grep disabled | awk '{print $2}'` ];echo $? | grep 0 >/dev/null"
		}
	}

include clear_printque

