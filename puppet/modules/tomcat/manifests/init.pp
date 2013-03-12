class tomcat {
  #$tomcat::params::version = "7.0.33"
  #$tomcat::params::package_name = "apache-tomcat-${tomcat::params::version}"
  #$jtomcat::params::package_name = "/opt/tomcat/${tomcat::params::package_name}"

  include tomcat::params, tomcat::install, tomcat::config, tomcat::service
}