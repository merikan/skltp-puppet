
class tomcat::config {
  
  file {"tomcat:service-file":
    path => '/etc/init.d/tomcat7',
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => '755',
    content => template("tomcat/tomcat.init.d.rb"),
    require => Class["tomcat::install"],
    notify => Class["tomcat::service"],
  }

}