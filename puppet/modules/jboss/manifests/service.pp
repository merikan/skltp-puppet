class jboss::service {
  
  exec { "jboss:add-service": 
    command => "/sbin/chkconfig --add ${jboss::params::service_name}",
    require => File["jboss:service-file"]
  } ->
  exec { "jboss:runlevel": 
    command => "/sbin/chkconfig --level 2345 ${jboss::params::service_name} on",
    require => File["jboss:service-file"]
  } ->
  service { "${jboss::params::service_name}": 
    ensure => running,
    enable => true,
    require => Exec["jboss:unpack-dist"],
  }

}