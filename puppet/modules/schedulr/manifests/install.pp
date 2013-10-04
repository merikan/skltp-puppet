class schedulr::install {
  require tomcat

  file {"/root/.grails":
    ensure => directory,
    recurse => false,
    owner => root,
    group => root,
  } ->

  file {"/root/.grails/Schedulr-config.groovy":
    source => "/vagrant/puppet/modules/schedulr/files/Schedulr-config.groovy",
    owner  => "root",
    group  => "root",
  } ->

  file {"${tomcat::params::tomcat_home}/webapps/${schedulr::params::distname}":
    source => "/vagrant/puppet/files/${schedulr::params::distname}",
    ensure => file,
    owner => "tomcat",
    group => "tomcat",
  }
}