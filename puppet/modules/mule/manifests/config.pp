class mule::config {

   file {"mule:service-file":
     path => "/etc/init.d/${mule::params::service_name}",
     target => "${mule::params::install_dir}/bin/mule",
     ensure => link,
     require => Exec["mule:unpack-dist"],
   } ->
   replace { "replace_chkconfig":
     file => "/etc/init.d/${mule::params::service_name}",
     pattern => "# chkconfig: 2345 20 80",
     replacement => "# chkconfig: 2345 80 60"
   } ->
   replace { "replace_run_as_user":
     file => "/etc/init.d/${mule::params::service_name}",
     pattern => "#RUN_AS_USER=",
     replacement => "RUN_AS_USER=mule"
   } 
 }