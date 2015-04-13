class logstash {

  $version = "1.4.2"
  $service_name = "logstash-${version}"   
  $service_web_name = "logstash-web-${version}"   
  $package_name = "logstash-${version}.tar.gz"
  $contrib_name = "logstash-contrib-${version}.tar.gz"
  $install_dir = "/opt/logstash-${version}"
  $logstash_home = $install_dir

  group { "logstash": 
    ensure => present,
  } ->
  user { "logstash": 
    ensure => present,
    managehome => true,
    gid => "logstash",
    shell => "/bin/bash",
  } ->
  file {"${install_dir}":
    ensure => directory,
    recurse => true,
    owner => logstash,
    group => logstash,
  } ->
  exec { "unpack-dist": 
    command => "/bin/tar -xzf /vagrant/puppet/binaries/rivta-box/${package_name} -C ${install_dir} --strip-components=1",
    user => logstash,
    creates => "${install_dir}/bin",
  } ->

  # Rename the default dashboars to make Kibana start with a proper defult dashboard!
  # FIXME: replace exec /bin/mv so that we can use ${install_dir} isntead of hard coded /opt/logstash-1.4.2
  # ERROR: Error: Parameter path failed on File[${install_dir}/vendor/kibana/app/dashboards/logstash.json]: File paths must be fully qualified, not '${install_dir}/vendor/kibana/app/dashboards/logstash.json'
#  exec { '/bin/mv /opt/logstash-1.4.2/vendor/kibana/app/dashboards/logstash.json /opt/logstash-1.4.2/vendor/kibana/app/dashboards/default.json':
#    creates => '/opt/logstash-1.4.2/vendor/kibana/app/dashboards/default.json',
#  } ->
#  file { '/opt/logstash-1.4.2/vendor/kibana/app/dashboards/logstash.json':
#    ensure => absent,
#  } ->
  
  exec { "unpack-contrib": 
    command => "/bin/tar -xzf /vagrant/puppet/binaries/rivta-box/${contrib_name} -C ${install_dir} --strip-components=1",
    user => logstash,
  } ->
  file {"${install_dir}/config":
    source => "/vagrant/puppet/modules/logstash/files/config",
    recurse => true,
    owner => logstash,
    group => logstash,
    mode   => 755
  } ->
  file {"${install_dir}/init":
    source => "/vagrant/puppet/modules/logstash/files/init",
    recurse => true,
    owner => logstash,
    group => logstash
  } ->
  file {"${install_dir}/logs":
    ensure => directory,
    recurse => true,
    owner => logstash,
    group => logstash,
  } ->
  file {"service-file":
    path => "/etc/init.d/${service_name}",
    target => "${install_dir}/init/logstash",
    ensure => link,
  } ->
  file {"service-web-file":
    path => "/etc/init.d/${service_web_name}",
    target => "${install_dir}/init/logstash-web",
    ensure => link,
  } ->
#  case $::osfamily { 
#    'RedHat': {
#      $add_service_command = "/sbin/chkconfig --add ${service_name}"
#    }
#    'Debian': {
#      $add_service_command = "/usr/sbin/update-rc.d ${service_name} start 20 2 3 4 5 . stop 80 0 1 6 . "
#    }
#  } ->
#  case $::osfamily { 
#    'RedHat': {
#      $add_service_web_command = "/sbin/chkconfig --add ${service_web_name}"
#    }
#    'Debian': {
#      $add_service_web_command = "/usr/sbin/update-rc.d ${service_web_name} start 20 2 3 4 5 . stop 80 0 1 6 . "
#    }
#  } ->
  exec { "add-service": 
    command => "/sbin/chkconfig --add ${service_name}"
#    command => $add_service_command,
#    require => File["service-file"]
  } ->
  exec { "add-web-service": 
    command => "/sbin/chkconfig --add ${service_web_name}"
#    command => $add_service_web_command,
#    require => File["service-web-file"]
  } ->
  service { "${service_name}": 
    ensure => running,
    enable => true,
    hasstatus=> false
  } ->
  service { "${service_web_name}": 
    ensure => running,
    enable => true,
    hasstatus=> false
  }
}
