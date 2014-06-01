class mule::service {
  require mule::config
  

  case $::osfamily {
    'RedHat': {
      $add_service_command = "/sbin/chkconfig --add ${mule::params::service_name}"
    }
    'Debian': {
      $add_service_command = "/usr/sbin/update-rc.d ${mule::params::service_name} start 20 2 3 4 5 . stop 80 0 1 6 . "
    }
  }

  exec { "mule:add-service": 
    command => $add_service_command,
    require => File["mule:service-file"]
  } ->
  service { "${mule::params::service_name}": 
    ensure => running,
    enable => true,
    hasstatus=> false,
    require => Exec["mule:unpack-dist"],
  }

}