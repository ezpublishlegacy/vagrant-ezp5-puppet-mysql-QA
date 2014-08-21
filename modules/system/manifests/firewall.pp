class system::firewall {
    package { "iptables-services":
      ensure => installed,
    } ~>
    file    {'/etc/sysconfig/iptables':
      ensure  => file,
      content => template('system/iptables.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '600',
      require => Class["system"]
    }
    service { iptables:
      ensure => running,
      subscribe => File["/etc/sysconfig/iptables"],
    }
}