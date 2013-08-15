class vp::install {
  require vp::params
  require mule
  include mule::params

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

  # vp-services directory
  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}":
    ensure => "directory",
    owner  => "mule",
    group  => "mule",
    mode   => 755,
  }
  # extract vp-services
  exec { "vp-services" : 
    command => "/usr/bin/unzip -u -o /vagrant/puppet/files/vp-services-${vp::params::version}.zip",
    cwd => "${mule::params::mule_home}/apps/vp-services-${vp::params::version}",
    group  => "mule",
    require => File["${mule::params::mule_home}/apps/vp-services-${vp::params::version}"]
  }

  # unpack virtual services
  exec { "vp:unpack-vp-services-master" : 
    command => "/usr/bin/unzip -u -o /vagrant/puppet/files/vp-services-master.zip -d /home/skltp/virtual-services/",
    group  => "skltp",
  }

  # unpack testproducers
  exec { "vp:unpack-test-producers" : 
    command => "/usr/bin/unzip -u -o /vagrant/puppet/files/test-producers.zip -d /home/skltp/test-producers/",
    group  => "skltp",
  }

}