class system::ntpd {
    package { "ntp": 
      ensure => installed,
      require => Class["system"]
    }
    service { "ntpd":
      ensure => running,
    }
}