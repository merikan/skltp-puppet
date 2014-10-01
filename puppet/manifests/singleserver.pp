include singleserver

class singleserver {
  include base
  include java
  include activemq 
  include mule 
  include tomcat
  include mysql
  include phpmyadmin
  include skltp-user
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

class skltp-user {
  
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
  file { ['/home/skltp/Pictures/', '/home/skltp/Desktop/']:
    ensure => "directory",
    owner  => "skltp",
    group  => "skltp",
    mode   => 644,
  } ->
  file {
    "/home/skltp/Pictures/eHalsa_green_white_cmyk-81.png":
    source => "/vagrant/puppet/files/users/skltp/inera-logo.png",
    owner => 'skltp',
    group => 'skltp',
    mode   => 644,    # rw-r--r--    
  } ->
  file {
    "/home/skltp/Desktop/gedit.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/gedit.desktop",
    owner => 'skltp',
    group => 'skltp',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/skltp/Desktop/gnome-terminal.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/gnome-terminal.desktop",
    owner => 'skltp',
    group => 'skltp',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/skltp/Desktop/gnome-nautilus-browser.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/gnome-nautilus-browser.desktop",
    owner => 'skltp',
    group => 'skltp',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/skltp/Desktop/mozilla-firefox.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/mozilla-firefox.desktop",
    owner => 'skltp',
    group => 'skltp',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/skltp/Desktop/soapUI.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/soapUI.desktop",
    owner => 'skltp',
    group => 'skltp',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/skltp/CareContactsGroovyImpl.groovy":
    source => "/vagrant/puppet/files/users/skltp/CareContactsGroovyImpl.groovy",
    owner => 'skltp',
    group => 'skltp',
    mode   => 744,    # rw-r--r--    
  } ->
  exec { "skltp-user:set-priv": 
    command => "/bin/chmod g+rx,o+rx /home/skltp"
  }
}