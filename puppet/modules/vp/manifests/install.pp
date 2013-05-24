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

#  file {"vp-services":
#    path   => "${mule::params::mule_home}/apps/vp-services-${vp::params::version}.zip",
#    source => "/vagrant/puppet/files/vp-services-${vp::params::version}.zip",
#    owner  => "mule",
#    group  => "mule",
#    mode   => 755,
#  }
  
  # unpack virtual services
  exec { "vp:unpack-vp-services-master" : 
    command => "/usr/bin/unzip -u -o /vagrant/puppet/files/vp-services-master.zip -d ${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib",
    group  => "mule",
    ##creates => "${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib/clinicalprocess-healthcond-actoutcome-GetDeliveryMedicalHistory-virtualisering-2.0-RC2.jar",
    require => Exec['vp-services'],
  }

  # test stub for samtycke
  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib/ehr-patientconsent-checkconsent-testproducer-1.0.0-SNAPSHOT.jar":
    source => "/vagrant/puppet/files/ehr-patientconsent-checkconsent-testproducer-1.0.0-SNAPSHOT.jar",
    owner  => "mule",
    group  => "mule",
    mode   => 644,
    require => Exec['vp-services'],
  }

}