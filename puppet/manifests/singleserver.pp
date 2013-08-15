include singleserver

class singleserver {
  group { "skltp" : 
    ensure => present,
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
  include mule 
  include activemq 
  include tomcat
  include mysql
  include tak::database
  include tak
  include vp
  include schedulr
  include schedulr::database
  include iptables::disable
  include apache
}