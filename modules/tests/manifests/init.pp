class tests {
    package { "patch":
      ensure => installed,
      require => Class["system"]
    } ->
    file { "/usr/local/sbin/restart_apache.sh":
      ensure => file,
      content => template('tests/restart_apache.sh.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '755',
    } ~>
    file { "/usr/local/sbin/rootlaunch":
      ensure => file,
      content => template('tests/rootlaunch.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '755',
    } ~>
    file { "/usr/local/etc/configfile.rootlaunch":
      ensure => file,
      content => template('tests/configfile.rootlaunch.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    }
}