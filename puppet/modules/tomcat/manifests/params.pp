class tomcat::params {
    $version = "7.0.35"
    $service_name = "tomcat7"   
    $package_name = "apache-tomcat-${tomcat::params::version}.tar.gz"
    $install_dir = "/opt/tomcat-${tomcat::params::version}"
}
