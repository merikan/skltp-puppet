
class tomcat::config {
 
 #todo change rb to erb 
  file {"tomcat:service-file":
    path => '/etc/init.d/tomcat7',
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => '755',
    content => template("tomcat/tomcat.init.d.erb"),
    require => Class["tomcat::install"],
    notify => Class["tomcat::service"],
  }
  file {"tomcat:context.xml":
    path => "${tomcat::params::tomcat_home}/conf/context.xml",
    source => "/vagrant/puppet/modules/tomcat/files/context.xml",
    owner => 'tomcat',
    group => 'tomcat',
    notify  => Service["${tomcat::params::service_name}"],
  }
}