class ezpublish {
    service { 'httpd':
      ensure => running,
      enable => true,
      require => [File['/etc/httpd/conf.d/01.accept_pathinfo.conf'], File['/etc/httpd/conf.d/ezp5.conf']]
    } ~>    
    file { "/var/www/html":
      ensure => "directory",
      owner  => "vagrant",
      group  => "vagrant",
      mode   => '777',  
    }
}