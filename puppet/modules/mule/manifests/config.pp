class mule::config {

  require mule::install

  file {"mule:lib-extra-files":
    path => "${mule::params::install_dir}/lib",
    source => "/vagrant/puppet/modules/mule/files/lib",
    recurse => true,
    owner => mule,
    group => mule,
    mode   => 755
  }

  file {"mule:service-file":
    path => "/etc/init.d/${mule::params::service_name}",
    target => "${mule::params::install_dir}/bin/mule",
    ensure => link,
  }
  replace { "mule:replace_chkconfig":
    file => "${mule::params::install_dir}/bin/mule",
    pattern => "# chkconfig: 2345 20 80",
    replacement => "# chkconfig: 2345 80 20"
  } ->
  replace { "mule:replace_run_as_user":
    file => "${mule::params::install_dir}/bin/mule",
    pattern => "#RUN_AS_USER=",
    replacement => "RUN_AS_USER=mule"
  } ->
  file {"mule:wrapper.conf":
    path => "${mule::params::install_dir}/wrapper.conf",
    target => "/vagrant/puppet/modules/vp/files/wrapper.conf",
    notify  => Service["${mule::params::service_name}"],
  }
}