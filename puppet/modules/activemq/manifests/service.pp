class activemq::service {
  
  require activemq::config

  case $::osfamily {
    'RedHat': {
      $add_service_command = "/sbin/chkconfig --add ${activemq::params::service_name}"
    }
    'Debian': {
      $add_service_command = "/usr/sbin/update-rc.d ${activemq::params::service_name} start 20 2 3 4 5 . stop 80 0 1 6 . "
    }
  }

  exec { "activemq:add_service": 
    command => $add_service_command,
    require => File["activemq:service-file"]
  } ->
  service { "${activemq::params::service_name}": 
    ensure => running,
    enable => true,
    hasstatus => false,
    require => Exec["activemq:unpack-dist"],
  }
}