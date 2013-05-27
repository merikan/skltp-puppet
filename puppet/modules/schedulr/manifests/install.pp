class schedulr::install {
  require tomcat

  file {"${tomcat::params::tomcat_home}/webapps/${schedulr::params::distname}":
    source => "/vagrant/puppet/files/${schedulr::params::distname}",
    ensure => file,
    owner => "tomcat",
    group => "tomcat",
  }
}