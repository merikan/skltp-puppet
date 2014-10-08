class agt_care_contacts::install {
  require agt_care_contacts::params
  require mule
  include mule::params

  # common agt_care_contacts config file
  file {"${mule::params::install_dir}/conf/GetAggregatedCareContacts-config-override.properties":
    source => "/vagrant/puppet/modules/agt_care_contacts/files/config/GetAggregatedCareContacts-config-override.properties",
    recurse => false,
    owner  => "mule",
    group  => "mule",
    mode   => 755,
  } ->

  # agt_care_contacts directory
  file {"${mule::params::mule_home}/apps/GetAggregatedCareContacts-${agt_care_contacts::params::version}":
    ensure => "directory",
    owner  => "mule",
    group  => "mule",
    mode   => 755,
  } ->

  # extract agt_care_contacts
  exec { "agt_care_contacts_unzip" : 
    command => "/usr/bin/unzip -u -o /vagrant/puppet/files/GetAggregatedCareContacts-${agt_care_contacts::params::version}.zip",
    cwd => "${mule::params::mule_home}/apps/GetAggregatedCareContacts-${agt_care_contacts::params::version}",
    group  => "mule",
    require => File["${mule::params::mule_home}/apps/GetAggregatedCareContacts-${agt_care_contacts::params::version}"]
  }

}