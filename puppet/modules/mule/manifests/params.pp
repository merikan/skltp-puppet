class mule::params {
    $version = "3.3.1"
    $service_name = "mule-${version}"   
    $package_name = "mule-standalone-${version}.tar.gz"
    $install_dir = "/opt/mule-${version}"
    $mule_home = $install_dir
}
