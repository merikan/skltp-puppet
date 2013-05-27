class tomcat::utils {

  define deploy($path) {
   
    #include tomcat::param
    #notice("Deploying http://$hostname:${tomcat::tomcat_port}/$name/")
   
    file { "$tomcat_home/webapps/${name}":
      owner => 'tomcat',
      source => $path,
    }
  }


  # use tomcat::utils::deploy
  #tomcat::deployment { "SimpleServlet":
  #  path => '/srv/puppet-tomcat-demo/java_src/SimpleServlet.war'
  #}

}