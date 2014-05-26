class tomcat::params {
    $version = "7.0.35"
#    $version = "6.0.39"
    $service_name = "tomcat7"   
    $package_name = "apache-tomcat-${tomcat::params::version}.tar.gz"
    $install_dir = "/opt/tomcat-${tomcat::params::version}"
    $tomcat_home = $install_dir
    $mysql_connector = "mysql-connector-java-5.1.23-bin.jar"
}
