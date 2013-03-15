class jboss::install {

  group { "jboss": 
    ensure => present,
  } ->
  user { "jboss": 
    ensure => present,
    gid => "jboss",
    managehome => false,
    shell => "/bin/bash",
  } ->
  file {"${jboss::params::install_dir}":
    ensure => directory,
    recurse => true,
    owner => jboss,
    group => jboss,
  } ->
  exec { "jboss:unpack-dist": 
    command => "/bin/tar -xzf /vagrant/puppet/files/${jboss::params::dist_name} -C ${jboss::params::install_dir} --strip-components=1",
    user => jboss,
    creates => "${jboss::params::install_dir}/bin",
  }

}