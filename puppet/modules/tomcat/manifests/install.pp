class tomcat::install {

  #package { $tomcat::params::package_name:
  #  provider => rpm,
  #  ensure => installed,
  #  source => "/vagrant/puppet/files/${java::params::package_name}"
  #} 


group { "tomcat" : 
    ensure => present,
  } ->
  
  user { "tomcat" : 
    ensure => present,
    gid => "tomcat",
    managehome => false,
    shell => "/bin/bash",
  } ->

  file {"${tomcat::params::tomcat_home}":
    ensure => directory,
    recurse => true,
    owner => tomcat,
    group => tomcat,
  } ->

  exec { "unpack-tomcat" : 
    command => "/bin/tar -xzf /vagrant/puppet/files/${tomcat::params::package_name} -C ${tomcat::params::tomcat_home} --strip-components=1",
    user => tomcat,
    creates => "${tomcat::params::tomcat_home}/bin",
  }

}