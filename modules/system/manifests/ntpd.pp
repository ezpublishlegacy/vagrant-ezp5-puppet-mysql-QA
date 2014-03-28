class system::ntpd {
    package { "ntpdate.x86_64": 
      ensure => installed,
      require => Class["system"]
    }
    service { "ntpd":
      ensure => running,
    }
}