class system::git {
    package { "git":
      ensure => installed,
      require => Class["system"]
    }
}