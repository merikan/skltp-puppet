class jboss::config {

  file {"jboss:service-file":
     path => "/etc/init.d/${jboss::params::service_name}",
     target => "${jboss::params::install_dir}/bin/init.d/jboss-as-standalone.sh",
     ensure => "link",
     require => Exec["jboss:unpack-dist"],
   }

  file {"${jboss::params::install_dir}/bin/standalone.conf":
    owner => 'jboss',
    group => 'jboss',
    mode => '0755',
    content => template("jboss/standalone.conf.erb"),
    require => Class["jboss::install"],
    notify  => Service["${jboss::params::service_name}"],
  }
  file {"${jboss::params::install_dir}/standalone/configuration/standalone.xml":
    owner => 'jboss',
    group => 'jboss',
    mode => '0755',
    content => template("jboss/standalone.xml.erb"),
    require => Class["jboss::install"],
    notify  => Service["${jboss::params::service_name}"],
  }
  file {"/etc/jboss-as/":
    ensure => "directory",
  } ->
  file {"jboss:config":
    path => '/etc/jboss-as/jboss-as.conf',
    owner => 'jboss',
    group => 'jboss',
    mode => '0755',
    content => template("jboss/jboss-as.conf.erb"),
    require => Class["jboss::install"],
  }

 }