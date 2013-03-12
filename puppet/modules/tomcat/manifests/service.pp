class tomcat::service {
  
  exec { "add-service" : 
    command => "/sbin/chkconfig --add tomcat7",
    require => File["init.d-file"]
  }

  service { "tomcat7" : 
    ensure => running,
    enable => true,
    status => "",
    hasstatus => false,
    require => Exec["unpack-tomcat"],
  }

}