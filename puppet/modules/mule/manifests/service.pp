class mule::service {
  
  exec { "mule:add-service": 
    command => "/sbin/chkconfig --add ${mule::params::service_name}",
    require => File["mule:service-file"]
  } ->
  service { "${mule::params::service_name}": 
    ensure => running,
    enable => true,
    status => "",
    hasstatus => false,
    require => Exec["mule:unpack-dist"],
  }

}