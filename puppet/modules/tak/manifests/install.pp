class tak::install {
  require tak::params
  require tomcat
  require unzip
  include tomcat::params

  exec { "unpack:${tak::params::distname}" : 
    command => "/usr/bin/unzip /vagrant/puppet/files/${tak::params::distname} -d /tmp",
    user => tomcat,
    creates => "${$tak::params::distribution_path}",
  } ->
  exec { "deploy:tp-vagval-admin-services" :
    command => "/bin/cp \
                  ${$tak::params::distribution_path}/webapps/tp-vagval-admin-services-${tak::params::version}.war \
                  ${tomcat::params::tomcat_home}/webapps",
    user => tomcat,
    creates => "${tomcat::params::tomcat_home}/webapps/tp-vagval-admin-services-${tak::params::version}.war",
  } ->
  exec { "deploy:tp-vagval-admin-web" :
    command => "/bin/cp \
                  ${$tak::params::distribution_path}/webapps/tp-vagval-admin-web-${tak::params::version}.war  \
                  ${tomcat::params::tomcat_home}/webapps/tp-vagval-admin-web.war",
    user => tomcat,
    creates => "${tomcat::params::tomcat_home}/webapps/tp-vagval-admin-web.war",
  } ->
  exec { "tak:copy_libs" :
    command => "/bin/cp \
                ${$tak::params::distribution_path}/lib/{itintegration-registry-schemas-1.0.0.jar,vagval-schemas-1.0.jar} \
                ${tomcat::params::tomcat_home}/lib/",
    user => tomcat,
    creates => "${tomcat::params::tomcat_home}/lib/{itintegration-registry-schemas-1.0.0.jar",
  }
}