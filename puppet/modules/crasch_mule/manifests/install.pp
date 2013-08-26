class crasch_mule::install {
  require crasch_mule::params
  require mule
  include mule::params

#  # common crasch_mule config file
#  file {"${mule::params::install_dir}/conf/crasch-config.properties":
#    source => "/vagrant/puppet/modules/crasch_mule/files/config/crasch-config.properties",
#    recurse => false,
#    owner  => "mule",
#    group  => "mule",
#    mode   => 755,
#  } ->

  # crasch_mule directory
  file {"${mule::params::mule_home}/apps/crash-mule-app":
    ensure => "directory",
    owner  => "mule",
    group  => "mule",
    mode   => 755,
  } ->

  # extract crasch_mule
  exec { "crasch_mule_unzip" : 
    command => "/usr/bin/unzip -u -o /vagrant/puppet/files/crash-${crasch_mule::params::version}-mule-app/crash-mule-app.zip",
    cwd => "${mule::params::mule_home}/apps/crash-mule-app",
    group  => "mule",
    require => File["${mule::params::mule_home}/apps/crash-mule-app"]
  }

}