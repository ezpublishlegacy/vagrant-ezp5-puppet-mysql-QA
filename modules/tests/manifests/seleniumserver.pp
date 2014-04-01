class tests::seleniumserver {
    exec { "create selenium folder":
      command => "/bin/mkdir /opt/selenium",
      path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
      returns => [ 0, 1, '', ' '],
      require => Class["system"]
    } ~>
    exec    { "wget":
      cwd     => "/opt/selenium",
      command => "/usr/bin/wget http://selenium-release.storage.googleapis.com/2.41/selenium-server-standalone-2.41.0.jar",
      path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
      returns => [ 0, 1, '', ' ']
    } ~>
    file { "/usr/local/bin/start_seleniumrc.sh":
      ensure => file,
      content => template('tests/start_seleniumrc.sh.erb'),
      mode   => '777',  
    } ~>
    exec    { "chmod":
      command => "/bin/chmod +x /user/local/bin/start_seleniumrc.sh",
      path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
      returns => [ 0, 1, '', ' ']
    } 
}