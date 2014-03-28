class system::ssh {
    exec { "ssh-keygen":
        command => "ssh-keygen -f /home/vagrant/.ssh/id_rsa -N ''",
        path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        refreshonly => true,
        returns => [ 0, 1, 2, '', ' ']
    } ~>
    file { "/etc/ssh/sshd_config":
      ensure => file,
      content => template('system/sshd_config.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    }
}