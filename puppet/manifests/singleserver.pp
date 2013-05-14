
  group { "skltp" : 
    ensure => present,
  } ->
  user { "skltp" : 
    password => '$1$voPKKtHf$OGf4XU6vrjWFlbpOjKLoF/',
    ensure => present,
    managehome => true,
    gid => "skltp",
    shell => "/bin/bash",
  } 


include base

include iptables::disable
include java
include activemq 
#include mule 
include tomcat
include mysql
include tak::database
include tak
#include vp



