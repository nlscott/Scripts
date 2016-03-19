
 #set login window message
    property_list_key { 'LoginwindowText':
      ensure => present,
      path   => '/Library/Preferences/com.apple.loginwindow.plist',
      key    => 'LoginwindowText',
      value  => 'For support contact Helpline x5700',
    }