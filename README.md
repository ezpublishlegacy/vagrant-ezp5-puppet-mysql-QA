# vagrant:ezp5:puppet:mariadb:centos7:QA

The Q.A. machine for eZ Publish 5.x, provisioned with Puppet.

## Stack & utilities:

- CentOS 7.0 x64
- Apache 2.4.6
- MariaDB 5.5.37
- PHP 5.4.16
- Zend Opcache 7.0.3
- Xdebug 2.2.5
- Composer
- Git
- VNCServer
- SeleniumServer 2.41
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
- You need to make a few changes in your personal xml configuration files:

```    
    - <siteaccesssettings matchorder="uri" adminhost="127.0.0.1">
```
- To run a filter use the command:
    - time php tests/runtests.php --dsn mysqli://ezp:ezp@localhost/ezp --db-per-test --configuration=extension/selenium/configs/<CONFIGURATION>.xml --filter="admin2.html"


## Environment Details:

```
MySQL:
  default database: ezp
  default db user: ezp
  default db user password: ezp

Apache/httpd:
  www root: /var/www/html/ezpublish5
```

## KNOWN LIMITATIONS

When you are running vagrant up, it will appear the following Warnings:

- Warning: Setting manifestdir is deprecated. See http://links.puppetlabs.com/env-settings-deprecations due to https://tickets.puppetlabs.com/browse/PUP-1433

- Warning: The package type's allow_virtual parameter will be changing its default value from false to true in a future release. If you do not want to allow virtual packages, please explicitly set allow_virtual to false. due to https://tickets.puppetlabs.com/browse/PUP-2650


## COPYRIGHT
Copyright (C) 1999-2014 eZ Systems AS. All rights reserved.

## LICENSE
http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
