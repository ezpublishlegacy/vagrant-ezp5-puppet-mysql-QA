class system::addtostartup {
    exec    { "add httpd to startup":
      command => "/sbin/chkconfig httpd on",
      path    => "/usr/local/bin/:/bin/",
      require => Package["httpd", "php", "php-cli", "php-gd" ,"php-mysql", "php-pear", "php-xml", "php-mbstring", "php-process", "curl.x86_64"]
    } ~>
    exec    { "add mariadb to startup":
      command => "/usr/bin/systemctl enable mariadb.service",
      path    => "/usr/local/bin/:/bin/",
      require => Package["httpd", "php", "php-cli", "php-gd" ,"php-mysql", "php-pear", "php-xml", "php-mbstring", "php-process", "curl.x86_64"]
    } ~>
    exec    { "start mariadb":
      command => "/usr/bin/systemctl start mariadb.service",
      path    => "/usr/local/bin/:/bin/",
      require => Package["httpd", "php", "php-cli", "php-gd" ,"php-mysql", "php-pear", "php-xml", "php-mbstring", "php-process", "curl.x86_64"]
    }
}