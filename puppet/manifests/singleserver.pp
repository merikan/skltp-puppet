include singleserver

class singleserver {
  group { "skltp" : 
    ensure => present,
  } ->
  group { "admin" : 
    ensure => present,
  } ->
  file { "/etc/sudoers.d/@admin":
      content => '@admin        ALL=(ALL)       NOPASSWD: ALL',
    } ->
  user { "skltp" : 
    password => '$1$voPKKtHf$OGf4XU6vrjWFlbpOjKLoF/',
    ensure => present,
    managehome => true,
    gid => "skltp",
    groups => "admin",
    shell => "/bin/bash",
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