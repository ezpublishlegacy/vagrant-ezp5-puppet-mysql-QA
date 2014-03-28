class system::ftp {
    $neededpackages = ["vsftpd", "ftp"]
    package { $neededpackages:
      ensure => installed,
      require => Class["system"]
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