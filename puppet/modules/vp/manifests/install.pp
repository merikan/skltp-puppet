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


  # Copy jar files for the demo log notifier to VP's lib folder
  # Depends on that the VP-app is in place
  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib/org.json-chargebee-1.0.jar":
    source => "/vagrant/puppet/files/org.json-chargebee-1.0.jar",
    owner  => "mule",
    group  => "mule",
    mode   => 644,
    require => [ Exec["vp-services"]]
  }
  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib/demo-ei-notify-publisher-1.0.0-SNAPSHOT.jar":
    source => "/vagrant/puppet/files/demo-ei-notify-publisher-1.0.0-SNAPSHOT.jar",
    owner  => "mule",
    group  => "mule",
    mode   => 644,
    require => [ Exec["vp-services"]]
  }
  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib/demo-log-publisher-1.0.0-SNAPSHOT.jar":
    source => "/vagrant/puppet/files/demo-log-publisher-1.0.0-SNAPSHOT.jar",
    owner  => "mule",
    group  => "mule",
    mode   => 644,
    require => [ Exec["vp-services"]]
  }
  # Copy virtual service for CRM - GetSubjectOfCareSchedule + IT-INTEGRATION EI + REGISTRY to VP's lib folder
  # Depends on that the VP-app is in place and that the virtual-services zip-file is unzipped
  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib/crm-scheduling-GetSubjectOfCareSchedule-virtualisering-1.1.jar":
    source => "/home/skltp/virtual-services/crm-scheduling-GetSubjectOfCareSchedule-virtualisering-1.1.jar",
    owner  => "mule",
    group  => "mule",
    mode   => 644,
    require => [ Exec["vp-services"], Exec["vp:unpack-vp-services-master"] ]
  }
  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib/itintegration-engagementindex-FindContent-virtualisering-1.0-RC10.jar":
    source => "/home/skltp/virtual-services/itintegration-engagementindex-FindContent-virtualisering-1.0-RC10.jar",
    owner  => "mule",
    group  => "mule",
    mode   => 644,
    require => [ Exec["vp-services"], Exec["vp:unpack-vp-services-master"] ]
  }
  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib/itintegration-engagementindex-GetUpdates-virtualisering-1.0-RC10.jar":
    source => "/home/skltp/virtual-services/itintegration-engagementindex-GetUpdates-virtualisering-1.0-RC10.jar",
    owner  => "mule",
    group  => "mule",
    mode   => 644,
    require => [ Exec["vp-services"], Exec["vp:unpack-vp-services-master"] ]
  }
  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib/itintegration-engagementindex-ProcessNotification-virtualisering-1.0-RC10.jar":
    source => "/home/skltp/virtual-services/itintegration-engagementindex-ProcessNotification-virtualisering-1.0-RC10.jar",
    owner  => "mule",
    group  => "mule",
    mode   => 644,
    require => [ Exec["vp-services"], Exec["vp:unpack-vp-services-master"] ]
  }
  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib/itintegration-engagementindex-Update-virtualisering-1.0-RC10.jar":
    source => "/home/skltp/virtual-services/itintegration-engagementindex-Update-virtualisering-1.0-RC10.jar",
    owner  => "mule",
    group  => "mule",
    mode   => 644,
    require => [ Exec["vp-services"], Exec["vp:unpack-vp-services-master"] ]
  }
  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib/itintegration-registry-GetLogicalAddresseesByServiceContract-virtualisering-1.1.jar":
    source => "/home/skltp/virtual-services/itintegration-registry-GetLogicalAddresseesByServiceContract-virtualisering-1.1.jar",
    owner  => "mule",
    group  => "mule",
    mode   => 644,
    require => [ Exec["vp-services"], Exec["vp:unpack-vp-services-master"] ]
  }
  file {"${mule::params::mule_home}/apps/vp-services-${vp::params::version}/lib/itintegration-registry-GetSupportedServiceContracts-virtualisering-1.1.jar":
    source => "/home/skltp/virtual-services/itintegration-registry-GetSupportedServiceContracts-virtualisering-1.1.jar",
    owner  => "mule",
    group  => "mule",
    mode   => 644,
    require => [ Exec["vp-services"], Exec["vp:unpack-vp-services-master"] ]
  }
}