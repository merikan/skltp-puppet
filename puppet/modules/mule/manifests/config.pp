class mule::config {

  require mule::install

  file {"mule:service-file":
    path => "/etc/init.d/${mule::params::service_name}",
    target => "${mule::params::install_dir}/bin/mule",
    ensure => link,
  }
  replace { "mule:replace_chkconfig":
    file => "${mule::params::install_dir}/bin/mule",
    pattern => "# chkconfig: 2345 20 80",
    replacement => "# chkconfig: 2345 80 60"
  } ->
  replace { "mule:replace_run_as_user":
    file => "${mule::params::install_dir}/bin/mule",
    pattern => "#RUN_AS_USER=",
    replacement => "RUN_AS_USER=mule"
  } ->
  file {"mule:wrapper.conf":
    path => "${mule::params::install_dir}conf/wrapper.conf",
    target => "/vagrant/puppet/modules/vp/files/wrapper.conf",
    notify  => Service["${mule::params::service_name}"],
  }
}