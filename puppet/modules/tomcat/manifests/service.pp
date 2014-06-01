class tomcat::service {
  require tomcat::config
  

  case $::osfamily {
    'RedHat': {
      $add_service_command = "/sbin/chkconfig --add ${tomcat::params::service_name}"
    }
    'Debian': {
      $add_service_command = "/usr/sbin/update-rc.d ${tomcat::params::service_name} start 20 2 3 4 5 . stop 80 0 1 6 . "
    }
  }

  exec { "tomcat:add-service" : 
    command => $add_service_command,
    require => File["tomcat:service-file"]
  } ->
  service { "${tomcat::params::service_name}" : 
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus => false,
    require => Class["tomcat::install"]
  }

}