class activemq::config {

   replace { "activemq:replace_chkconfig":
     file => "${activemq::params::install_dir}/bin/linux-x86-32/activemq",
     pattern => "# chkconfig: 2345 80 20",
     replacement => "# chkconfig: 2345 20 80"
   } ->
   replace { "activemq:replace_run_as_user":
     file => "${activemq::params::install_dir}/bin/linux-x86-32/activemq",
     pattern => "#RUN_AS_USER=",
     replacement => "RUN_AS_USER=activemq"
   } ->
   file {"activemq:service-file":
     path => "/etc/init.d/${activemq::params::service_name}",
     target => "${activemq::params::install_dir}/bin/linux-x86-32/activemq",
     ensure => "link",
     require => Exec["activemq:unpack-dist"],
  } ->
  file {"activemq:config-file":
    path => "${activemq::params::install_dir}/conf/activemq.xml",
    target => "/vagrant/puppet/modules/activemq/files/config/activemq.xml",
    notify  => Service["${activemq::params::service_name}"],
  } 
}
