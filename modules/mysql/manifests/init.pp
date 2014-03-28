class mysql {
    $neededpackages = [ "mysql", "mysql-server"]
    package { $neededpackages:
      ensure => installed,
      require => Class["system"]
    }
    file    {'/etc/my.cnf':
      ensure  => file,
      content => template('mysql/my.cnf.erb'),
      owner   => 'root',
      mode    => '644',
    }
    service { "mysqld":
      ensure => running,
      hasstatus => true,
      hasrestart => true,
      require => Package["mysql-server"],
      restart => true;
    }
}