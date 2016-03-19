class firewall_on {

        #Turn Firewall ON
        property_list_key { 'globalstate':
                ensure => present,
                path   => '/Library/Preferences/com.apple.alf.plist',
                key    => 'globalstate',
                value  => '1',
                value_type      => 'integer',
                }
        #set permissions on plist
        file { '/Library/Preferences/com.apple.alf.plist':
                path    => '/Library/Preferences/com.apple.alf.plist',
                owner   => root,
                group   => wheel,
                mode    => 755,
                }
}

include firewall_on