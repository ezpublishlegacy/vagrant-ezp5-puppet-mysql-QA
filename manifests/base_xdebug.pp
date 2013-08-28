include ntpd
include ssh
include apachephp
include db
include createdb
include apc
include xdebug
include imagick
include ezfind
include virtualhosts
include firewall
include composer
include prepareezpublish
include motd
include addhosts
include addtostartup
include git
include vncserver
include seleniumserver
include svn
include ftp
include tests
include ezsi

class ntpd {
    package { "ntpdate.x86_64": 
      ensure => installed 
    }
    service { "ntpd":
      ensure => running,
    }
}

class motd {
    file    {'/etc/motd':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/motd/motd.xdebug.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    }
}

class git {
    package { "git":
      ensure => installed,
    }
}

class svn {
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
      content => template('/tmp/vagrant-puppet/manifests/svn/config.erb'),
      owner   => 'vagrant',
      group   => 'vagrant',
      mode    => '750',
    }
}

class ssh {
    file { "/etc/ssh/sshd_config":
      ensure => file,
      content => template('/tmp/vagrant-puppet/manifests/ssh/sshd_config.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    }
}

class ftp {
    $neededpackages = ["vsftpd", "ftp"]
    package { $neededpackages:
      ensure => installed,
    } ~>
    exec { "chkconfig vsftp on":
      command => "/sbin/chkconfig vsftp on",
      path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
      returns => [ 0, 1, '', ' ']
    } ~>
    exec { "service vsftp start":
      command => "/sbin/service vsftp start",
      path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
      returns => [ 0, 1, '', ' ']
    } ~>
    exec { "setsebool -P ftp_home_dir=1":
      command => "/usr/sbin/setsebool -P ftp_home_dir=1",
      path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
      returns => [ 0, 1, '', ' ']
    } ~>
    service { "vsftpd":
      ensure => running,
      hasstatus => true,
      hasrestart => true,
      require => Package["vsftpd"],
      restart => true;
    }    
}

class ezsi {
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
      content => template('/tmp/vagrant-puppet/manifests/httpd/filter.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '640',
    }
}

class tests {
    package { "patch":
      ensure => installed,
    } ->
    file { "/usr/local/sbin/restart_apache.sh":
      ensure => file,
      content => template('/tmp/vagrant-puppet/manifests/tests/restart_apache.sh.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '755',
    } ~>
    file { "/usr/local/sbin/rootlaunch":
      ensure => file,
      content => template('/tmp/vagrant-puppet/manifests/tests/rootlaunch.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '755',
    } ~>
    file { "/usr/local/etc/configfile.rootlaunch":
      ensure => file,
      content => template('/tmp/vagrant-puppet/manifests/tests/configfile.rootlaunch.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    }
}

class vncserver {
    $neededpackages = [ "tigervnc", "tigervnc-server", "tigervnc-server-module", "xterm", "matchbox-window-manager", "firefox" ]
    package { $neededpackages:
      ensure => present,
    } ~>
    file { "/home/vagrant/.Xauthority":
      ensure => file,
      content => template('/tmp/vagrant-puppet/manifests/vncserver/Xauthority.erb'),
      owner  => "vagrant",
      group  => "vagrant",
      mode   => '750',  
    } ~>
    file { "/home/vagrant/.vnc":
      ensure => "directory",
      owner  => "vagrant",
      group  => "vagrant",
      mode   => '750',  
    } ~>
    file { "/home/vagrant/.vnc/xstartup":
      ensure => file,
      content => template('/tmp/vagrant-puppet/manifests/vncserver/xstartup.erb'),
      owner  => "vagrant",
      group  => "vagrant",
      mode   => '777',  
    }
}

class seleniumserver {
    exec { "create selenium folder":
      command => "/bin/mkdir /opt/selenium",
      path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
      returns => [ 0, 1, '', ' ']
    } ~>
    exec    { "wget":
      cwd     => "/opt/selenium",
      command => "/usr/bin/wget http://selenium.googlecode.com/files/selenium-server-standalone-2.5.0.jar",
      path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
      returns => [ 0, 1, '', ' ']
    } ~>
    file { "/usr/local/bin/start_seleniumrc.sh":
      ensure => file,
      content => template('/tmp/vagrant-puppet/manifests/selenium/start_seleniumrc.sh.erb'),
      mode   => '777',  
    } ~>
    exec    { "chmod":
      command => "/bin/chmod +x /user/local/bin/start_seleniumrc.sh",
      path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
      returns => [ 0, 1, '', ' ']
    } 
}

class apachephp {
    $neededpackages = [ "httpd", "php", "php-cli", "php-gd" ,"php-mysql", "php-pear", "php-xml", "php-mbstring", "php-pecl-apc", "php-process", "curl.x86_64" ]
    package { $neededpackages:
        ensure => present,
    } ~>
    file    {'/etc/httpd/conf.d/01.accept_pathinfo.conf':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/httpd/01.accept_pathinfo.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    } ~>
    file    {'/etc/php.d/php.ini':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/php/php.ini.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    } 
}

class imagick {
    $neededpackages = [ "ImageMagick", "ImageMagick-devel", "ImageMagick-perl" ]
    package { $neededpackages:
      ensure => installed
    }
    exec    { "update-channels":
      command => "pear update-channels",
      path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
      require => Package['php-pear'],
      returns => [ 0, 1, '', ' ']
    } ~>
    exec    { "install imagick":
      command => "pecl install imagick",
      path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
      require => Package['php-pear'],
      returns => [ 0, 1, '', ' ']
    }
}

class db {
    $neededpackages = [ "mysql", "mysql-server"]
    package { $neededpackages:
      ensure => installed
    }
    file    {'/etc/my.cnf':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/mysql/my.cnf.erb'),
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

 class apc {
    $neededpackages = [ "php-devel", "httpd-devel", "pcre-devel.x86_64", "php-pecl-apc.x86_64" ]
     package { $neededpackages:
       ensure => installed
    } ~>
   file    {'/etc/php.d/apc.ini':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/php/apc.ini.erb'),
    }
 }

class createdb {
    exec { "create-ezp-db":
      command => "/usr/bin/mysql -uroot -e \"create database ezp character set utf8; grant all on ezp.* to ezp@localhost identified by 'ezp';\"",
      require => Service["mysqld"],
      returns => [ 0, 1, '', ' ']
    }
}

class xdebug {
    exec    { "install xdebug":
      command => "pear install pecl/xdebug",
      path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
      require => Package['php-pear'],
      returns => [ 0, 1, '', ' ']
    }
    file    {'/etc/php.d/xdebug.ini':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/php/xdebug.ini.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
      require => Package["php"],
    }
}

class ezfind {
    package { "java-1.6.0-openjdk.x86_64":
      ensure => installed
    }
}

class virtualhosts {
    file    {'/etc/httpd/conf.d/02.namevirtualhost.conf':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/virtualhost/02.namevirtualhost.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
      require => Package["httpd"],
    }
    file    {'/etc/httpd/conf.d/ezp5.conf':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/virtualhost/ezp5.xdebug.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
      require => Package["httpd"],
    }
}

class firewall {
    file    {'/etc/sysconfig/iptables':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/iptables/iptables.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '600',
    }
    service { iptables:
      ensure => running,
      subscribe => File["/etc/sysconfig/iptables"],
    }
}

class composer {
    exec    { "get composer":
      command => "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin",
      path    => "/usr/local/bin:/usr/bin/",
      require => Package["httpd"],
      returns => [ 0, 1, '', ' ']
    } ~>
    exec    { "link composer":
      command => "/bin/ln -s /usr/local/bin/composer.phar /usr/local/bin/composer.phar",
      path    => "/usr/local/bin:/usr/bin/:/bin",
      returns => [ 0, 1, '', ' ']
    }
}

class prepareezpublish {
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

class addhosts {
    file    {'/etc/hosts':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/hosts/hosts.xdebug.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    }
}

class addtostartup {
    exec    { "add httpd to startup":
      command => "/sbin/chkconfig httpd on",
      path    => "/usr/local/bin/:/bin/",
      require => Package["httpd", "php", "php-cli", "php-gd" ,"php-mysql", "php-pear", "php-xml", "php-mbstring", "php-pecl-apc", "php-process", "curl.x86_64"]
    } ~>
    exec    { "add mysql to startup":
      command => "/sbin/chkconfig --add mysqld",
      path    => "/usr/local/bin/:/bin/",
      require => Package["httpd", "php", "php-cli", "php-gd" ,"php-mysql", "php-pear", "php-xml", "php-mbstring", "php-pecl-apc", "php-process", "curl.x86_64"]
    } ~>
    exec    { "add mysql":
      command => "/sbin/chkconfig mysqld on",
      path    => "/usr/local/bin/:/bin/",
      require => Package["httpd", "php", "php-cli", "php-gd" ,"php-mysql", "php-pear", "php-xml", "php-mbstring", "php-pecl-apc", "php-process", "curl.x86_64"]
    }
}
