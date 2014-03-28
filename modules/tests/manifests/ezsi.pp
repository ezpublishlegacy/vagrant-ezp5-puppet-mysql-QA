class tests::ezsi {
    user { "esitest":
      comment => "Creating user esitest",
      home => "/home/esitest",
      ensure => present,
      shell => "/bin/bash",
    } ~>
    file { "/home/esitest":
      ensure => "directory",
      owner  => "esitest",
      group  => "esitest",
      mode   => '750',  
    }    
    file { "/etc/httpd/conf.d/filter.conf":
      ensure => file,
      content => template('tests/filter.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '640',
      require => Package["httpd"]
    }
}