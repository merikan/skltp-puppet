class tomcat {

  include tomcat::params, tomcat::install, tomcat::config, tomcat::service

  require  java


  # skall detta ligga i en egen manifestfil?
  define tomcat::deployment($path) {
 
    include tomcat
    notice("Establishing http://$hostname:${tomcat::tomcat_port}/$name/")
 
    file { "${tomcat::params::install_dir}/webapps/${name}.war":
      owner => 'root',
      source => $path,
    }
  }

  # use tomcat::deploy
  #tomcat::deployment { "SimpleServlet":
  #  path => '/srv/puppet-tomcat-demo/java_src/SimpleServlet.war'
  #}
}