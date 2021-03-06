
class tomcat::config {
  require tomcat::install

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
  file {"tomcat:tomcat-users.xml":
    path => "${tomcat::params::tomcat_home}/conf/tomcat-users.xml",
    source => "/vagrant/puppet/modules/tomcat/files/tomcat-users.xml",
    owner => 'tomcat',
    group => 'tomcat',
    notify  => Service["${tomcat::params::service_name}"],
  }
  file {"tomcat:setenv.sh":
    path => "${tomcat::params::tomcat_home}/bin/setenv.sh",
    source => "/vagrant/puppet/modules/tomcat/files/setenv.sh",
    owner => 'tomcat',
    group => 'tomcat',
    notify  => Service["${tomcat::params::service_name}"],
  }
  file {"tomcat:${tomcat::params::mysql_connector}":
    path => "${tomcat::params::tomcat_home}/lib/${tomcat::params::mysql_connector}",
    source => "/vagrant/puppet/binaries/rivta-box/${tomcat::params::mysql_connector}",
    owner => 'tomcat',
    group => 'tomcat',
    notify  => Service["${tomcat::params::service_name}"],
  }
}