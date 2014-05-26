class tak::install {
  require tak::params
  require tomcat
  require unzip
  include tomcat::params

  exec { "deploy:tp-vagval-admin-services" :
    command => "/bin/cp \
                  ${tak::params::module_path}/files/tp-vagval-admin-services-${tak::params::version}.war \
                  ${tomcat::params::tomcat_home}/webapps/tp-vagval-admin-services.war",
    user => tomcat,
    creates => "${tomcat::params::tomcat_home}/webapps/tp-vagval-admin-services.war",
  } ->
  exec { "deploy:tp-vagval-admin-web" :
    command => "/bin/cp \
                  ${tak::params::module_path}/files/tp-vagval-admin-web-${tak::params::version}.war  \
                  ${tomcat::params::tomcat_home}/webapps/tp-vagval-admin-web.war",
    user => tomcat,
    creates => "${tomcat::params::tomcat_home}/webapps/tp-vagval-admin-web.war",
  }
}