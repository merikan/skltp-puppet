class jboss::install {

  group { "jboss": 
    ensure => present,
  } ->
  user { "jboss": 
    ensure => present,
    managehome => true,
    gid => "jboss",
    shell => "/bin/bash",
  } ->
  file {"${jboss::params::install_dir}":
    ensure => directory,
    recurse => true,
    owner => jboss,
    group => jboss,
  } ->
  exec { "jboss:unpack-dist": 
    command => "/bin/tar -xzf /vagrant/puppet/binaries/rivta-box/${jboss::params::dist_name} -C ${jboss::params::install_dir} --strip-components=1",
    user => jboss,
    creates => "${jboss::params::install_dir}/bin",
  }

}