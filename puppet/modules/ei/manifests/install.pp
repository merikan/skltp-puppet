class ei::install {
  require ei::params
  require mule
  include mule::params

  # common ei config file
  file {"${mule::params::install_dir}/conf/ei-config-override.properties":
    source => "/vagrant/puppet/modules/ei/files/config/ei-config-override.properties",
    recurse => false,
    owner  => "mule",
    group  => "mule",
    mode   => 755,
    notify  => Service["${mule::params::service_name}"],
  } ->

  # ei-frontend directory
  file {"${mule::params::mule_home}/apps/skltp-ei-application-mule-frontend-app-${ei::params::version}":
    ensure => "directory",
    owner  => "mule",
    group  => "mule",
    mode   => 755,
  } ->

  # extract ei-frontend
  exec { "ei-frontend" : 
    command => "/usr/bin/unzip -u -o /vagrant/puppet/files/skltp-ei-application-mule-frontend-app-${ei::params::version}.zip",
    cwd => "${mule::params::mule_home}/apps/skltp-ei-application-mule-frontend-app-${ei::params::version}",
    group  => "mule",
    require => File["${mule::params::mule_home}/apps/skltp-ei-application-mule-frontend-app-${ei::params::version}"],
    notify  => Service["${mule::params::service_name}"],
  } ->

  # ei-backend directory
  file {"${mule::params::mule_home}/apps/skltp-ei-application-mule-backend-app-${ei::params::version}":
    ensure => "directory",
    owner  => "mule",
    group  => "mule",
    mode   => 755,
  } ->

  # extract ei-backend
  exec { "ei-backend" : 
    command => "/usr/bin/unzip -u -o /vagrant/puppet/files/skltp-ei-application-mule-backend-app-${ei::params::version}.zip",
    cwd => "${mule::params::mule_home}/apps/skltp-ei-application-mule-backend-app-${ei::params::version}",
    group  => "mule",
    require => File["${mule::params::mule_home}/apps/skltp-ei-application-mule-backend-app-${ei::params::version}"],
    notify  => Service["${mule::params::service_name}"],
  }

}