class activemq::service {
  
  require activemq::config

  exec { "activemq:add-service": 
    command => "/sbin/chkconfig --add ${activemq::params::service_name}",
    require => File["activemq:service-file"]
  } ->
  service { "${activemq::params::service_name}": 
    ensure => running,
    enable => true,
    hasstatus => false,
    require => Exec["activemq:unpack-dist"],
  }

}