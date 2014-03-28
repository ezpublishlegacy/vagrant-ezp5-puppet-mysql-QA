class system::svn {
    package { "subversion":
      ensure => installed,
    } ~>
    file { "/home/vagrant/.subversion":
      ensure => "directory",
      owner  => "vagrant",
      group  => "vagrant",
      mode   => '750',  
    } 
    file { "/home/vagrant/.subversion/config":
      ensure => file,
      content => template('system/config.erb'),
      owner   => 'vagrant',
      group   => 'vagrant',
      mode    => '750',
    }
}