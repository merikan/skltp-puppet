class tomcat::params {
    $version = "7.0.35"   
    $package_name = "apache-tomcat-${tomcat::params::version}.tar.gz"
    $tomcat_home = "/opt/tomcat-${tomcat::params::version}"
}
