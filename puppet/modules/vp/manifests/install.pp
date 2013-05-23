class vp::install {
  require vp::params

  file {"${mule::params::install_dir}/certs":
    source => "/vagrant/puppet/modules/vp/files/certs/",
    recurse => true,
    owner  => "mule",
    group  => "mule",
    mode   => 755,
  }

  file {"${mule::params::install_dir}/conf":
    source => "/vagrant/puppet/modules/vp/files/conf/",
    recurse => true,
    owner  => "mule",
    group  => "mule",
    mode   => 755,
  }

  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}.zip":
    source => "/vagrant/puppet/files/vp-services-${vp::params::version}.zip",
    owner  => "mule",
    group  => "mule",
    mode   => 755,
  }
}