class mariadb {
    $neededpackages = [ "mariadb", "mariadb-server"]
    package { $neededpackages:
      ensure      => installed,
      require     => Class["system"]
    } ~>
    service { "mariadb":
      ensure      => running,
      hasstatus   => true,
      hasrestart  => true,
      require     => Package["mariadb-server"],
      restart     => true;
    } ~>
    exec { 'Add Mariadb to Boot':
      command     => '/usr/bin/systemctl enable mariadb.service',
      path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    }
}