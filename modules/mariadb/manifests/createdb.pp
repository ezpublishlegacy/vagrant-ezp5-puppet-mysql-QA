class mariadb::createdb {
    exec { "create-ezp-db":
      command => "/usr/bin/mysql -uroot -e \"create database ezp character set utf8; grant all on ezp.* to ezp@localhost identified by 'ezp';\"",
      require => Service["mariadb"],
      returns => [ 0, 1, '', ' ']
    }
}