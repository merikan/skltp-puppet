class activemq::install {

  group { "activemq": 
    ensure => present,
  } ->
  user { "activemq": 
    ensure => present,
    gid => "activemq",
    managehome => false,
    shell => "/bin/bash",
  } ->
  file {"${activemq::params::install_dir}":
    ensure => directory,
    recurse => true,
    owner => activemq,
    group => activemq,
  } ->
  exec { "activemq:unpack-dist": 
    command => "/bin/tar -xzf /vagrant/puppet/files/${activemq::params::package_name} -C ${activemq::params::install_dir} --strip-components=1",
    user => activemq,
    creates => "${activemq::params::install_dir}/bin",
  }

}