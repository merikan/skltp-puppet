class tomcat::service {
  
  exec { "tomcat:add-service" : 
    command => "/sbin/chkconfig --add ${tomcat::params::service_name}",
    require => File["tomcat:service-file"]
  } ->
  service { "${tomcat::params::service_name}" : 
    ensure => running,
    enable => true,
    hasrestart => true,
    require => Class["tomcat::install"]
  }

}