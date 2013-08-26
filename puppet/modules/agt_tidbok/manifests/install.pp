class agt_tidbok::install {
  require agt_tidbok::params
  require mule
  include mule::params

  # common agt_tidbok config file
  file {"${mule::params::install_dir}/conf/GetAggregatedSubjectOfCareSchedule-config-override.properties":
    source => "/vagrant/puppet/modules/agt_tidbok/files/config/GetAggregatedSubjectOfCareSchedule-config-override.properties",
    recurse => false,
    owner  => "mule",
    group  => "mule",
    mode   => 755,
  } ->

  # agt_tidbok directory
  file {"${mule::params::mule_home}/apps/GetAggregatedSubjectOfCareSchedule-${agt_tidbok::params::version}":
    ensure => "directory",
    owner  => "mule",
    group  => "mule",
    mode   => 755,
  } ->

  # extract agt_tidbok
  exec { "agt_tidbok_unzip" : 
    command => "/usr/bin/unzip -u -o /vagrant/puppet/files/GetAggregatedSubjectOfCareSchedule-${agt_tidbok::params::version}.zip",
    cwd => "${mule::params::mule_home}/apps/GetAggregatedSubjectOfCareSchedule-${agt_tidbok::params::version}",
    group  => "mule",
    require => File["${mule::params::mule_home}/apps/GetAggregatedSubjectOfCareSchedule-${agt_tidbok::params::version}"]
  }

}