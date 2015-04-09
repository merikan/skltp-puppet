class tak::install {
  require tak::params
  require tomcat
  require unzip
  include tomcat::params

  exec { "deploy:tak-services" :
    command => "/bin/cp \
                /vagrant/puppet/files/tak-services-${tak::params::version}.war \
                ${tomcat::params::tomcat_home}/webapps/tak-services.war",
    user => tomcat,
    creates => "${tomcat::params::tomcat_home}/webapps/tak-services.war",
  } ->
  exec { "deploy:tak-web" :
    command => "/bin/cp \
                /vagrant/puppet/files/tak-web-${tak::params::version}.war  \
                ${tomcat::params::tomcat_home}/webapps/tak-web.war",
    user => tomcat,
    creates => "${tomcat::params::tomcat_home}/webapps/tak-web.war",
  }
}