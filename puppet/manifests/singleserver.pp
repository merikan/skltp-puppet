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
    "/home/skltp/Pictures/eHalsa_green_white_cmyk-81.png":
    source => "/vagrant/puppet/files/users/skltp/eHalsa_green_white_cmyk-81.png",
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
    "/etc/sysconfig/keyboard":
    source => "/vagrant/puppet/files/cent-os-config/etc/sysconfig/keyboard",
    owner => 'root',
    group => 'root',
    mode   => 644,    # rw-r--r--    
  } ->
  exec { "gconftool-2":
    command => "/usr/bin/sudo -u skltp /usr/bin/gconftool-2 --load /vagrant/puppet/files/users/skltp/gconftool-2-dump.xml && touch /var/local/puppet::${title}::gconftool-2.semaphore",
    creates => "/var/local/puppet::${title}::gconftool-2.semaphore"
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