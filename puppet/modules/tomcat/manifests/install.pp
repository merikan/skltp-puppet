class tomcat::install {

  group { "tomcat" : 
    ensure => present,
  } ->
  user { "tomcat" : 
    ensure => present,
    managehome => true,
    gid => "tomcat",
    shell => "/bin/bash",
  } ->
  file {"${tomcat::params::install_dir}":
    ensure => directory,
    recurse => true,
    owner => tomcat,
    group => tomcat,
  } ->
  exec { "tomcat:unpack-dist" : 
    command => "/bin/tar -xzf /vagrant/puppet/files/${tomcat::params::package_name} -C ${tomcat::params::install_dir} --strip-components=1",
    user => tomcat,
    creates => "${tomcat::params::install_dir}/bin",
  }

}