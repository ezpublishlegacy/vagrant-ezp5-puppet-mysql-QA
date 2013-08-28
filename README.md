# vagrant:ezp5:puppet:mysql:QA

The Q.A. machine for eZ Publish 5.x, provisioned with Puppet.

## Stack & utilities:

- CentOS 6.4 x64
- Apache 2.2.15
- MySQL 5.1.69
- PHP 5.3.3
- APC 3.1.9
- Xdebug 2.2.3
- Composer
- Git
- VNCServer
- SeleniumServer
- SVN
- VSFTP
- Unzip
- Patch

## Requirements:

- Vagrant (http://vagrantup.com)
- VirtualBox (https://www.virtualbox.org/) or VMWare (http://www.vmware.com/)

## Getting started:

- Clone this project to a directory 
- Run `$ vagrant up` from the terminal
- Wait (the first time will take a few minutes, as the base box is downloaded, and required packages are installed for the first time), get some coffee.
- Done! `$ vagrant ssh` to SSH into your newly created machine. The MOTD contains details on the database, hostnames, etc.
- VNCServer uses port 5901, which is redirected to localhost. In order to use it, use the address localhost:1
- Don't forget to add you hostname to /etc/hosts file and the required virtualhosts
- To use ftp to execute ezsi tests, use localhost port 2121

## Environment Details:

```
MySQL:
  default database: ezp
  default db user: ezp
  default db user password: ezp

Apache/httpd:
  www root: /var/www/html/ezpublish5
```

Built @ [cleverti](http://www.cleverti.com) by Pedro Resende