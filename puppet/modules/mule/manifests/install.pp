class mule::install {

  group { "mule": 
    ensure => present,
  } ->
  user { "mule": 
    ensure => present,
    managehome => true,
    gid => "mule",
    shell => "/bin/bash",
  } ->
  file {"${mule::params::install_dir}":
    ensure => directory,
    recurse => true,
    owner => mule,
    group => mule,
  } ->
  exec { "mule:unpack-dist": 
    command => "/bin/tar -xzf /vagrant/puppet/files/${mule::params::package_name} -C ${mule::params::install_dir} --strip-components=1",
    user => mule,
    creates => "${mule::params::install_dir}/bin",
  }

}