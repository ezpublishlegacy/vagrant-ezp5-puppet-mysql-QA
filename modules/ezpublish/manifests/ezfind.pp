class ezpublish::ezfind {
    package { "java-1.7.0-openjdk.x86_64":
      ensure => installed,
      require => Class["system"]
    }
}