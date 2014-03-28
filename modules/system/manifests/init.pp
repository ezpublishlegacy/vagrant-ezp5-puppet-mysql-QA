class system {
    exec { 'yum update':
        command => '/usr/bin/yum update -y',
        returns => [0, 1]
    } ~>
    file    {'/home/vagrant/.bashrc':
      ensure  => file,
      content => template('system/bashrc.erb'),
      owner   => 'vagrant',
      group   => 'vagrant',
      mode    => '644',
    } 
}