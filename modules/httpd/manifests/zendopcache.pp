class httpd::zendopcache {
  $neededpackages = [ "php-devel" ]
  package { $neededpackages:
      ensure => installed  
  } ~>
  exec { "pecl install zendopcache":
      command => "printf '\n' | pecl install channel://pecl.php.net/ZendOpcache-7.0.3",
      path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
      require => Package['php-pear'],
      returns => [ 0, 1, '', ' ']
  } ~>
  file    {'/etc/php.d/zendopcache.ini':
    ensure  => file,
    content => template('httpd/zendopcache.ini.erb'),
  }
}