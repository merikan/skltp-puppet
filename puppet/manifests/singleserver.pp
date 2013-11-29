include singleserver

class singleserver {
  group { "skltp" : 
    ensure => present,
  } ->
  file { "/etc/sudoers.d/skltp":
    content => 'skltp        ALL=(ALL)       NOPASSWD: ALL',
    owner   => 'root',
    group  => 'root',
    mode    => '0440',
  } ->
  user { "skltp" : 
    password => '$1$voPKKtHf$OGf4XU6vrjWFlbpOjKLoF/',
    ensure => present,
    managehome => true,
    gid => "skltp",
    shell => "/bin/bash",
    } ->
  file {
    "/etc/sysconfig/keyboard":
    source => "/vagrant/puppet/files/cent-os-config/etc/sysconfig/keyboard",
    owner => 'root',
    group => 'root',
    mode   => 644,    # rw-r--r--    
  }

  include base

  include java
  include activemq 
  include mule 
  include tomcat
  include mysql
  include phpmyadmin
  include tak::database
  include tak
  include schedulr::database
  include schedulr
  include iptables::disable
  include apache
  include vp
  include crasch_mule
  include ei
  include ei::database
  include agt_tidbok
}