class tests::vncserver {
    $neededpackages = [ "tigervnc", "tigervnc-server", "tigervnc-server-module", "xterm", "matchbox-window-manager", "firefox" ]
    package { $neededpackages:
      ensure => present,
      require => Class["system"]
    } ~>
    file { "/home/vagrant/.Xauthority":
      ensure => file,
      content => template('tests/Xauthority.erb'),
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
      content => template('tests/xstartup.erb'),
      owner  => "vagrant",
      group  => "vagrant",
      mode   => '777',  
    }
}