class httpd::apc {
    $neededpackages = [ "php-devel", "httpd-devel", "pcre-devel.x86_64"]
        package { $neededpackages:
        ensure => installed
    } ~>
    exec { "pecl install apc":
        command => "printf '\n' | pecl install apc",
        path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
        require => Package['php-pear'],
        returns => [ 0, 1, '', ' ']
    } ~>
    file    {'/etc/php.d/apc.ini':
        ensure  => file,
        content => template('httpd/apc.ini.erb'),
    }
}